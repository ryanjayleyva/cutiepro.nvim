#!/usr/bin/env swift
// Generates CutiePro.terminal, a macOS Terminal.app profile for cutiepro.nvim.
// Usage: swift extras/terminal/generate.swift [output-path]
// Values mirror lua/cutiepro/palette.lua. Keep them in sync by hand.
import AppKit

func color(_ hex: String) -> Data {
	let v = UInt32(hex.dropFirst(), radix: 16)!
	let c = NSColor(
		srgbRed: CGFloat((v >> 16) & 0xff) / 255,
		green: CGFloat((v >> 8) & 0xff) / 255,
		blue: CGFloat(v & 0xff) / 255,
		alpha: 1)
	return try! NSKeyedArchiver.archivedData(withRootObject: c, requiringSecureCoding: false)
}

let ansiNames = ["Black", "Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White"]
let ansi = ["#000000", "#f56e7f", "#bec975", "#f58669", "#42d9c5", "#d286b7", "#37cb8a", "#88847f"]
let brights = ["#2e2a27", "#e5a1a3", "#e8d6a7", "#f3b061", "#80c5de", "#c3a6cb", "#9ed7a8", "#d7c3ba"]

var profile: [String: Any] = [
	"name": "CutiePro",
	"type": "Window Settings",
	"ProfileCurrentVersion": 2.07,
	"BackgroundColor": color("#181716"),
	"TextColor": color("#d5d0c9"),
	"TextBoldColor": color("#d7c3ba"),
	"CursorColor": color("#e5a1a3"),
	"SelectionColor": color("#383838"),
	"UseBrightBold": false,
]
for (i, n) in ansiNames.enumerated() {
	profile["ANSI\(n)Color"] = color(ansi[i])
	profile["ANSIBright\(n)Color"] = color(brights[i])
}

let out = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "CutiePro.terminal"
let data = try PropertyListSerialization.data(fromPropertyList: profile, format: .xml, options: 0)
try data.write(to: URL(fileURLWithPath: out))
print("wrote \(out)")
