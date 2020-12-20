class Game
    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], \
    [0, 3, 6], [1, 4, 7], [2, 5, 8], \
    [0, 4, 8], [2, 4, 6]]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end

    def self.WIN_COMBINATIONS
        WIN_COMBINATIONS
    end

    def current_player
        self.board.turn_count % 2 == 0 ? player_1 : player_2
    end

    def won?
        outcome = false
        self.class.WIN_COMBINATIONS.each do |combination|
            if (self.board.cells[combination[0]] == "X" || self.board.cells[combination[0]] == "O") \
            && self.board.cells[combination[0]] == self.board.cells[combination[1]] \
            && self.board.cells[combination[1]] == self.board.cells[combination[2]]
                outcome = combination
                break
            end
        end
        outcome
    end

    def draw?
        over? && !self.won?
    end

    def over?
       self.board.full? 
    end

    def winner
        return unless self.won? 
        self.board.cells[won?[0]]
    end

    def turn
        self.board.display
        puts "\n"
        move = self.current_player.move(self.board)
        while !self.board.update(move, self.current_player)
            move = self.current_player.move(self.board)
        end
        move
    end

    def play
        until self.won? || self.draw?
            self.turn
        end
        if self.won?
            if self.winner == "X"
                puts "Congratulations X!"
            else 
                puts "Congratulations O!"
            end
        end
        if self.draw?
            puts "Cat's Game!"
        end
    end
end
