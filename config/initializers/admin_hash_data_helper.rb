module AdminHashDataHelper
  class AdminHashData < Hash
    extend ActiveModel::Naming
    def to_key
      nil
    end    
  end
end
