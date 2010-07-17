class Detabulator
  SPACE = 32

  def detabulate(s)
    lines = s.split(/\n/).map{ |line| line.unpack("U*") }
    max_line_length = lines.map{ |a| a.length }.max
    mask = [true] * max_line_length
    lines.each do |line|
      line_mask = (0 ... max_line_length).map{ |i| (line[i] || SPACE) == SPACE }
      mask = mask.zip(line_mask).map{ |a, b| a & b }
    end
    (max_line_length - 1).downto(1).each do |i|
      mask[i] = false if mask[i-1]
    end
    segment_lengths = mask.inject([1]){ |a,e|
      if e
        a << 1
      else
        a[-1] += 1
      end
      a
    }
    offset = nil
    lines.map{ |line|
      offset = 0
      segment_lengths.map{ |length|
        word = (line[offset, length] || []).pack('U*').strip
        offset += length
        word
      }
    }
  end
end
