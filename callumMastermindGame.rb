#Callum Good - Ruby Assignment of the Game mastermind
#Constants can be changed to switch the word list or number of tries the player gets.
#
#here is the comment

###########Constants#############
CONST_WORD_LIST = "word-list.txt"
CONST_TRIES = 5
#helper method that takes a string and checks if the string contains only letters - input "word" is a string that has been sperated in the text file
def is_number? word
    #using regex - returns false if the inputted string contains anything but a lower case or upper case character of the alphabet
    word =~ /[a-zA-Z]/
end

#setUpGame reads in the word list and sets up the words from it into a list
def setUpGame
    #creates an array to that will be used to hold the words for the text file. 
    $word_list = []
    #The "file" class in Ruby calls the ".open" method which looks inside the specified file, the ".each" method iterates over each line of the file and is piped ("|") to a variable called word  
    File.open(CONST_WORD_LIST).each do |word|
        #The word variable is overwritten each time a new line is read, so each line is being stored into the "word_list" array 
        #is_number? takes in each word and if it returns true, the word is added to the list. 
        if is_number?(word) then  $word_list << word end
            if word.chars.count { |char| word.count(char) > 1 } > 1 #each word has its characters inputted and unqiue characters are counted, the count is outputted and checked if it is more than 1 
                $word_list.delete(word)
            end
            puts $word_list
    end
    #puts $word_list
end

#method for retrieving users answer
def getInput
    puts "Your answer:"   
    answer = gets.downcase.strip #recieves user input into a variable and .downcase makes it all lower case
end

#askToPlay allows the user to choose if they want to play
def askToPlay
    #asks for user input, takes only the first character of the input (most yes answers start with a 'y' and most no answers start with an 'n')
    play = "y" #play is default set "y" so the game always starts
    until (play != "y") #loop runs as long a play="y"
        playRound($word_list.sample.strip)       #sample picks a random item from 'word_list' and .stirp removes leading and trailing whitespace         
        play = [(puts "Would you like to play again? y/n"), gets.strip.downcase().chars.first][1]#runs at the end of a round, providing an oppertunity to change play from 'y', 
                                                                                                 #stopping the loop or keeping it as 'y' to play another round   
    end
end
#playRound takes in a word for the player to guess
def playRound word
    guess ="" #sets up an empty variable to store the players guess
    tries = CONST_TRIES #sets how many attempts the player will get, each iteration of the while loop this number will decrease by one
    while(tries > 0 && word != guess) #each iteraction of the while loop the number of tries is checked if it's above 0 or if the player's guess isn't the word
        puts "Tries left: #{tries}" #tells the user how many tries they have left - inputs the vaiable 'tries' which is updated each loop
        compare(word, guess=getInput()) #calls the compare() method, inputting word and the players guess by calling the getInput() method and assigning the result to the variable 'guess'
        tries -= 1 #decrements tries by 1
    end
    (word == guess)? winMessage(word) : lossMessage(word)#checks if the word is the same as the players guess when the loop has ended
end

def compare word, guess #compares the selected word from wordlist and the players input
    output =[] #creates an array to be populated based on how accurate the players guess is
    guess.each_char do |c|#iterates over each character in the guess, assigns character to 'c' over each iteration
      (word.include? (c)) ? output << test_index(word, c, guess.index(c)) : output << "X" #'.include?' checks 'word' if the character 'c' from guess is contained in 'word' if it is, test_index is called and will return a ! or ?  
                                                                                          #and append it to 'output' at the index of 'c', if not an 'X' is appened to output      
    end 
    puts output.join("")#concatenates every character in 'output' so it outputs as a single string
end
#checks the index of a correctly guessed letter - takes in the word, player's guess and the index of the letter that exists somewhere in the word
def test_index word, guess, index
    (word[index] == guess)? "!" : "?" #if the indexes match it means outputs a "!", else it means the letter exists in the word but not in that exact index and outputs a "?" 
end

def winMessage word #plays win message - word from that round is inputted and printed to screen
    puts "You win!!! The word was indeed #{word}!!"
end

def lossMessage word #plays loss message - word from that round is inputted and printed to screen
    puts "You lose :( In case you were wondering, the word was #{word}"
end

def intro #intro method to explain the rules
    puts "Welcome to Master Mind!!!!
    \nThe aim of the game is to guess the word. Each word is FIVE letters long and contains no duplicate characters (e.g. there will only ever be one 'a', 'b', 'c', etc)
    \nIf you see an 'X' it means that letter is not in the word, if you see a '?' it means the letter is in the word, but not in the place you put, and an '!' means \nyou guessed the right letter in the correct spot!
    \nGood luck\nPress RETURN to start"
end

###Main methods called###
#intro()
#gets #gets to pause the program until a key is pressed
setUpGame()#reads in word list
#askToPlay()#starts game
puts "Press RETURN to exit."
gets#pauses before exit
