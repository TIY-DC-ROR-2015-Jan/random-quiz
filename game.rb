require "./dice"

class Player
  # attr_reader :dice

  def initialize name, dice
    @dice = dice
  end

  def dice
    @dice
  end

  def roll
    @dice.roll
  end
end


class Game
  def initialize p1,p2
    # @p1, @p2 = p1, p2
    @p1 = p1
    @p2 = p2
    # @winner = nil
  end

  def play!
    # Needs to set @winner
    until @winner # we have a winner
      # both players roll
      p1_roll = @p1.roll # or @p1.dice.roll
      p2_roll = @p2.roll
      # compare, if someone won, we save as @winner
      if p1_roll > p2_roll
        @winner = @p1
      elsif p1_roll < p2_roll
        @winner = @p2
      end
    end
  end

  def winner
    @winner
  end
end


if $PROGRAM_NAME == __FILE__ # Ignore this bit for now, we'll talk about it afterwards
  def get_player number
    print "Player #{number}'s Name > "
    name = gets.chomp

    cheat_code = "\e[A\e[A\e[B\e[B\e[D\e[C\e[D\e[Cba"
    cheating = name.include? cheat_code
    name.gsub! cheat_code, ""

    dice = cheating ? LoadedDice.new : Dice.new
    Player.new dice
  end

  p1 = get_player 1
  p2 = get_player 2
  Game.new(p1, p2).play!
end
