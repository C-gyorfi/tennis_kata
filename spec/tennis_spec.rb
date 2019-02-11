class Tennis
  def initialize
    @p1_points = 0
    @p2_points = 0
  end

  def add_score(player)
    @p1_points+=1 if player == :player_1
    @p2_points+=1 if player == :player_2
  end

  def score()
    points = {0 => "love", 1 => "fifteen", 2 => "thirty", 3 => "forty" }

    %i(player1 player2).each do |player|
      return present_win(player) if a_win_for?(player)
    end

    return "Player 2 Advantage" if @p2_points >= 4 && @p1_points < @p2_points
    return "Player 1 Advantage" if @p1_points >= 4 && @p2_points < @p1_points
    return "deuce" if @p1_points >= 3 && @p1_points == @p2_points
    "#{points[@p1_points]}-#{points[@p2_points]}"
  end

  def a_win_for?(player)
    if player == :player2
      player_points = @p2_points
      opponent_points = @p1_points
    elsif player == :player1
      player_points = @p1_points
      opponent_points = @p2_points
    end

    player_has_more_than_4_points = player_points >= 5
    player_is_two_points_clear = player_points > opponent_points + 1

    return player_has_more_than_4_points && player_is_two_points_clear
  end

  def present_win(player)
    case player
    when :player1
      "Player 1 Wins"
    when :player2
      "Player 2 Wins"
    end
  end
end

describe Tennis do

  let(:tennis) { Tennis.new}
  it "should return a score of love-love" do
    expect(tennis.score).to eq("love-love")
  end

  it "shuld return a score of fifteen-love when player 1 scores" do
    tennis.add_score(:player_1)
    expect(tennis.score).to eq("fifteen-love")
  end

  it "shuld return a score of thirty-love when player 1 scores again" do
    2.times{tennis.add_score(:player_1)}
    expect(tennis.score).to eq("thirty-love")
  end

  it "shuld return a score of forty-love when player 1 scores again" do
    3.times{tennis.add_score(:player_1)}
    expect(tennis.score).to eq("forty-love")
  end

  it "shuld return a score of love-fifteen when player 2 scores" do
    tennis.add_score(:player_2)
    expect(tennis.score).to eq("love-fifteen")
  end

  it "shuld return deuce if both players score 3 times" do
    3.times do
      tennis.add_score(:player_1)
      tennis.add_score(:player_2)
    end
    expect(tennis.score).to eq("deuce")
  end

  it "should return player 1 advantage when player 1 scores 4 points" do
    3.times do
      tennis.add_score(:player_1)
      tennis.add_score(:player_2)
    end
    tennis.add_score(:player_1)
    expect(tennis.score).to eq("Player 1 Advantage")
  end

  it "should return player 2 advantage when player 1 scores 4 points" do
    3.times do
      tennis.add_score(:player_1)
      tennis.add_score(:player_2)
    end
    tennis.add_score(:player_2)
    expect(tennis.score).to eq("Player 2 Advantage")
  end

  it "should return player 1 advantage when player 1 scores more than 4 times but one score ahead" do
    5.times do
      tennis.add_score(:player_1)
      tennis.add_score(:player_2)
    end
    tennis.add_score(:player_1)
    expect(tennis.score).to eq("Player 1 Advantage")
  end

  it "should return player 2 advantage when player 2 scores more than 4 times but one score ahead" do
    5.times do
      tennis.add_score(:player_1)
      tennis.add_score(:player_2)
    end
    tennis.add_score(:player_2)
    expect(tennis.score).to eq("Player 2 Advantage")
  end

  it "should return return to deuce from advantage if player 2 equalises" do
    4.times do
      tennis.add_score(:player_1)
      tennis.add_score(:player_2)
    end
    expect(tennis.score).to eq("deuce")
  end

  it "should return player 1 Wins when player 1 scores 4 points" do
    3.times do
      tennis.add_score(:player_1)
      tennis.add_score(:player_2)
    end
    2.times{tennis.add_score(:player_1)}
    expect(tennis.score).to eq("Player 1 Wins")
  end

  it "should return player 1 Wins when player 1 scores 4 points" do
    3.times do
      tennis.add_score(:player_1)
      tennis.add_score(:player_2)
    end
    2.times{tennis.add_score(:player_2)}
    expect(tennis.score).to eq("Player 2 Wins")
  end

  it "should return player 1 wins when player 1 scores consequitivley" do
    5.times { tennis.add_score(:player_1) }
    expect(tennis.score).to eq("Player 1 Wins")
  end

  it "should return player 2 wins when player 1 scores consequitivley" do
    5.times { tennis.add_score(:player_2) }
    expect(tennis.score).to eq("Player 2 Wins")
  end

  context "when deuce" do
    before do
      3.times do
        tennis.add_score(:player_1)
        tennis.add_score(:player_2)
      end
    end

    it "can return to deuce twice" do
      expect(tennis.score).to eq("deuce")
    end



  end
end
