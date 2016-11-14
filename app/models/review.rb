class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :product_id, :user_id, :description, :rating, presence: true
end

# create_table "reviews", force: :cascade do |t|
#   t.integer  "product_id"
#   t.integer  "user_id"
#   t.text     "description"
#   t.integer  "rating"
#   t.datetime "created_at",  null: false
#   t.datetime "updated_at",  null: false
# end
