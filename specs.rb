require "minitest/autorun"
require "./dice"
require "./game"

class GameTest < MiniTest::Test
  # These tests should already be passing
  def test_loaded_dice_are_predictable
    dice = LoadedDice.new
    assert_equal dice.roll, 6
  end

  def test_psychic_dice_know_the_future
    future = [2,3,6,1]
    dice = PsychicDice.new future
    future.each do |predicted|
      assert_equal dice.roll, predicted
    end
  end


  def test_players_have_dice
    dice  = Dice.new
    alice = Player.new "alice", dice
    assert_equal alice.dice, dice
  end

  def test_somebody_eventually_wins
    alice = Player.new "alice", Dice.new
    bob   = Player.new "bob",   Dice.new
    g     = Game.new alice, bob
    g.play!
    assert [alice, bob].include? g.winner
  end

  def test_cheaters_always_win
    su    = Player.new "su", Dice.new
    james = Player.new "james", LoadedDice.new
    g     = Game.new su, james
    g.play!
    assert_equal g.winner, james
  end

  def test_predictable_games_are_predictable
    brit  = Player.new "brit", PsychicDice.new([3,1,4])
    sarah = Player.new "sarah", PsychicDice.new([3,1,2])
    g     = Game.new brit, sarah
    g.play!
    assert_equal g.winner, brit
    assert_equal g.turn, 3
  end
end
