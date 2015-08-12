class ChartImageUploader < ImageUploader
  version(:main){ process resize_to_limit: [239, 239] }
end