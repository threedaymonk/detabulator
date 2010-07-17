class Detabulator
  def detabulate(s)
    s.split(/\n/).map{ |a| a.split(/\s/) }
  end
end
