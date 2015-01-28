class PlayerBattingStatistic
  def self.all
    @all_player_batting_stats
  end

  def self.add(player)
    @all_player_batting_stats ||= []
    @all_player_batting_stats << player
  end

  attr_accessor :player_id, :year, :league, :team, :at_bats, :hits, :doubles,
                :triples, :homers, :rbis

  def initialize(player_stats={})
    @player_id  = player_stats[:playerid]
    @year       = player_stats[:yearid]
    @league     = player_stats[:league]
    @team       = player_stats[:teamid]
    @at_bats    = player_stats[:ab]   || 0
    @hits       = player_stats[:h]    || 0
    @doubles    = player_stats[:"2b"] || 0
    @triples    = player_stats[:"3b"] || 0
    @homers     = player_stats[:hr]   || 0
    @rbis       = player_stats[:rbi]  || 0

    self.class.add(self)
    self
  end

  def batting_average
    hits / at_bats.to_f
  end

  def slugging_percentage
    slugging_percentage = ((hits - doubles - triples - homers) + (2 * doubles) +
                          (3 * triples) + (4 * homers)) / at_bats.to_f
    valid_percentage?(slugging_percentage) ? slugging_percentage : 0
  end

  def full_name
    "#{demographic_info[:namefirst]} #{demographic_info[:namelast]}"
  end

  def basic_info
    "#{full_name} born #{demographic_info[:birthyear]}"
  end

  private

    def demographic_info
      @demographic_info ||= BaseballData.get_demographic_info(self)
    end

    def valid_percentage?(variable)
      variable >= 0
    end
end
