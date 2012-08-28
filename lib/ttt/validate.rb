class Validate
  
  def player_input(input)
     return false unless input =~ /[Hh,Cc]/
     return true
  end
  
  def mark_input(input)
    return false unless input =~ /[a-zA-Z]/
    return true
  end

  def number_input(input)
    return false unless input =~ /[1-9]/
    return true
  end
  
  def play_again_input(input)
    return false unless input =~ /[Nn,Yy]/
    return true
  end
end  