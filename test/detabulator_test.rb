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

  def test_should_extract_blocks_of_different_lengths
    sample = sample_text <<-END
      a    bbb  c
      ddd  ee   ffff
    END
    expected = [["a", "bbb", "c"], ["ddd", "ee", "ffff"]]
    actual   = Detabulator.new.detabulate(sample)
    assert_equal expected, actual
  end

  def test_should_recognise_empty_columns
    sample = sample_text <<-END
      a    bbb  c
      ddd       eeee
    END
    expected = [["a", "bbb", "c"], ["ddd", "", "eeee"]]
    actual   = Detabulator.new.detabulate(sample)
    assert_equal expected, actual
  end

end
