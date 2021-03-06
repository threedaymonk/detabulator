# encoding: utf-8
lib_path = File.expand_path("../../lib", __FILE__)
$:.unshift lib_path unless $:.include?(lib_path)
require "test/unit"
require "detabulator"

class DetabulatorTest < Test::Unit::TestCase

  def sample_text(s)
    first_line_indent = s[/^\s*/]
    s.gsub(/^#{first_line_indent}/, "")
  end

  def detabulate(s)
    Detabulator.new.detabulate(s)
  end

  def test_should_extract_simple_blocks
    sample = sample_text <<-END
      aa bb
      cc dd
    END
    expected = [["aa", "bb"], ["cc", "dd"]]
    assert_equal expected, detabulate(sample)
  end

  def test_should_extract_blocks_of_different_lengths
    sample = sample_text <<-END
      a    bbb  c
      ddd  ee   ffff
    END
    expected = [["a", "bbb", "c"], ["ddd", "ee", "ffff"]]
    assert_equal expected, detabulate(sample)
  end

  def test_should_recognise_empty_columns
    sample = sample_text <<-END
      a    bbb  c
      ddd       eeee
    END
    expected = [["a", "bbb", "c"], ["ddd", "", "eeee"]]
    assert_equal expected, detabulate(sample)
  end

  def test_should_handle_trailing_empty_columns
    sample = sample_text <<-END
      aa bb
      cc
    END
    expected = [["aa", "bb"], ["cc", ""]]
    assert_equal expected, detabulate(sample)
  end

  def test_should_skip_large_gaps
    sample = sample_text <<-END
      aa         bb
      cc         dd
    END
    expected = [["aa", "bb"], ["cc", "dd"]]
    assert_equal expected, detabulate(sample)
  end

  def test_should_treat_a_codepoint_as_a_single_entity
    sample = sample_text <<-END
      £££ €€€
      aaa bbb
    END
    expected = [["£££", "€€€"], ["aaa", "bbb"]]
    assert_equal expected, detabulate(sample)
  end
end
