class Holstered < Formula
  desc "Hands your coding agent the right skill for each prompt"
  homepage "https://github.com/tupe12334/holstered"
  url "https://github.com/tupe12334/holstered/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "f6e33e74d3c5fb52cd463bb1ddd820b2b4b554c4d50bc38fcd49515f7e7eb37f"
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
