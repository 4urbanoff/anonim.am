Nali.Model.extend Home:

  onUpdateGender: ->
    if @color? and @gender?
      @query 'users.create', gender: @gender, color: @color,
        ( token ) =>
          @redirect 'user/auth/' + token
        =>
          @redirect 'home'
