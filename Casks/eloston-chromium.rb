cask "eloston-chromium" do
  arch = Hardware::CPU.intel? ? "x86-64" : "arm64"

  if Hardware::CPU.intel?
    version "99.0.4844.51-1.1,1646326921"
    sha256 "8f2c2630ee4dc22f4e273916a7d7e6e6eca046b93a62c1a4793d67ee9222acf5"
  else
    version "98.0.4758.109-1.1,1645734398"
    sha256 "ef8e963223e7467f1d7fd9c678707202219d403553ec83a9a96c2058d0166671"
  end

  url "https://github.com/kramred/ungoogled-chromium-macos/releases/download/#{version.csv.first}_#{arch}__#{version.csv.second}/ungoogled-chromium_#{version.csv.first}_#{arch}-macos.dmg",
      verified: "github.com/kramred/ungoogled-chromium-macos/"
  name "Ungoogled Chromium"
  desc "Google Chromium, sans integration with Google"
  homepage "https://ungoogled-software.github.io/ungoogled-chromium-binaries/"

  livecheck do
    url "https://github.com/kramred/ungoogled-chromium-macos/releases/"
    strategy :page_match do |page|
      match = page.match(%r{
        releases/download/(\d+(?:[.-]\d+)+)[._-]#{arch}[._-]{2}(\d+)/
        ungoogled[._-]chromium[._-](\d+(?:[.-]\d+)+)[._-]#{arch}[._-]macos\.dmg
      }xi)
      next if match.blank?

      "#{match[1]},#{match[2]}"
    end
  end

  conflicts_with cask: [
    "chromium",
    "freesmug-chromium",
  ]

  app "Chromium.app"

  zap trash: [
    "~/Library/Application Support/Chromium",
    "~/Library/Caches/Chromium",
    "~/Library/Preferences/org.chromium.Chromium.plist",
    "~/Library/Saved Application State/org.chromium.Chromium.savedState",
  ]
end
