require "spec_helper"
require "ttt/validate"

describe "Validate" do
  
 let(:validate) { Validate.new }
 
 it "should not accept anything but h or c" do
   input = "w"
   validate.player_input(input).should == false
 end
 
 it "should accept an h or c as valid input" do
   input = "h"
   validate.player_input(input).should == true
 end
 
 it "should not accept numbers when asked for letters" do
   input = "1"
   validate.mark_input(input).should == false
 end
 
 it "should accept valid string data" do
   input = "C"
   validate.mark_input(input).should == true
 end
  
 it "should not accept letters when asked for numbers" do
   input = "A"
   validate.number_input(input).should == false
 end
 
 it "should accept valid number data" do
   input = "9"
   validate.number_input(input).should == true
 end
 
 it "should not accept anything but y or n" do
   input = "w"
   validate.play_again_input(input).should == false
 end
 
 it "should accept an y or n as valid input" do
   input = "n"
   validate.play_again_input(input).should == true
 end
end