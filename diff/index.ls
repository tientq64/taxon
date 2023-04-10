App =
   oninit: !->
      for k, val of @
         @[k] = val.bind @ if typeof val is \function
      @valA = localStorage.diffValA or ""
      @valB = localStorage.diffValB or ""
      @diffs = []
      @tails = {}
      @result = ""
      @parse!

   oninputValA: (event) !->
      @valA = event.target.value
      # localStorage.diffValA = @valA
      @parse!

   oninputValB: (event) !->
      @valB = event.target.value
      # localStorage.diffValB = @valB
      @parse!

   onFocusTextarea: (event) !->
      event.target.select!

   parse: !->
      vals = @valA / \\n
      valA = []
      tails = {}
      for val in vals
         index = val.search /\ [\\/|#].*/
         if index >= 0
            tail = val.substring index
            val = val.substring 0 index
         else
            tail = void
         if tails[val]?
            alert "Giá trị trùng nhau: #val"
            throw
         if tail
            tails[val] = tail
         valA.push val
      valB = @valB / \\n
      diffs = Diff.diffArrays valA, valB
      @diffs = diffs
      @tails = tails
      result = []
      for diff in diffs
         unless diff.removed
            for val in diff.value
               result.push val + (tails[val] or "")
      result *= \\n
      @result = result

   view: ->
      m \.flex.h-100,
         m \.w-third.flex.flex-column.ma2,
            m \.mv1 "Nhập danh sách loài cũ:"
            m \textarea.flex-auto.input-reset,
               value: @valA
               oninput: @oninputValA
               onfocus: @onFocusTextarea
            m \.mv1 "Nhập danh sách loài mới:"
            m \textarea.flex-auto.input-reset,
               value: @valB
               oninput: @oninputValB
               onfocus: @onFocusTextarea
         m \.w-third.ma2.flex.flex-column,
            m \.mv1 "So sánh khác nhau:"
            m \.flex-auto.overflow-auto.pre.ba.b--gray.diff,
               @diffs.map (diff) ~>
                  if diff.added
                     diff.value.map (val) ~>
                        m \.added,
                           val.substring 33
                           m \span.text (@tails[val] or "")
                  else if diff.removed
                     diff.value.map (val) ~>
                        m \.strike.removed,
                           val.substring 33
                           m \span.text (@tails[val] or "")
                  else
                     diff.value.map (val) ~>
                        m \div,
                           val.substring 33 or \\xa0
                           m \span.text (@tails[val] or "")
         m \.w-third.ma2.flex.flex-column,
            m \.mv1 "Kết quả:"
            m \textarea.flex-auto.input-reset,
               value: @result
               onfocus: @onFocusTextarea

m.mount appEl, App
