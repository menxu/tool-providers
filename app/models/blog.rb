class Blog < ActiveRecord::Base
  belongs_to :category
  scope :passed, -> { where(status: 0) }

  searchable do #if: proc { |blog| blog.passed? } do
    text :name
    text :desc
    integer :status
    integer :category_id
  end
end
