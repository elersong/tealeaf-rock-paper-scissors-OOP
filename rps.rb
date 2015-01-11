require 'pry'
# Pseudocode Algorithm
# 1. Prompt user to select one of three choices (R, P, or S)
# 2. Randomly select one of the three choices by the computer
# 3. Compare based on the logic that 
#     =>  P beats R but not S
#     =>  R beats S but not P
#     =>  S beats P but not R
# 4. Declare the winner and prompt to play again or end

class RPS

  # eliminate clutter on the interface
  def self.display_header
    system("clear")
    puts "Let's play Rock, Paper, Scissors"
    puts "--------------------------------"
  end
  
  # group the logic that encompasses a full round of the game
  def self.play_game
    self.display_header
    @user_input = self.collect_and_validate_input "Choose a Play (R/P/S)", :play
    @computer_input = %w(R P S).sample
    
    # determine who won this round
    self.display_header
    string = case @user_input
        when @computer_input
          "It's a TIE!!!"
        when "P"
          @computer_input == "R" ? "Paper covers rock! YOU WIN!" : "Scissors cut paper! Computer Wins!"
        when "R"
          @computer_input == "S" ? "Rock breaks scissors! YOU WIN!" : "Paper covers Rock! Computer Wins!"
        when "S"
          @computer_input == "P" ? "Scissors cut paper! YOU WIN!" : "Rock breaks scissors! Computer Wins!"
      end
    puts string
    
    # ask the user if they wish to play again
    again = (self.collect_and_validate_input "Would you like to go again? (Y/N)", :again).upcase
    again == "Y" ? RPS.play_game : (puts "Thanks for playing!")
  end
  
  # as the user a question and return the result
  def self.prompt(msg)
    puts " => #{msg}"
    gets.chomp
  end
  
  # check that the input the user gave is valid. re-prompt repeatedly if not. return valid input
  def self.collect_and_validate_input(msg, type)
    input = self.prompt msg
    
    if self.valid?(input, type)
      return input.upcase
    else
      system("clear")
      puts "INVALID INPUT: Please try again"
      input = self.collect_and_validate_input msg, type
    end
  end
  
  # set the qualifications of valid input by category
  def self.valid?(input, type)
    if type == :play
      !(input !~ /[RPSrps]/) && input.length == 1
    elsif type == :again
      !(input !~ /[YNyn]/)
    end
  end
  
end

# begin the game
RPS.play_game
