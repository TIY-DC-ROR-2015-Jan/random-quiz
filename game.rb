require "./dice"

class Player
end


class Game
  # Players roll their dice until someone wins
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
