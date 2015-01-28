require_relative './baseball_data'
require_relative './command'

# Facade design pattern
class Display
  class << self
    def app_intro
      puts '**** Welcome to Baseball Statbot ****'
    end

    def load_files
      batting_file      = get_batting_file_name
      demographic_file  = get_demographic_file_name

      BaseballData.process(batting_data_file:     batting_file,
                           demographic_data_file: demographic_file)
    end

    def loop_through_options
      @options = ['Most improved batting average',
                 'Slugging percentages by team and year',
                 'Triple crowner winners by year']

      answer = nil
      while @answer != "q"
        print_menu
        process_command
      end
    end

    def print_menu
      puts "--Menu--"
      puts "[q] Quit"
      @options.each_with_index do |option, index|
        puts "[#{index+1}] #{option}"
      end
      print "Select an option: "
      answer = gets.chomp
      @answer = answer == "q" ? "q" : answer.to_i
    end

    def process_command
      case @answer
      when "q"
      when 1
        Command.batting_average
      when 2
        Command.slugging_percentage
      when 3
        Command.triple_crown
      else
        puts "Invalid input."
      end
    end

    def app_goodbye
      puts '**** Thank you for using Baseball Statbot ****'
    end

    def get_batting_file_name
      print "File name of batting data \t-- Leave blank to use default: "
      answer = gets.chomp
      answer.empty? ? 'Batting-07-12.csv' : answer
    end

    def get_demographic_file_name
      print "File name of demographic data \t-- Leave blank to use default: "
      answer = gets.chomp
      answer.empty? ? 'Master-small.csv' : answer
    end
  end
end