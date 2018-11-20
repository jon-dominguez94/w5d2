# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ApplicationRecord
  
  validates :title, presence: true
  
  belongs_to :moderator,
    foreign_key: :user_id,
    class_name: 'User'
  
  has_many :postsubs,
    foreign_key: :sub_id,
    class_name: :PostSub
    
  has_many :posts,
    through: :postsubs,
    source: :post
  
end
