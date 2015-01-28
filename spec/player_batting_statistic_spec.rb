require 'spec_helper'
require_relative '../lib/baseball_data'
require_relative '../lib/player_batting_statistic'

describe PlayerBattingStatistic do
  describe '.all' do
    it "imports all data" do
      instances_count = PlayerBattingStatistic.all.length
      original_data_count = BaseballData.batting_data.count
      expect(instances_count).to eq(original_data_count)
    end
  end

  describe '.add' do
    after(:each) { PlayerBattingStatistic.all.pop }

    it "adds new instance to .all" do
      expect {
        PlayerBattingStatistic.new
      }.to change(PlayerBattingStatistic.all, :length).by(1)
    end
  end

  describe '#batting_average' do
    let(:all_star) { PlayerBattingStatistic.new(h: 2, ab: 5) }

    after(:each) { PlayerBattingStatistic.all.pop }

    it "calculates batting average" do
      expect(all_star.batting_average).to eq(0.4)
    end
  end

  describe '#slugging_percentage' do
    let(:player) do
      PlayerBattingStatistic.new(h: 10, hr: 1, ab: 26)
    end

    after(:each) { PlayerBattingStatistic.all.pop }

    it "calculates slugging percentage" do
      expect(player.slugging_percentage).to eq("50.00")
    end
  end

  describe 'demographic info' do
    let(:hank_aaron) { PlayerBattingStatistic.new(playerid: 'aaronha01') }
    after(:each) { PlayerBattingStatistic.all.pop }

    describe '#full_name' do
      it "returns full name" do
        expect(hank_aaron.full_name).to eq('Hank Aaron')
      end
    end

    describe '#basic_info' do
      it "returns full name and year born" do
        expect(hank_aaron.basic_info).to eq("Hank Aaron born 1934")
      end
    end
  end
end