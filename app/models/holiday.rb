class Holiday < ApplicationRecord
  audited
  attr_accessor :_destroy

  belongs_to :inventory_pool, inverse_of: :holidays

  scope :future, -> { where(['end_date >= ?', Time.zone.today]) }

  before_save do
    self.end_date = self.start_date if self.end_date < self.start_date
  end

  def label_for_audits
    name
  end

end
