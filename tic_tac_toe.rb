# frozen_string_literal: false

# Tic_tac_toe class
class TicTacToe
  def initialize
    @board = [['1', '2', '3'],
              ['4', '5', '6'],
              ['7', '8', '9']]
    print "Player 1, enter your marker: "
    @mark_1 = gets.chomp
    print "Player 2, enter your marker: "
    @mark_2 = gets.chomp
    play_game
  end

  def display_board
    puts '  -   -   -'
    @board.each do |row|
      row.each do |space|
        print "| #{space} "
      end
      print "|\n  -   -   -\n"
    end
  end
    #loop until checks return winner, loop max 9 times
    #calls player turns
    #call checks
    #reset if there is a winner
  def play_game
    display_board
    winner = false
    4.times do
      print "Player 1, enter the coordinate for your mark: "
      coordinate = gets.chomp.to_i
      place_marker(@mark_1, coordinate)
      display_board
      if check_column || check_row || check_diagonal 
        winner = true
        puts "Winner is Player 1."
        break
      end
      print "Player 2, enter the coordinate for your mark: "
      coordinate = gets.chomp.to_i
      place_marker(@mark_2, coordinate)
      display_board
      if check_column || check_row || check_diagonal 
        winner = true
        puts "Winner is Player 2."
        break
      end
    end
    print "Player 1, enter the coordinate for your mark: "
    coordinate = gets.chomp.to_i
    place_marker(@mark_1, coordinate)
    display_board
    if check_column || check_row || check_diagonal 
      winner = true
      puts "Winner is Player 1."
    end
    if !winner
      puts "Game is tied."
    end
  end

  def place_marker(marker, coordinate)
    if coordinate.between?(1, 3)
      @board[0][coordinate - 1] = marker
    elsif coordinate.between?(4, 6)
      @board[1][coordinate - 4] = marker
    else
      @board[2][coordinate - 7] = marker
    end
  end

  # Conditions
  def check_row
    if @board[0][0].eql?(@board[0][1]) and @board[0][0].eql?(@board[0][2])
      return true
    elsif @board[1][0].eql?(@board[1][1]) and @board[1][0].eql?(@board[1][2])
      return true
    elsif @board[2][0].eql?(@board[2][1]) and @board[2][0].eql?(@board[2][2])
      return true
    end
    return false
  end

  def check_column
    #loop down each column, checks for winner
    if @board[0][0].eql?(@board[1][0]) and @board[0][0].eql?(@board[2][0])
      return true
    elsif @board[0][1].eql?(@board[1][1]) and @board[0][1].eql?(@board[2][1])
      return true
    elsif @board[0][2].eql?(@board[1][2]) and @board[0][2].eql?(@board[2][2])
      return true
    end
    return false
  end

  def check_diagonal
    if @board[0][0].eql?(@board[1][1]) and @board[0][0].eql?(@board[2][2])
      return true
    elsif @board[0][2].eql?(@board[1][1]) and @board[0][2].eql?(@board[2][0])
      return true
    end  
    return false
  end

  def reset
    for i in (1..9) do
      place_marker(i.to_s, i)
    end
  end
end


board = TicTacToe.new
