class BlogPostCoverUploader < ImageUploader
  version(:thumb)   { process resize_to_fill:   [160, 160] }
  version(:main)    { process resize_to_fill:   [969, 621] }
  version(:square)  { process resize_to_fill:   [280, 280] }
  version(:sidebar) { process resize_to_fill:   [238, 150] }
end