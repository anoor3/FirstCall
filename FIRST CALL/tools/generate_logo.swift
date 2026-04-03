import Foundation
import AppKit

struct LogoSpec {
    let size: CGFloat
    let outputURL: URL
}

func drawLogo(size: CGFloat) -> NSImage {
    let img = NSImage(size: NSSize(width: size, height: size))
    img.lockFocus()
    defer { img.unlockFocus() }

    let rect = CGRect(x: 0, y: 0, width: size, height: size)
    let ctx = NSGraphicsContext.current!.cgContext

    // Background: deep crimson gradient with subtle vignette
    let colorTop = NSColor(calibratedRed: 0.75, green: 0.10, blue: 0.16, alpha: 1)
    let colorBottom = NSColor(calibratedRed: 0.60, green: 0.06, blue: 0.12, alpha: 1)
    let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [colorTop.cgColor, colorBottom.cgColor] as CFArray, locations: [0,1])!
    ctx.drawLinearGradient(gradient, start: CGPoint(x: 0, y: size), end: CGPoint(x: 0, y: 0), options: [])

    // Rounded card inset for subtle depth
    let inset: CGFloat = size * 0.06
    let cardRect = rect.insetBy(dx: inset, dy: inset)
    let cardPath = NSBezierPath(roundedRect: cardRect, xRadius: size * 0.1, yRadius: size * 0.1)
    ctx.saveGState()
    ctx.setFillColor(NSColor(calibratedWhite: 1, alpha: 0.04).cgColor)
    ctx.addPath(cardPath.cgPath)
    ctx.fillPath()
    ctx.restoreGState()

    // Heart symbol centered
    let symbolConfig = NSImage.SymbolConfiguration(pointSize: size * 0.44, weight: .bold)
        .applying(.init(paletteColors: [.white]))
    if let heart = NSImage(systemSymbolName: "heart.fill", accessibilityDescription: nil)?.withSymbolConfiguration(symbolConfig) {
        let heartSize = heart.size
        let heartOrigin = CGPoint(x: (size - heartSize.width)/2, y: (size - heartSize.height)/2)
        heart.draw(at: heartOrigin, from: .zero, operation: .sourceOver, fraction: 1)
    }

    // Soft inner highlight
    ctx.saveGState()
    ctx.setBlendMode(.screen)
    ctx.setFillColor(NSColor.white.withAlphaComponent(0.08).cgColor)
    let highlight = NSBezierPath(ovalIn: CGRect(x: size*0.1, y: size*0.55, width: size*0.8, height: size*0.6))
    ctx.addPath(highlight.cgPath)
    ctx.fillPath()
    ctx.restoreGState()

    return img
}

func writePNG(_ image: NSImage, to url: URL) throws {
    guard let tiff = image.tiffRepresentation, let bitmap = NSBitmapImageRep(data: tiff), let data = bitmap.representation(using: .png, properties: [:]) else {
        throw NSError(domain: "LogoGen", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create PNG data"])
    }
    try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
    try data.write(to: url)
}

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let imageset = root.appendingPathComponent("FIRST CALL/Assets.xcassets/AppLogo.imageset")
let specs: [LogoSpec] = [
    .init(size: 1024, outputURL: imageset.appendingPathComponent("logo-1024.png")),
    .init(size: 512, outputURL: imageset.appendingPathComponent("logo-512.png")),
    .init(size: 256, outputURL: imageset.appendingPathComponent("logo-256.png"))
]

for spec in specs {
    let image = drawLogo(size: spec.size)
    try writePNG(image, to: spec.outputURL)
    fputs("Wrote \(spec.outputURL.path)\n", stderr)
}

// Write Contents.json for the imageset
let contents: [String: Any] = [
    "images": [
        ["filename": "logo-256.png", "idiom": "universal", "scale": "1x"],
        ["filename": "logo-512.png", "idiom": "universal", "scale": "2x"],
        ["filename": "logo-1024.png", "idiom": "universal", "scale": "3x"],
    ],
    "info": ["version": 1, "author": "xcode"]
]
let jsonURL = imageset.appendingPathComponent("Contents.json")
let data = try JSONSerialization.data(withJSONObject: contents, options: [.prettyPrinted, .sortedKeys])
try data.write(to: jsonURL)
fputs("Wrote \(jsonURL.path)\n", stderr)

