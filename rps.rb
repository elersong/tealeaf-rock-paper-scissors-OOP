require 'pry'
# Pseudocode Algorithm
# 1. Prompt user to select one of three choices (R, P, or S)
# 2. Randomly select one of the three choices by the computer
# 3. Compare based on the logic that 
#     =>  P beats R but not S
#     =>  R beats S but not P
#     =>  S beats P but not R
# 4. Declare the winner and prompt to play again or end


# eliminate clutter on the interface
def display_header
  system("clear")
  puts "Let's play Rock, Paper, Scissors"
  puts "--------------------------------"
end

# group the logic that encompasses a full round of the game
def play_game
  display_header
  user = collect_and_validate_input "Choose a Play (R/P/S)", :play
  computer = %w(R P S).sample
  
  # determine who won this round
  display_header
  string = case user
      when computer
        "It's a TIE!!!"
      when "P"
        computer == "R" ? "Paper covers rock! YOU WIN!" : "Scissors cut paper! Computer Wins!"
      when "R"
        computer == "S" ? "Rock breaks scissors! YOU WIN!" : "Paper covers Rock! Computer Wins!"
      when "S"
        computer == "P" ? "Scissors cut paper! YOU WIN!" : "Rock breaks scissors! Computer Wins!"
    end
  puts string
  
  # ask the user if they wish to play again
  again = (collect_and_validate_input "Would you like to go again? (Y/N)", :again).upcase
  again == "Y" ? play_game : (puts "Thanks for playing!")
end

# as the user a question and return the result
def prompt(msg)
  puts " => #{msg}"
  gets.chomp
end

# check that the input the user gave is valid. re-prompt repeatedly if not. return valid input
def collect_and_validate_input(msg, type)
  input = prompt msg
  
  if valid?(input, type)
    return input.upcase
  else
    system("clear")
    puts "INVALID INPUT: Please try again"
    input = collect_and_validate_input msg, type
  end
end

# set the qualifications of valid input by category
def valid?(input, type)
  if type == :play
    !(input !~ /[RPSrps]/) && input.length == 1
  elsif type == :again
    !(input !~ /[YNyn]/)
  end
end

# begin the game
play_game