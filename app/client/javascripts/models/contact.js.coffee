Nali.Model.extend Contact:

  belongsTo: [
    'user'
    contact: model: 'user'
    'dialog'
  ]

  attributes:
    contact_id:
      format:  'number'
    user_id:
      format:  'number'
    dialog_id:
      format:  'number'
    active:
      default:  true
      format:  'boolean'
    counter:
      default: 0
      format:  'number'

  onDestroy: ->
    @Notice.info "#{ @contact.name } больше не хочет общаться с Вами, диалог удален" unless @destroyInitiator
    @redirect 'user' if @active

  fresh: ( params ) ->
    @Notice.info 'Вам подобран новый собеседник'
    @toDialog()

  toDialog: ->
    @redirect 'dialog/' + @dialog_id
    @

  activate: ->
    @upgrade active: true, counter: 0
    @user.hideDialogs()
    @

  deactivate: ->
    @upgrade active: false
    @

  delete: ->
    @destroyInitiator         = true
    @contact.destroyInitiator = true
    @dialog.destroy()
    @hideDelete()
