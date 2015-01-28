require_relative './player_batting_statistic'

class Command
  class << self
    def batting_average
      batting_average_intro
      min_bats    = get_min_bats
      start_year  = get_start_year
      end_year    = get_end_year

      batters_min_at_bats = PlayerBattingStatistic.all.min_stat(:at_bats, min_bats)
      improved_ba_result = batters_min_at_bats.best_ba_improvement(start_year, end_year)

      most_improved_ba(improved_ba_result)
    end

    def slugging_percentage
      slugging_percentages_intro
      team = get_team_id
      year = get_year

      team_stats_for_year = PlayerBattingStatistic.all.where(team: team, year: year)

      slugging_percentages(team_stats_for_year)
    end

    def triple_crown
      triple_crown_intro
      years = get_years

      triple_crown_winners(years)
    end

    def batting_average_intro
      puts "--Most Improved Batting Average--"
    end

    def get_min_bats
      print "Minimum number of at-bats -- default of 200: "
      answer = gets.chomp.to_i
      answer == 0 ? 200 : answer
    end

    def get_start_year
      print "Starting year\t-- default of 2009: "
      answer = gets.chomp.to_i
      answer == 0 ? 2009 : answer
    end

    def get_end_year
      print "Ending year\t-- default of 2010: "
      answer = gets.chomp.to_i
      answer == 0 ? 2010 : answer
    end

    def most_improved_ba(improved_ba)
      puts "From #{improved_ba[:start_year]} to #{improved_ba[:end_year]} the "
      puts "most improved player was #{improved_ba[:player].basic_info}."
      parsed_improvement = (improved_ba[:improvement] * 1000).to_i
      puts "He improved his batting average by #{parsed_improvement} (out of 1000)"
    end

    def slugging_percentages_intro
      puts "--Slugging Percentages--"
    end

    def get_team_id
      print "Team ID\t-- default of OAK: "
      answer = gets.chomp
      answer.strip.empty? ? "OAK" : answer
    end

    def get_year
      print "Year\t-- default of 2007: "
      answer = gets.chomp.to_i
      answer == 0 ? 2007 : answer
    end

    def slugging_percentages(players)
      formatted_stats = players.map do |player|
                          formatted_percentage = '%.2f' % (player.slugging_percentage*100)
                          "#{formatted_percentage}\t:  #{player.full_name}"
                        end.join("\n")
      puts formatted_stats
    end

    def triple_crown_intro
      puts "--Triple Crown Winners--"
    end

    def get_years
      print "Years (comma-separated)\t-- default of 2011, 2012: "
      years = gets.chomp.split(',').map { |year| year.strip.to_i }
      years.empty? ? [2011, 2012] : years
    end

    def triple_crown_winners(years)
      leagues = ["AL", "NL"]
      years.each do |year|
        leagues.each { |league| print_triple_crown_winner(league, year) }
      end
    end

    def print_triple_crown_winner(league, year)
      league_stats_for_year = PlayerBattingStatistic.all.where(
                                league: league, year: year)
      winner = league_stats_for_year.triple_crown_winner.basic_info || "(No winner)"
      puts "#{league} winner for #{year}\t-- #{winner}"
    end
  end
end