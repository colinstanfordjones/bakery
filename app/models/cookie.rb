class Cookie < ActiveRecord::Base
  belongs_to :storage, polymorphic: :true
  
  validates :storage, presence: true

  attribute :amount, :integer, default: 12
end

class ActiveRecord::Associations::CollectionProxy
  def fillings
    !self.empty? ? self.first.fillings : "no fillings"
  end
end