# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord

  validates :title, presence: true
  
  has_many :postsubs,
    foreign_key: :post_id,
    class_name: :PostSub,
    inverse_of: :post
    
  has_many :subs, 
    through: :postsubs,
    source: :sub
  
  belongs_to :author,
    foreign_key: :user_id,
    class_name: 'User'
    
    
end
