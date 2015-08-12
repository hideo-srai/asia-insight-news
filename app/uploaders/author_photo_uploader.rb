class AuthorPhotoUploader < ImageUploader
  version(:main){ process resize_to_limit: [250, 200] }
  version(:thumb){ process resize_to_fit: [50, 50] }
end