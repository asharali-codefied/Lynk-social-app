import Foundation

final class Environment {
    static let shared = Environment()
    private var values: [String: String] = [:]

    private init() {
        // Try to find .env in the main bundle
        guard let url = Bundle.main.url(forResource: ".env", withExtension: nil),
              let content = try? String(contentsOf: url, encoding: .utf8) else {
            print("⚠️ Could not load .env file from bundle.")
            return
        }

        content.split(separator: "\n").forEach { line in
            let pair = line.split(separator: "=", maxSplits: 1)
            if pair.count == 2 {
                let key = String(pair[0]).trimmingCharacters(in: .whitespaces)
                let value = String(pair[1]).trimmingCharacters(in: .whitespacesAndNewlines)
                values[key] = value
            }
        }
    }

    func get(_ key: String) -> String? {
        return values[key]
    }
}
