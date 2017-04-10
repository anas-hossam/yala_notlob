class Order < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_attached_file :order_image,
                      :default_url => "/app/assets/images/missing.png",
                      styles: { thumb: ["64x64#", :jpg],
                      original: ['500x500>', :jpg] },
                      convert_options: { thumb: "-quality 75 -strip",
                                     original: "-quality 85 -strip" },
                  hash_secret: "abc123",
                  preserve_files: "true"
  validates_attachment :order_image,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
