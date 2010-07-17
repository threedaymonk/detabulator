lib_path = File.expand_path("../../lib", __FILE__)
$:.unshift lib_path unless $:.include?(lib_path)
require "test/unit"
require "detabulator"

class DetabulatorTest < Test::Unit::TestCase

  def sample_text(s)
    first_line_indent = s[/^\s*/]
    s.gsub(/^#{first_line_indent}/, "")
  end

  def test_should_extract_simple_blocks
    sample = sample_text <<-END
      aa bb
      cc dd
    END
    expected = [["aa", "bb"], ["cc", "dd"]]
    actual   = Detabulator.new.detabulate(sample)
    assert_equal expected, actual
  end

end

