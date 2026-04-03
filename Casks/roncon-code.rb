cask "roncon-code" do
  version "0.4.0"
  sha256 "2c24b387b9eb87e5fdd2a5380ade6cf8fc403432f8f7b77d6b4f6552da656cdf"

  url "https://pub-0839d9eeded342a9934fdfd23bd2b649.r2.dev/v#{version}/roncon-code-macos-arm64.dmg"
  name "Roncon Code"
  desc "AI-powered CLI agent for software engineering"
  homepage "https://roncon-code.hypn.com.br"

  depends_on macos: ">= :big_sur"

  app "Roncon Code.app"

  binary "#{appdir}/Roncon Code.app/Contents/MacOS/roncon-code", target: "roncon-code"

  postflight do
    # Create roncon alias
    system_command "/bin/ln", args: ["-sf", "#{staged_path}/Roncon Code.app/Contents/MacOS/roncon-code", "/usr/local/bin/roncon"], sudo: false
  end

  uninstall delete: "/usr/local/bin/roncon-code",
            delete: "/usr/local/bin/roncon"

  zap trash: [
    "~/.roncon",
  ]

  caveats <<~EOS
    Roncon Code requires Ollama for local models:
      brew install ollama
      ollama pull qwen2.5:7b

    Run in terminal:
      roncon-code
      roncon-code --model ollama:qwen2.5:7b

    Or open "Roncon Code" from Applications.
  EOS
end
