module AfterNewspaper
  extend ActiveSupport::Concern
  
  included do
    after_commit do
      New.create_newspaper(self)
    end
  end
end