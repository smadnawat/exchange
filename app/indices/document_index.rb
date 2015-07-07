ThinkingSphinx::Index.define :document, :with => :active_record do
	indexes title, :sortable => true, :as => :post_name
	indexes author
	indexes subjects
	indexes isbn13

	set_property :enable_star => true
	set_property :min_prefix_len => 3
	set_property :morphology => 'stem_en'
end