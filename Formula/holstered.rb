class Holstered < Formula
  desc "Hands your coding agent the right skill for each prompt"
  homepage "https://github.com/tupe12334/holstered"
  url "https://github.com/tupe12334/holstered/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "15351844dd2b5bb7a78a29a0e62fdfb522d349e1d04c6ad3243d1d608ec28da5"
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
