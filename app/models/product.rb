class Product < ApplicationRecord
  
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id", optional: true
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  belongs_to :brand, optional:true
  accepts_nested_attributes_for :brand
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  
  validates :name, presence: true
  validates :description, presence: true
  validates :condition, presence: true
  validates :postage, presence: true
  validates :shipping_method, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_days, presence: true
  validates :price, 
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 300,
      less_than_or_equal_to: 9999999,
      allow_blank: true
    }

  validate :category_count
    def category_count
      category_validation = category_ids
      unless category_validation.length == 3
        errors.add(:category_ids,"選択してください")
      end
    end

  validate :require_image
    def require_image
      image_validation = images
      if image_validation.empty?
        errors.add(:images, "画像がありません")
      end
    end
  
    #チェックボックス用enum
  # enum size: {unanswered: 0, XXS: 1, XS: 2, S: 3, M: 4, L: 5, XL: 6, "2XL": 7, "3XL": 8, "4XL": 9, two_three: 10, two_three_five: 11, two_four: 12, two_four_five: 13, two_five: 14, two_five_five: 15, two_six: 16, two_six_five: 17, two_seven: 18, two_seven_five: 19, two_eight: 20, two_eight_five: 21, two_nine: 22, two_nine_five: 23, three_zero: 24, three_zero_five: 25, three_one: 26}
  # enum condition: {new_item: 1, new_like: 2, no_dirt: 3, less_dirt: 4, dirt: 5, bad: 6}
  enum condition: {new_item: "新品、未使用", new_like: "未使用に近い", no_dirt: "目立った傷や汚れなし", less_dirt: "やや傷や汚れあり", dirt: "傷や汚れあり", bad: "全体的に状態が悪い"}
  enum postage: {seller_cost: "着払い(購入者負担)", buyer_cost: "送料込み(出品者負担)"}
  enum statuse: {selling: "販売中", sold_out: "売り切れ"}
  

end





