require 'clockwork'
require './config/boot'
require './config/environment'
include Clockwork

every(1.week,'weekly_worker called', :at => 'Sunday 13:05', :tz => 'UTC') { WeeklyWorker.perform_async }

every(1.day,'monthly worker called', :at => '00:05', :tz => 'UTC') { MonthlyEmailWorker.perform_async }

# every(1.day, 'monthly worker called', :if => lambda { |t| t.day == 1 }){ MonthlyEmailWorker.perform_async }