ActiveAdmin.register ContactU do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
permit_params :name, :surname, :email, :country, :gender
	index do
        id_column
	    column :name
	    column :surname
	    column :email
	    column :country
	    column :gender
	    actions
	end

	filter :name
	filter :surname
	filter :email
	filter :country
	filter :gender

	form(:html => { :multipart => true }) do |f|
		f.inputs do
		    f.input :name, :required => true
		    f.input :surname, :required => true
		    f.input :email, :required => true, :email => true
		    f.input :country, as: :select, :collection => %w[India Indonesia Philippines], :include_blank => "Select Country", :required => true
		    f.input :gender, as: :radio, :collection => [["Male", 'Male', {:checked => true}], ["Female", "Female"]]
    	end
    	f.actions
  	end
end
