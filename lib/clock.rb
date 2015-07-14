require 'clockwork'
require './config/boot'
require './config/environment'
include Clockwork

every(1.week,'weekly_worker called', :at => 'Sunday 16:20', :tz => 'UTC') { WeeklyWorker.perform_async }

	
    


