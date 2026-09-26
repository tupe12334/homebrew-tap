class Holstered < Formula
  desc "Hands your coding agent the right skill for each prompt"
  homepage "https://github.com/tupe12334/holstered"
  url "https://github.com/tupe12334/holstered/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "beff1e19f0334507813a3596f1b4cf66e7efe3c54dede5a29f7a09b16baaf074"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # A tool event never reaches the decision model; holstered approves it.
    event = '{"hook_event_name":"PreToolUse","tool_name":"Bash","tool_input":{"command":"ls"},"session_id":"s"}'
    assert_match '"permissionDecision":"allow"', pipe_output(bin/"holstered", event)
  end
end
