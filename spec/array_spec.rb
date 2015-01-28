require 'spec_helper'
require_relative '../lib/array'
require_relative '../lib/baseball_data'

describe Array do
  let(:all_data) { PlayerBattingStatistic.all }

  describe ".where" do
    it "filters by sym" do
      sample = all_data.where(team: "ATL").sample
      expect(sample.team).to eq("ATL")
    end
  end

  describe ".min_stat" do
    it "filters low stats by sym" do
      sample = all_data.min_stat(:at_bats, 300).sample
      expect(sample.at_bats).to be >= 300
    end
  end

  describe ".find_unique_by" do
    it "filters unique by sym" do
      uniques = all_data.find_unique_by(:player_id)
      sample  = uniques.sample
      others  = uniques.select do |player|
        player.player_id == sample.player_id
      end
      expect(others.size).to eq(1)
    end
  end

  describe ".highest" do
    it "returns obj with highest trait" do
      highest_ba = all_data.highest(:batting_average)
      best_ba    = all_data.max { |player| player.batting_average }
      expect(highest_ba).to eq(best_ba)
    end
  end

  describe ".played_in_years" do
    it "filters out only those who played"
  end

  describe ".player_stats_by_start_end" do
    it "returns stats for start and end year"
  end

  describe ".best_ba_improvement" do
    it "returns players with best ba improvement"
  end

  describe ".ba_delta" do
    it "returns change in ba between years"
  end

  describe ".triple_crown_winner" do
    context "was a winner" do
      it "returns winner"
    end

    context "no winner" do
      it "returns nil"
    end
  end

  describe ".triple_crown_winner?" do
    context "yes" do
      it "returns true" do
        winner = all_data.first
        result = all_data.triple_crown_winner?(winner, winner, winner)
        expect(result).to be_truthy
      end
    end

    context "no" do
      it "returns false" do
        winner_ba = all_data.first
        winner_hr = all_data.last
        winner_rbi = all_data.sample
        result = all_data.triple_crown_winner?(winner_ba, winner_hr, winner_rbi)
        expect(result).to be_falsey
      end
    end
  end
end