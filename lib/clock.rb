require 'clockwork'
require './config/boot'
require './config/environment'
include Clockwork

Clockwork.every(1.day,'weekly_worker called', :at => '14:19', :tz => 'UTC') { WeeklyWorker.perform_async }

	
    


