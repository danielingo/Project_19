import SwiftUI

struct AYImageButton: View {
    var systemName: String
    var label: String
    var action: () -> ()

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .accessibilityLabel(Text(label))
                .font(.title)
                accentColor(.main)
        }
    }
}