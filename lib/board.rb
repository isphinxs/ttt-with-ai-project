class Board
  attr_accessor :cells

  def initialize
    self.reset!
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    output = ""
    self.cells.each_with_index do |cell, index|
      if index.between?(0, 1) || index.between?(3, 4) || index.between?(6, 7)
        output << " #{cell} |"
      elsif index == 2 || index == 5
        output << " #{cell} \n-----------\n"
      else
        output << " #{cell} "
      end
    end
    puts output
  end

  def position(input)
    self.cells[input.to_i - 1]
  end

  def full?
    !self.cells.include?(" ")
  end

  def turn_count
    self.cells.count { |cell| cell != " " }
  end

  def taken?(input)
    self.cells[input.to_i - 1] != " "
  end

  def valid_move?(input)
    input.to_i > 0 && input.to_i < 10 && !self.full? && !self.taken?(input)
  end

  def update(input, player)
    if valid_move?(input)
      self.cells[input.to_i - 1] = player.token
    end
  end
end
