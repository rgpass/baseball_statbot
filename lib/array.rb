class Array
  def where(args)
    # Code smell
    self.select do |obj|
      match = true
      args.each do |k, v|
        match = false if obj.send(k) != v
      end
      match
    end
  end

  def min_stat(property, num)
    self.select { |obj| obj.send(property) >= num }
  end

  def find_unique_by(sym)
    self.uniq { |obj| obj.send(sym) }
  end

  def highest(sym)
    self.max { |obj| obj.send(sym) }
  end

  def played_in_years(start_year, end_year)
    unique_batters  = find_unique_by(:player_id)
    playing_batters = unique_batters.map do |unique_batter|
      player_stats = player_stats_by_start_end(unique_batter, start_year, end_year)
      player_stats.first && player_stats.last ? player_stats : nil
    end
    playing_batters.flatten.compact
  end

  def player_stats_by_start_end(player, start_year, end_year)
    this_batter = self.where(player_id: player.player_id)
    stats_start = this_batter.where(year: start_year).first
    stats_end   = this_batter.where(year: end_year).first
    [stats_start, stats_end]
  end

  def best_ba_improvement(start_year, end_year)
    eligible_batters = self.played_in_years(start_year, end_year)
    unique_batters   = eligible_batters.find_unique_by(:player_id)
    most_improved    = { player: nil, ba: 0 }
    unique_batters.each do |unique_batter|
      player_stats   = player_stats_by_start_end(unique_batter, start_year, end_year)
      ba_improvement = ba_delta(player_stats.first, player_stats.last)
      if ba_improvement > most_improved[:ba]
        most_improved = { player: unique_batter, ba: ba_improvement }
      end
    end
    { start_year: start_year, end_year: end_year,
      player: most_improved[:player], improvement: most_improved[:ba] }
  end

  def ba_delta(stats_start, stats_end)
    starting_ba = stats_start.batting_average
    ending_ba   = stats_end.batting_average
    starting_ba - ending_ba
  end

  def triple_crown_winner
    eligible_batters = self.min_stat(:at_bats, 400)
    result_ba   = eligible_batters.highest(:batting_average)
    result_hr   = eligible_batters.highest(:homers)
    result_rbi  = eligible_batters.highest(:rbis)
    triple_crown_winner?(result_ba, result_hr, result_rbi) ? result_ba : nil
  end

  def triple_crown_winner?(result_ba, result_hr, result_rbi)
    result_ba == result_hr && result_hr == result_rbi
  end
end