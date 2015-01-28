require 'spec_helper'
require_relative '../lib/baseball_data'

describe BaseballData do
  context 'pre processing' do
    describe '.process' do
      it 'sets batting_data' do
        expect(BaseballData.batting_data).to_not be_nil
      end

      it 'sets demographic_data' do
        expect(BaseballData.demographic_data).to_not be_nil
      end
    end

    describe '.import_csv' do
      it 'imports file'
    end
  end

  context 'post processing' do
    describe '.get_demographic_info' do
      it "returns player's demographic info" do
        random_player = PlayerBattingStatistic.all.sample
        player_info = BaseballData.get_demographic_info(random_player)
        expect(player_info[:namefirst]).to_not be_nil
      end
    end
  end
end