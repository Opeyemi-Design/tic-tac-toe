class TicTacToe
  attr_reader :board, :players

  def initialize
    @board = Array.new(3) { Array.new(3, "") }
    @players = [Player.new("X"), Player.new("O")]
  end

  def play
    until game_over?
      display_board
      current_player = players[turn]
      current_player.make_move(board, turn)
      switch_turn
    end

    display_board
    if winner?
      puts "Congratulations, #{winner} has won!"
    else
      puts "It's a draw!"
    end
  end

  def game_over?
    winner? || board_full?
  end

  def winner?
    winning_combinations.any? { |combination| combination.all? { |index| board[index] == players[0].symbol } }
  end

  def board_full?
    board.flatten.none? { |cell| cell == "" }
  end

  def switch_turn
    @turn = turn == 0 ? 1 : 0
  end

  def display_board
    board.each do |row|
      puts row.join(" ")
    end
  end

  private

  attr_reader :turn

  class Player
    attr_reader :symbol

    def initialize(symbol)
      @symbol = symbol
    end

    def make_move(board, turn)
      puts "#{symbol}, it's your turn. Enter a number from 1 to 9 to make your move."
      move = gets.chomp.to_i
      while move < 1 || move > 9 || board[move - 1] != ""
        puts "Invalid move. Enter a number from 1 to 9 to make your move."
        move = gets.chomp.to_i
      end

      board[move - 1] = symbol
    end
  end

  def winning_combinations
    [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ]
  end
end

game = TicTacToe.new
game.play
