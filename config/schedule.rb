# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 5.minutes do
  runner "UpdateEventsJob.perform_now" # Since this is prototype, just call job, in real world we would trigger asyn job
end

# Learn more: http://github.com/javan/whenever
