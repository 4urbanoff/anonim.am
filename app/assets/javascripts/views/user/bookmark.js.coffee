Nali.View.extend UserBookmark:
  
  insertTo: -> '.UserInterface' 
  
  events: [
    'hide on click at    .wrapper'
    'notHide on click at .dialog'
  ]

  helpers:
    hotkeys: ->
      ua = navigator.userAgent.lower()
      switch
        when 'mac'       in ua then 'Command/Cmd + D'
        when 'konqueror' in ua then 'Ctrl + B'
        else                        'Ctrl + D'
  
  onShow: ->
    @Application.setTitle 'iSite.im'
    @Router.setUrl 'user/auth/' + @Cookie.get 'token'
    
  onHide: ->
    @Application.setTitle 'Настройки'
    @Router.setUrl 'user/settings'

  notHide: ( event ) ->
    event.stopPropagation()
