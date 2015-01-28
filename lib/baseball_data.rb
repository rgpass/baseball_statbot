require 'csv'
require_relative './player_batting_statistic'

class BaseballData
  class << self
    def process(args)
      @batting_data     = import_csv args[:batting_data_file]
      @demographic_data = import_csv args[:demographic_data_file]

      batting_data.each do |player|
        PlayerBattingStatistic.new(player)
      end
    end

    def batting_data
      @batting_data
    end

    def demographic_data
      @demographic_data
    end

    def import_csv(file)
      puts "Loading #{file}..."
      data = CSV.read("./lib/#{file}", :headers => true,
                      :header_converters => :symbol, :converters => [:all]).to_a
      headers = data.shift
      data.map { |r| Hash[*headers.zip(r).flatten] }
    end

    def get_demographic_info(player)
      demographic_data.find { |batter| batter[:playerid] == player.player_id }
    end
  end
end
