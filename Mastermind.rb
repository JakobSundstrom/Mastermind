# Module to import
module MastermindModule
  COLORS = %w[red green blue yellow purple orange].freeze
  CODE_LENGTH = 4

  def self.generate_secret_code
    Array.new(CODE_LENGTH) { COLORS.sample }
  end

  def self.feedback(secret_code, guess)
    correct_colors = guess.count { |color| secret_code.include?(color) }
    correct_positions = guess.each_with_index.count { |color, idx| color == secret_code[idx] }
    [correct_colors, correct_positions]
  end
end

# Mastermind game
class Mastermind
  include MastermindModule
  MAX_ATTEMPTS = 12

  def initialize
    @secret_code = MastermindModule.generate_secret_code
  end

  def play
    puts 'Welcome to Mastermind! Try to guess the secret code.'
    puts "Valid colors: #{COLORS.join(', ')}"

    MAX_ATTEMPTS.downto(1) do |attempts|
      guess = gets.chomp.downcase.split
      correct_colors, correct_positions = MastermindModule.feedback(@secret_code, guess)

      if guess == @secret_code
        puts "Congratulations! You've guessed the secret code: #{@secret_code}."
      else
        puts "Correct colors: #{correct_colors}"
        puts "Correct positions: #{correct_positions}"
        puts "Attempts remaining: #{attempts - 1}"
      end
    end

    puts "Sorry, you've run out of attempts. The secret code was #{@secret_code}. Game over!"
  end
end

game = Mastermind.new
game.play
