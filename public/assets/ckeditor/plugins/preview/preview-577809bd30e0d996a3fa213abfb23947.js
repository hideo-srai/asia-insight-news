// Angular Rails Template
// source: /home/reiro/.rvm/gems/ruby-2.1.5@mni-asia-insight/gems/ckeditor-4.1.1/vendor/assets/javascripts/ckeditor/plugins/preview/preview.html

angular.module("templates").run(["$templateCache", function($templateCache) {
  $templateCache.put("ckeditor/plugins/preview/preview.html", "<script>\n\n// Prevent from DOM clobbering.\nif ( typeof window.opener._cke_htmlToLoad == 'string' ) {\n	var doc = document;\n	doc.open();\n	doc.write( window.opener._cke_htmlToLoad );\n	doc.close();\n\n	delete window.opener._cke_htmlToLoad;\n}\n\n</script>")
}]);

