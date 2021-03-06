# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
set :environment, :production 

require File.expand_path(File.dirname(__FILE__) + "/environment")
ENV.each { |k, v| env(k, v) }

set :output, error: 'log/crontab_error.log', standard: 'log/crontab.log'
set :environment, :development

every 1.minutes do
  runner "Batch::Judgement.judgement"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
