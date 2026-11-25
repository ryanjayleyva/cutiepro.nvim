-- macOS Terminal.app: a profile for import
--
-- Terminal.app stores each color as an archived NSColor. The archive holds the
-- color in sRGB and the sRGB color profile that the color is measured in, so
-- the profile is read from scripts/extras/srgb.icc, the same one AppKit
-- writes. The archives use the XML property list format, which AppKit reads
-- the same as the binary one.
local shared = require('extras.shared')
local palette = shared.palette
local theme = shared.theme

-- The names Terminal.app gives the 8 normal and the 8 bright terminal colors
local ansi_names =
	{ 'Black', 'Red', 'Green', 'Yellow', 'Blue', 'Magenta', 'Cyan', 'White' }

local profile_colors = {
	BackgroundColor = theme.background,
	TextColor = theme.foreground,
	TextBoldColor = palette.foreground_bright,
	CursorColor = theme.cursor,
	SelectionColor = theme.selection_background,
}
for index, name in ipairs(ansi_names) do
	profile_colors['ANSI' .. name .. 'Color'] = shared.terminal_colors[index]
	profile_colors['ANSIBright' .. name .. 'Color'] =
		shared.terminal_colors[index + 8]
end

-- Each row is one channel of Apple's Generic RGB, as a mix of the linear sRGB
-- channels. The rows sum to 1, so white stays white. They were fitted to the
-- colors AppKit archived, and match them to 1e-7.
local generic_rgb_from_srgb = {
	{ 0.9748595073, 0.0272937897, -0.0021534332 },
	{ -0.0200081083, 1.0542303335, -0.0342223055 },
	{ 0.0016837296, 0.0015554275, 0.9967607944 },
}
local generic_rgb_gamma = 1.8

-- The sRGB profile, shared by every color in the file
local srgb_profile =
	assert(shared.read_file(shared.repo_root .. '/scripts/extras/srgb.icc'))

-- '#e5a1a3' to the three sRGB channels, each from 0 to 1
local function srgb_channels(hex)
	local channels = {}
	for index = 1, 3 do
		local start = index * 2
		channels[index] = tonumber(hex:sub(start, start + 1), 16) / 255
	end
	return channels
end

local function linear_from_srgb(channel)
	if channel <= 0.04045 then
		return channel / 12.92
	end
	return ((channel + 0.055) / 1.055) ^ 2.4
end

-- The older NSRGB field, for readers that do not use the color profile.
-- AppKit on macOS reads NSComponents and ignores this one.
local function generic_rgb_channels(channels)
	local linear = vim.tbl_map(linear_from_srgb, channels)
	local generic = {}
	for row_index, row in ipairs(generic_rgb_from_srgb) do
		local mixed = 0
		for column_index, weight in ipairs(row) do
			mixed = mixed + weight * linear[column_index]
		end
		generic[row_index] = math.max(mixed, 0) ^ (1 / generic_rgb_gamma)
	end
	return generic
end

local function format_channels(channels)
	return table.concat(
		vim.tbl_map(function(channel)
			return ('%.10g'):format(channel)
		end, channels),
		' '
	)
end

local archive_template = [[
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>$archiver</key>
	<string>NSKeyedArchiver</string>
	<key>$objects</key>
	<array>
		<string>$null</string>
		<dict>
			<key>$class</key>
			<dict><key>CF$UID</key><integer>5</integer></dict>
			<key>NSColorSpace</key>
			<integer>1</integer>
			<key>NSComponents</key>
			<data>{{components}}</data>
			<key>NSCustomColorSpace</key>
			<dict><key>CF$UID</key><integer>2</integer></dict>
			<key>NSLinearExposure</key>
			<data>MQ==</data>
			<key>NSRGB</key>
			<data>{{generic_rgb}}</data>
		</dict>
		<dict>
			<key>$class</key>
			<dict><key>CF$UID</key><integer>4</integer></dict>
			<key>NSICC</key>
			<dict><key>CF$UID</key><integer>3</integer></dict>
			<key>NSID</key>
			<integer>7</integer>
		</dict>
		<data>{{profile}}</data>
		<dict>
			<key>$classes</key>
			<array><string>NSColorSpace</string><string>NSObject</string></array>
			<key>$classname</key>
			<string>NSColorSpace</string>
		</dict>
		<dict>
			<key>$classes</key>
			<array><string>NSColor</string><string>NSObject</string></array>
			<key>$classname</key>
			<string>NSColor</string>
		</dict>
	</array>
	<key>$top</key>
	<dict>
		<key>root</key>
		<dict><key>CF$UID</key><integer>1</integer></dict>
	</dict>
	<key>$version</key>
	<integer>100000</integer>
</dict>
</plist>
]]

local function archive_color(hex)
	local channels = srgb_channels(hex)
	local fields = {
		-- The fourth component is the alpha, which is always opaque
		components = vim.base64.encode(format_channels(channels) .. ' 1'),
		-- NSRGB is a C string, so it ends with a null byte
		generic_rgb = vim.base64.encode(
			format_channels(generic_rgb_channels(channels)) .. '\0'
		),
		profile = vim.base64.encode(srgb_profile),
	}
	return (
		archive_template:gsub('{{([%w_]+)}}', function(name)
			return assert(fields[name], 'archive template has no field ' .. name)
		end)
	)
end

-- A data element, with the base64 broken into lines like Terminal.app's own
local function data_lines(bytes)
	local encoded = vim.base64.encode(bytes)
	local lines = { '\t<data>' }
	for start = 1, #encoded, 68 do
		table.insert(lines, '\t' .. encoded:sub(start, start + 67))
	end
	table.insert(lines, '\t</data>')
	return lines
end

local function build_profile()
	local lines = {
		'<?xml version="1.0" encoding="UTF-8"?>',
		'<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">',
		'<plist version="1.0">',
		'<dict>',
	}

	-- Terminal.app lists the keys in alphabetical order
	local entries = {
		name = { '\t<string>CutiePro</string>' },
		type = { '\t<string>Window Settings</string>' },
		ProfileCurrentVersion = { '\t<real>2.07</real>' },
		UseBrightBold = { '\t<false/>' },
	}
	for key, hex in pairs(profile_colors) do
		entries[key] = data_lines(archive_color(hex))
	end

	for key, value_lines in vim.spairs(entries) do
		table.insert(lines, ('\t<key>%s</key>'):format(key))
		vim.list_extend(lines, value_lines)
	end

	vim.list_extend(lines, { '</dict>', '</plist>' })
	return shared.join_lines(lines)
end

return {
	['extras/terminal/CutiePro.terminal'] = build_profile(),
}
