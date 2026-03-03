cask "scrcpy-buddy" do
  version "1.0.5"
  sha256 "REPLACE_ME_WITH_SHA256"

  url "https://github.com/Codertainment/scrcpy_buddy/releases/download/v#{version}/scrcpy buddy #{version}.dmg",
      verified: "github.com/Codertainment/scrcpy_buddy/"
  name "scrcpy buddy"
  desc "Clean, minimalist GUI wrapper for scrcpy"
  homepage "https://github.com/Codertainment/scrcpy_buddy"

  # Flutter produces a single universal binary; no arch-specific artifacts.
  depends_on macos: ">= :big_sur"

  app "scrcpy buddy.app"

  # Remove the macOS quarantine attribute so the app opens without Gatekeeper warnings.
  # Flutter-built apps are often unsigned/unnotarized, triggering the "damaged" prompt.
  preflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{staged_path}/scrcpy buddy.app"]
  end

  # Users still need adb and scrcpy available in PATH.
  caveats <<~EOS
    scrcpy buddy requires both `scrcpy` and `adb` to be installed and available in your PATH.
    You can install them with Homebrew:

      brew install scrcpy android-platform-tools

  EOS
end
