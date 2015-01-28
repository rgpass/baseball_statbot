# Prior to running test suite:
# $ gem install rspec

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.before(:suite) do
    BaseballData.process(batting_data_file: 'Batting-07-12.csv',
                         demographic_data_file: 'Master-small.csv')
  end
end