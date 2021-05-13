# frozen_string_literal: false

# Tic_tac_toe class
class TicTacToe

  # Gets player markers, executes game
  def initialize
    @board = [['1', '2', '3'],
              ['4', '5', '6'],
              ['7', '8', '9']]
    @turns = 0
    @winner1 = false
    @winner2 = false
    @score1 = 0
    @score2 = 0
    print 'Player 1, enter your marker: '
    @mark1 = gets.chomp
    print 'Player 2, enter your marker: '
    @mark2 = gets.chomp
    game
  end

  # Displays board to stdout
  def display_board
    puts '  -   -   -'
    @board.each do |row|
      row.each do |space|
        print "| #{space} "
      end
      print "|\n  -   -   -\n"
    end
  end

  # Calls play_game to execute game, loops while players want to continue playing
  def game
    loop do
      play_game

      # Prints score
      puts "Player 1: #{@score1} \nPlayer 2: #{@score2}"

      # Checks input if another game should be executed
      print 'Another game? (Y/N): '

      # Checks input to continue game, loops until valid input is given
      another_game = gets.chomp.upcase
      until another_game.eql?('N') || another_game.eql?('Y')
        print 'Enter "Y" or "N": '
        another_game = gets.chomp.upcase
      end
      break if another_game.eql?('N')

      # If game continues, resets board and variables
      reset
      @turns = 0
      @winner1 = @winner2 = false
    end
  end

  # Executes game logic
  def play_game
    display_board
    # Loops player turns until board fills at 9 turns
    loop do
      # Executes Player 1's turn
      print 'Player 1, enter the coordinate for your mark: '
      coordinate = gets.chomp.to_i

      # Checks if position is free, loops until a valid position is inputted
      until free_position?(coordinate)
        print 'Position is already filled. Pick another: '
        coordinate = gets.chomp.to_i end
      place_marker(@mark1, coordinate)
      display_board

      # Checks winning condition from placed marker
      if check_column || check_row || check_diagonal
        @winner1 = true
        puts 'Winner is Player 1.'
        @score1 += 1
      end

      # Ends game if board fills up i.e. 9 turns passed
      break if end_game?

      # Executes Player 2's turn
      print 'Player 2, enter the coordinate for your mark: '
      coordinate = gets.chomp.to_i

      # Checks if position is free, loops until a valid position is inputted
      until free_position?(coordinate)
        print 'Position is already filled. Pick another: '
        coordinate = gets.chomp.to_i
      end
      place_marker(@mark2, coordinate)
      display_board

      # Checks winning condition from placed marker
      if check_column || check_row || check_diagonal
        @winner2 = true
        puts 'Winner is Player 2.'
        @score2 += 1
      end

      # Breaks game if board is filled i.e. 9 turns passed
      break if end_game?
    end

    # Prints if no winner is declared that breaks the loop
    puts 'Game is tied.' unless @winner1 || @winner2
  end

  # Ends game if board is full or a player wins
  def end_game?
    true if @turns == 9 || @winner1 || @winner2
  end

  # Places player marker on board on coordinate
  def place_marker(marker, coordinate)
    # Incredents turn count
    @turns += 1
    if coordinate.between?(1, 3)
      @board[0][coordinate - 1] = marker
    elsif coordinate.between?(4, 6)
      @board[1][coordinate - 4] = marker
    else
      @board[2][coordinate - 7] = marker
    end
  end

  # Checks for winning row combinations
  def check_row
    return true if @board[0][0].eql?(@board[0][1]) && @board[0][0].eql?(@board[0][2])

    return true if @board[1][0].eql?(@board[1][1]) && @board[1][0].eql?(@board[1][2])

    return true if @board[2][0].eql?(@board[2][1]) && @board[2][0].eql?(@board[2][2])

    false
  end

  # Checks for winning column combinations
  def check_column
    return true if @board[0][0].eql?(@board[1][0]) && @board[0][0].eql?(@board[2][0])

    return true if @board[0][1].eql?(@board[1][1]) && @board[0][1].eql?(@board[2][1])

    return true if @board[0][2].eql?(@board[1][2]) && @board[0][2].eql?(@board[2][2])

    false
  end

  # Checks for winning diagonal combinations
  def check_diagonal
    return true if @board[0][0].eql?(@board[1][1]) && @board[0][0].eql?(@board[2][2])

    return true if @board[0][2].eql?(@board[1][1]) && @board[0][2].eql?(@board[2][0])

    false
  end

  # Checks if the coordinate is free
  def free_position?(coordinate)
    if coordinate.between?(1, 3)
      !(@board[0][coordinate - 1].eql?(@mark1) || @board[0][coordinate - 1].eql?(@mark2))
    elsif coordinate.between?(4, 6)
      !(@board[1][coordinate - 4].eql?(@mark1) || @board[1][coordinate - 4].eql?(@mark2))
    else
      !(@board[2][coordinate - 7].eql?(@mark1) || @board[2][coordinate - 7].eql?(@mark2))
    end
  end

  # Reinitializes board
  def reset
    @board = [['1', '2', '3'],
              ['4', '5', '6'],
              ['7', '8', '9']]
  end
end

board = TicTacToe.new