class Detabulator
  SPACE = 32

  def detabulate(s)
    lines = s.split(/\n/).map{ |line| line.unpack("U*") }
    max_line_length = lines.map{ |a| a.length }.max
    mask = [false] * max_line_length
    lines.each do |line|
      line_mask = line.map{ |cp| cp != SPACE }
      mask = mask.zip(line_mask).map{ |a, b| a | b }
    end
    (1 .. max_line_length).each do |i|
      mask[i] = true unless mask[i-1]
    end
    segment_lengths = mask.inject([1]){ |a,e|
      if e
        a[-1] += 1
      else
        a << 1
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
