require 'clockwork'
require './config/boot'
require './config/environment'
include Clockwork

every(1.day,'weekly_worker called', :at => '11:39', :tz => 'UTC') { WeeklyWorker.perform_async }

	
    


