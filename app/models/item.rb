class Item < ActiveRecord::Base
  belongs_to :user

  def self.visible
    where(deleted: false)

  end
end
