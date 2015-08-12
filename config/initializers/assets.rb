Rails.application.config.assets.precompile += %w( admin.css simple.css  frontend.css frontend-print.css
                                                  admin.js  simple.js   frontend.js
                                                  wysiwyg-color.css *.eot *.woff *.ttf
                                                  )
Rails.application.config.assets.precompile += %w( ckeditor/* select2/* datatables/* *.png )