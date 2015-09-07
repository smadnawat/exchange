require 'clockwork'
require './config/boot'
require './config/environment'
include Clockwork

every(1.week,'weekly_worker called', :at => 'Sunday 13:05', :tz => 'UTC') { WeeklyWorker.perform_async }

# every(15.second,'monthly worker called') { MonthlyEmailWorker.perform_async }

	
    


