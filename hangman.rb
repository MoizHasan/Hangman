class Hangman

require 'yaml'
require_relative 'man_pictures'

attr_accessor :secret_word, :guesses, :letter_display, :letters_guessed
def initialize
#remove words that are too long or short as well as proper nouns.
@word_list = File.readlines("5desk.txt").select! {|word| word.length > 5 && word.length < 12 && word[0] == word[0].downcase}
@secret_word = select_word
@guesses = 0
@man_pictures = ManPictures.new.get_man_pictures
@letter_display = "_ "*(secret_word.length-1)
@letters_guessed = []
end

def select_word
#choose a word out of the dictionary for the player to guess.
	@word_list[rand(@word_list.length)]
end

def inc_guesses
	@guesses += 1
end

def save_game
	print "enter the name for this save:"
	file_name = gets.chomp
	File.open("saves/" + file_name.to_s+".yaml", 'w') {|f| f.write(YAML::dump(self))}
end

def load_game
	puts "Here is a list of current available save files.\n\n"
	puts Dir.entries("saves/")[2..-1]
	print "enter the name of the file to load:"
	file_name = gets.chomp
	game = YAML::load(File.read("saves/" + file_name.to_s+".yaml"))
	self.secret_word = secret_word
	self.guesses = game.guesses
	self.letter_display = game.letter_display
	self.letters_guessed = game.letters_guessed

end

def guess_letter(guess)
	while guess.length != 1 || guess =~ /[^a-z]/ || @letters_guessed.include?(guess)
		puts "Try again. Remember to guess one letter at a time." if guess.length != 1
		puts "Try again. Remember to guess only letters." if guess =~ /[^a-z]/
		puts "Try again. You have already guessed this letter." if @letters_guessed.include?(guess)
		print "enter your guess:"
		guess = gets.chomp.downcase
	end
	guess
end

def update_display(guess)
	indices = []
			#determines the locations of the match(es) in the secret word.
			@secret_word.scan(guess) do |c|
				indices << Regexp.last_match.offset(0)[0]
			end
			#edit the display string to match accordingly.
			indices.each do |i|
				@letter_display[i*2] = guess
			end
end

def game
	puts "Welcome to Hangman! Guess the word before the man gets hanged."
		puts "Would you like to load an existing game? Enter 'yes' to load. Hit enter to continue playing.\n\n"
		ans = gets.chomp
		if ans.downcase == "yes"
			load_game
			incorrect_letters = (@letters_guessed - @letter_display.chars).join(",")
		puts "Incorrect: " + incorrect_letters unless incorrect_letters.length == 0
		puts @man_pictures[guesses]
		end

	puts puts "\n" + letter_display 
	while guesses < 7  && letter_display.include?("_")
		print "\nenter your guess or @ to save the game:"
		ans = gets.chomp.downcase
		if ans == "@"
			save_game
			print "\nenter your guess or @ to save the game:"
			ans = gets.chomp.downcase
		end
		guess = guess_letter(ans)

		@letters_guessed << guess

 		if secret_word.include? guess
			update_display(guess)
 		else
 			inc_guesses
		end
		incorrect_letters = (@letters_guessed - @letter_display.chars).join(",")
		puts "\nIncorrect: " + incorrect_letters unless incorrect_letters.length == 0
		puts @man_pictures[guesses]
		puts "\n" + letter_display 
	end
	if guesses < 7
		puts "Congratulations you win!"
	else
		puts "Sorry you lose. The word was " + secret_word
	end
end


a = Hangman.new
a.game
end



