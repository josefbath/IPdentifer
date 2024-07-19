import SwiftUI

struct PreferencesView: View {
    @AppStorage("preferredNumber") private var preferredNumber: String = "1"
    @AppStorage("useIPv6") private var useIPv6: Bool = true
    @AppStorage("showMenuBar") private var showMenuBar: Bool = true


    var body: some View {
        Form {
            Section(header: Text("General")) {
                TextField("Preferred Number", text: $preferredNumber)
                Toggle("Use IPv6", isOn: $useIPv6)
                Toggle("Display in Menu Bar", isOn: $showMenuBar)
            }
        }
        .padding()
        .frame(width: 300, height: 150)
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
