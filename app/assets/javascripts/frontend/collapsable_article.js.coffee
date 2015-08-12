class window.CollapsableArticle
  constructor: (@articleEl) ->
    @id= @articleEl.data('post-id')
    @path = @articleEl.data('path')
    @contentArea = $(@articleEl.find('[data-text]'))
    @readMoreButton = $(@articleEl.find('[data-read-more]'))
    @readMoreButton.show()
    @readLessButton = $(@articleEl.find('[data-read-less]'))
    @readLessButton.hide()

    @initializeContent()
    @bindExpand()
    @bindCollapse()



  initializeContent: ->
    @contentArea.css({ height: '0' })


  bindExpand: ->
    @readMoreButton.on 'click', (e) =>
      e.preventDefault()
      @contentArea.css({ height: 'auto' })
      @readMoreButton.hide()
      @readLessButton.show()
      $(".text").addClass( "opened-article" );

      if @path
        window.history.pushState('', '', @path)

      @markRead()

  bindCollapse: ->
    @readLessButton.on 'click', (e) =>
      e.preventDefault()
      @contentArea.css({ height: '0' })
      @readLessButton.hide()
      @readMoreButton.show()

  markRead: ->
    $.post("/posts/#{@id}/mark-read")

