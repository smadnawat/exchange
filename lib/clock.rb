require 'clockwork'
require './config/boot'
require './config/environment'
include Clockwork

every(30.seconds,'weekly_worker called', :tz => 'UTC') { WeeklyWorker.perform_async }

	
    


