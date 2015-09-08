class window.CollapsableArticle
  constructor: (@articleEl) ->
    @articleEl.attr('data-inited', 'true')
    @id= @articleEl.data('post-id')
    @path = @articleEl.data('path')
    @contentArea = $(@articleEl.find('[data-text]'))
    @readMoreButton = $(@articleEl.find('[data-read-more]'))
    @readMoreButton.show()
    @readLessButton = $(@articleEl.find('[data-read-less]'))
    @readLessButton.hide()
    @expandArticle = $(@articleEl.find('[data-expand-article]'))

    @initializeContent()
    @bindExpand()
    @bindCollapse()
    @bindTitle()



  initializeContent: ->
    @contentArea.css({ height: '0' })


  bindExpand: ->
    @readMoreButton.on 'click', (e) =>
      $(e.target).closest(".article-body").find(".text").addClass("opened-article")
      e.preventDefault()
      @contentArea.css({ height: 'auto' })
      @readMoreButton.hide()
      @readLessButton.show()


      if @path
        window.history.pushState('', '', @path)

      @markRead()

  bindCollapse: ->
    @readLessButton.on 'click', (e) =>
      $(e.target).closest(".article-body").find(".text").removeClass("opened-article")
      e.preventDefault()
      @contentArea.css({ height: '0' })
      @readLessButton.hide()
      @readMoreButton.show()

  bindTitle: ->
    @expandArticle.on 'click', (e) =>
      e.preventDefault()
      if @expandArticle.attr('data-expand-article') == 'hidden'
        @expandArticle.attr('data-expand-article', 'expanded')
        @readMoreButton.trigger('click')
      else
        @expandArticle.attr('data-expand-article', 'hidden')
        @readLessButton.trigger('click')

  markRead: ->
    $.post("/posts/#{@id}/mark-read")
