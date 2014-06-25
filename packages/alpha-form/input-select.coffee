Template._each_input.events
  'keyup .input_select': (e, t) ->
    if e.which is 13
      one = HUMAN_FORM.findOne(
        _s_n: "form_sel"
        , _sel_id: @_id
        , class: "glow")
      if one
        HUMAN_FORM.update({_id: @_id}, {$set: {_v: one[@key_key]}})
        HUMAN_FORM.update({_id: @_id}, {$unset: {select_class: ""}})
      else
        sen = HUMAN_FORM.findOne(_s_n: "form_sel", _sel_id: @_id)
        if sen
          HUMAN_FORM.update({_id: @_id}, {$set: {_v: sen[@key_key]}})
          HUMAN_FORM.update({_id: @_id}, {$unset: {select_class: ""}})
    else if e.which is 9
      one = HUMAN_FORM.findOne(
        _s_n: "form_sel"
        , _sel_id: @_id
        , class: "glow")
      if one
        HUMAN_FORM.update({_id: @_id}, {$set: {_v: one[@key_key]}})
      else
        sen = HUMAN_FORM.findOne(_s_n: "form_sel", _sel_id: @_id)
        if sen
          HUMAN_FORM.update({_id: @_id}, {$set: {_v: sen[@key_key]}})
    else
      if not @select_class
        HUMAN_FORM.update({_id: @_id}, {$set: {select_class: "show"}})
      if e.which is 38
        if HUMAN_FORM.find(
          _s_n: "form_sel"
          , _sel_id: @_id
          , class: "glow").count() is 0
          HUMAN_FORM.update({
            _s_n: "form_sel"
            , _sel_id: @_id}, {$set: {class: "glow"}})
        else
          one = HUMAN_FORM.findOne({
            _s_n: "form_sel"
            , _sel_id: @_id
            , class: "glow"})
          HUMAN_FORM.update({_id: one._id}, {$unset: {class: ""}})
          s = one.sort - 1
          if s isnt -1
            up = HUMAN_FORM.update({
              _s_n: "form_sel"
              , _sel_id: @_id
              , sort: s}, {$set: {class: "glow"}})
            if up is 0
              HUMAN_FORM.update({
                _s_n: "form_sel"
                , _sel_id: @_id}, {$set: {class: "glow"}})
          else
            down = HUMAN_FORM.findOne({
              _s_n: "form_sel"
              , _sel_id: @_id}, {sort: {sort: -1}})
            HUMAN_FORM.update({
              _id: down._id}, {$set: {class: "glow"}})

      else if e.which is 40
        if HUMAN_FORM.find(
          _s_n: "form_sel"
          , _sel_id: @_id
          , class: "glow").count() is 0
          HUMAN_FORM.update({
            _s_n: "form_sel"
            , _sel_id: @_id}, {$set: {class: "glow"}})
        else
          one = HUMAN_FORM.findOne({
            _s_n: "form_sel"
            , _sel_id: @_id
            , class: "glow"})
          HUMAN_FORM.update({_id: one._id}, {$unset: {class: ""}})
          s = one.sort + 1
          if s < 6
            down = HUMAN_FORM.update({
              _s_n: "form_sel"
              , _sel_id: @_id
              , sort: s}, {$set: {class: "glow"}})
            if down is 0
              HUMAN_FORM.update({
                _s_n: "form_sel"
                , _sel_id: @_id}, {$set: {class: "glow"}})
          else
            up = HUMAN_FORM.findOne({
              _s_n: "form_sel"
              , _sel_id: @_id}, {sort: {sort: 1}})
            HUMAN_FORM.update({_id: down._id}, {$set: {class: "glow"}})
      else

        text = e.currentTarget.value
        if text?
          if text isnt this._v
            ids = []
            n = 0
            obj = {}
            obj._s_n = @key_s
            obj[@key_key] = { $regex: text, $options: 'i' }
            HUMAN_FORM.remove(_s_n: "form_sel", _sel_id: @_id)
            ids = human_form_insert_select(obj, @_id, ids)
            if ids.length < 5
              word = utilities.most_similar_string(
                DATA.find(_s_n: @key_s)
                @key_key
                text
                -1
                false
              )
              if word and ids.indexOf(word._id) is -1
                wen = ids.length
                ids = human_form_insert_select_one(word, @_id, ids, wen)
              if ids.length < 5
                str_l = text.length
                first_c = "^#{text.substr(0,1)}"
                obj[@key_key] = { $regex: first_c, $options: 'i' }
                obj._id = {$nin: ids}
                ids = human_form_insert_select(obj, @_id, ids)
                if ids.length < 5
                  obj._id = {$nin: ids}
                  delete obj[@key_key]
                  ids = human_form_insert_select(obj, @_id, ids)
            HUMAN_FORM.update({_id: @_id}, {$set: {_v: e.currentTarget.value}})
