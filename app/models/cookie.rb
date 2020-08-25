class Cookie < ActiveRecord::Base
  belongs_to :storage, polymorphic: :true
  
  validates :storage, presence: true

  attribute :amount, :integer, default: 12
end

class ActiveRecord::Associations::CollectionProxy
  def fillings
    !self.first.fillings.empty? ? self.first.fillings : "no fillings"
  end
end