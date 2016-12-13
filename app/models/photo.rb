class Photo < ActiveRecord::Base

  validates :title, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :image, presence: true 
  
  has_attached_file :image,
					 # preserve_files: "true"
					 # url: "/system/:hash.:extension",
					 # hash_secret: "abc123",
					 styles: { thumb: ["64x64#", :jpg], 
							   original: ["500x500#", :jpg] },
					 convert_options: { thumb: "-quality 75 -strip", 
										original: "-quality 85 -strip" },
					 storage: :s3,
					 s3_credentials: {access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] },
					 bucket: "json-api-main"

  validates_attachment :image,
                        content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
						size: { in: 0..5000.kilobytes }
						
end
