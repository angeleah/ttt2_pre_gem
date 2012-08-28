class MockValidate
  
  attr_writer :bool
  
  def player_input(input)
    @bool
  end
  
  def string_input(input)
    @bool
  end
  
  def number_input(input)
    @bool
  end
end