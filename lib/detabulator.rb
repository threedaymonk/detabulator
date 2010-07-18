class Detabulator
  SPACE = 32

  def detabulate(s)
    lines   = s.split(/\n/).map{ |line| line.unpack("U*") }
    lengths = extract_segment_lengths(
                collapse_space_clusters(
                  space_mask(lines)))

    offset  = nil # GC help
    lines.map{ |line|
      offset = 0
      lengths.map{ |length|
        cell = (line[offset, length] || []).pack('U*').strip
        offset += length
        cell }}
  end

private
  #    aa   bb
  #    c    dddd ee
  # => ..TTT....T..
  #
  def space_mask(lines)
    max_line_length = lines.map{ |a| a.length }.max
    lines.inject([true] * max_line_length){ |mask, line|
      mask.zip(line).
           map{ |a, b| a && (!b || b == SPACE) }}
  end

  #    ..TTT....T..
  # => ..T......T..
  #
  def collapse_space_clusters(mask)
    rmask = mask.reverse
    rmask.zip(rmask[1..-1]).map{ |a, b| a && !b }.reverse
  end

  # ..T......T.. => [3, 7, 2]
  #
  def extract_segment_lengths(mask)
    mask.inject([1]){ |a,e|
      if e
        a << 1
      else
        a[-1] += 1
        a
      end }
  end
end
