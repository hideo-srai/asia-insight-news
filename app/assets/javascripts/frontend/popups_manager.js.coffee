class window.PopupsManager
  constructor: () ->

  @closeAllModals: () ->
    $.each @modals, () ->
      @close()

  @createModals: () ->
    @freeTrialModal = new Modal("[data-free-trial-modal]")

    @modals = [
      @freeTrialModal,
    ]

  @initHandlers: () ->
    @initClickHandlers()
    # @initTimeoutHandlers()

  @initClickHandlers: () ->
    $('[data-open-free-trial-modal]').on 'click touchstart', (e) =>
      e.preventDefault()
      @closeAllModals()
      @freeTrialModal.open()

  @initTimeoutHandlers: () ->
#    if window.CookieReader.getRole() == 'guest'
#      setTimeout () =>
#        @closeAllModals()
#        @premiumPostModal.open()
#      , 10000
    if window.CookieReader.shouldSeeExpiredTrialModal()
      setTimeout () =>
        @closeAllModals()
        @expiredTrialModal.open()
      , 10000

    else
      if window.CookieReader.shouldSeeFewDaysExpirationModal()
        setTimeout () =>
          @closeAllModals()
          @fewDaysExpirationModal.open()
          $.cookie('seen_few_days_expiration_popup', 'true', { expires: 30, path: '/' })
        , 10000
      else
        if window.CookieReader.shouldSeeWeekExpirationModal()
          setTimeout () =>
            @closeAllModals()
            @weekExpirationModal.open()
            $.cookie('seen_week_expiration_popup', 'true', { expires: 30, path: '/' })
          , 10000
