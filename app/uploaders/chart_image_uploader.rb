class ChartImageUploader < ImageUploader
  version(:main){ process resize_to_limit: [350, 350] }
end
