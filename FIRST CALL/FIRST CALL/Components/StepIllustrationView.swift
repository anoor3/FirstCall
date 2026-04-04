import SwiftUI

struct StepIllustrationView: View {
    var name: String
    var alt: String
    var accent: Color

    var body: some View {
        Group {
            if let ui = loadBundleImage(named: name) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white)
                    Image(uiImage: ui)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.black.opacity(0.06), lineWidth: 1)
                )
                .frame(maxHeight: 180)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(alt)
            }
        }
    }

    // No built-in drawings or placeholders; only real assets are shown.

    private func loadBundleImage(named: String) -> UIImage? {
        if let img = UIImage(named: named) { return img }
        let candidates = nameVariants(for: named)
        let exts = ["png", "jpg", "jpeg"]
        for base in candidates {
            for ext in exts {
                if let path = Bundle.main.path(forResource: base, ofType: ext),
                   let img = UIImage(contentsOfFile: path) {
                    return img
                }
            }
        }
        return nil
    }

    private func nameVariants(for s: String) -> [String] {
        var out: [String] = []
        out.append(s)
        let trimmed = s.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed != s { out.append(trimmed) }
        let collapsed = trimmed.replacingOccurrences(of: #"\s+"#, with: " ", options: .regularExpression)
        if collapsed != trimmed { out.append(collapsed) }
        return Array(Set(out))
    }
}

#Preview {
    StepIllustrationView(name: "choking_back_blows", alt: "Back blows between the shoulder blades", accent: AppColors.breathingBlue)
        .padding()
        .background(AppColors.background)
        .preferredColorScheme(.dark)
}
