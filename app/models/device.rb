class Device < ActiveRecord::Base
  belongs_to :user

  def self.total_devices(device_id,device_type,user_id)
     @device = Device.find_by_device_id_and_device_type(device_id,device_type)
     if @device
      @device.update_attributes(:device_id => device_id,:device_type => device_type,:user_id => user_id)
     else
      Device.create(:device_id => device_id,:device_type => device_type,:user_id => user_id)
     end
  end 
end
