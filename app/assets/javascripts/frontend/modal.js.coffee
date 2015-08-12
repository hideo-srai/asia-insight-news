class window.Modal
  HIDE_TIME = 300

  constructor: (modalEl) ->
    @modalEl = $(modalEl)
    @fadeEl = $('[data-fade-overlay]')

    @bindCloseButton()

  bindCloseButton: ->
    @modalEl.find('[data-close-modal]').on 'click touchstart', (e) =>
      e.preventDefault()
      @close()

  open: ->
    @fadeEl.stop().fadeIn(HIDE_TIME)
    @modalEl.stop().fadeIn(HIDE_TIME)

  close: ->
    @fadeEl.stop().fadeOut(HIDE_TIME)
    @modalEl.stop().fadeOut(HIDE_TIME)

