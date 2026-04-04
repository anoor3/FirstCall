import Foundation
import AVFoundation

/// Lightweight percussive click generator using AVAudioEngine.
/// Produces a short "tuck" style transient with an exponential decay.
final class ClickPlayer {
    private let engine = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    private var buffer: AVAudioPCMBuffer?
    private var prepared = false

    init() {
        engine.attach(player)
        let outFormat = engine.outputNode.outputFormat(forBus: 0)
        engine.connect(player, to: engine.mainMixerNode, format: outFormat)
        createBuffer(sampleRate: outFormat.sampleRate, channels: outFormat.channelCount)
    }

    private func createBuffer(sampleRate: Double, channels: AVAudioChannelCount) {
        let sr = Float(sampleRate)
        // ~35ms click with quick attack and exponential decay
        let durationSeconds: Float = 0.035
        let frames = AVAudioFrameCount(durationSeconds * sr)
        let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: channels)!
        guard let buf = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frames) else { return }
        buf.frameLength = frames
        guard let chans = buf.floatChannelData else { return }
        let left = chans[0]

        // Tone: 1800 Hz with gentle noise overlay for "tap" character
        let freq: Float = 1800
        for i in 0..<Int(frames) {
            let t = Float(i) / sr
            // envelope: fast attack (3ms) then decay
            let attack: Float = 0.003
            let env: Float
            if t < attack { env = t / attack } else { env = expf(-6.0 * (t - attack) / (durationSeconds - attack)) }
            let tone = sinf(2.0 * .pi * freq * t)
            let noise = (Float.random(in: -1...1)) * 0.15
            left[i] = (tone * 0.6 + noise) * env * 0.7
        }

        // If stereo or more channels, copy left into others for consistency
        if channels > 1 {
            for ch in 1..<Int(channels) {
                let dst = chans[ch]
                for i in 0..<Int(frames) { dst[i] = left[i] }
            }
        }

        buffer = buf
    }

    func startEngineIfNeeded() {
        guard !prepared else { return }
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, options: [.mixWithOthers])
            try session.setActive(true, options: [])
            try engine.start()
            prepared = true
        } catch {
            prepared = false
        }
    }

    func stop() {
        player.stop()
        engine.pause()
        prepared = false
        try? AVAudioSession.sharedInstance().setActive(false, options: [.notifyOthersOnDeactivation])
    }

    func playClick() {
        startEngineIfNeeded()
        guard let buffer else { return }
        if !player.isPlaying { player.play() }
        player.scheduleBuffer(buffer, at: nil, options: .interrupts, completionHandler: nil)
    }
}
