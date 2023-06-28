App =
   oninit: !->
      for k, val of @
         @[k] = val.bind @ if typeof val is \function
      @cfg = null
      @cssUnitless =
         animationIterationCount: yes
         borderImageOutset: yes
         borderImageSlice: yes
         borderImageWidth: yes
         boxFlex: yes
         boxFlexGroup: yes
         boxOrdinalGroup: yes
         columnCount: yes
         columns: yes
         flex: yes
         flexGrow: yes
         flexPositive: yes
         flexShrink: yes
         flexNegative: yes
         flexOrder: yes
         gridArea: yes
         gridRow: yes
         gridRowEnd: yes
         gridRowSpan: yes
         gridRowStart: yes
         gridColumn: yes
         gridColumnEnd: yes
         gridColumnSpan: yes
         gridColumnStart: yes
         fontWeight: yes
         lineClamp: yes
         lineHeight: yes
         opacity: yes
         order: yes
         orphans: yes
         tabSize: yes
         widows: yes
         zIndex: yes
         zoom: yes
         fillOpacity: yes
         floodOpacity: yes
         stopOpacity: yes
         strokeDasharray: yes
         strokeDashoffset: yes
         strokeMiterlimit: yes
         strokeOpacity: yes
         strokeWidth: yes
      @ranks =
         *  name: \domain
            prefixes:
               \domain
               \domains
               \super-?kingdom
               \super-?kingdoms
               \super-?regnum
               \super-?regna
               \vực
               "siêu giới"
            combo: \1+Backquote
         *  name: \kingdom
            prefixes:
               \kingdom
               \kingdoms
               \regnum
               \regna
               \giới
            combo: \1
         *  name: \subkingdom
            prefixes:
               \sub-?kingdom
               \sub-?kingdoms
               \sub-?regnum
               \sub-?regna
               "phân giới"
            combo: \1+2
         *  name: \infrakingdom
            prefixes:
               \infra-?kingdom
               \infra-?kingdoms
               \infra-?regnum
               \infra-?regna
               "thứ giới"
            combo: \1+3
         *  name: \superphylum
            prefixes:
               \super-?phylum
               \super-?division
               \super-?phylums
               \super-?divisions
               \super-?divisio
               \super-?phyla
               \super-?divisiones
               "liên ngành"
               "siêu ngành"
            combo: \2+1
         *  name: \phylum
            prefixes:
               \phylum
               \division
               \phylums
               \divisions
               \divisio
               \phyla
               \divisiones
               \ngành
            suffixes: <[ophyta mycota]>
            combo: \2
         *  name: \subphylum
            prefixes:
               \sub-?phylum
               \sub-?division
               \sub-?phylums
               \sub-?divisions
               \sub-?divisio
               \sub-?phyla
               \sub-?divisiones
               "phân ngành"
            suffixes: <[phytina mycotina]>
            combo: \2+3
         *  name: \infraphylum
            prefixes:
               \infra-?phylum
               \infra-?division
               \infra-?phylums
               \infra-?divisions
               \infra-?divisio
               \infra-?phyla
               \infra-?divisiones
               "thứ ngành"
            combo: \2+4
         *  name: \parvphylum
            prefixes:
               \parv-?phylum
               \micro-?phylum
               \parv-?phylums
               \micro-?phylums
               \parv-?divisio
               \micro-?divisio
               \parv-?phyla
               \micro-?phyla
               \parv-?divisiones
               \micro-?divisiones
               "tiểu ngành"
            combo: \2+5
         *  name: \superclass
            prefixes:
               \super-?class
               \super-?classes
               \super-?classis
               "liên lớp"
               "siêu lớp"
            combo: \3+2
         *  name: \class
            prefixes:
               \class
               \classes
               \classis
               \lớp
            suffixes: <[opsida phyceae mycetes]>
            combo: \3
         *  name: \subclass
            prefixes:
               \sub-?class
               \sub-?classes
               \sub-?classis
               "phân lớp"
            suffixes: <[phycidae mycetidae]>
            combo: \3+4
         *  name: \infraclass
            prefixes:
               \infra-?class
               \infra-?classes
               \infra-?classis
               "thứ lớp"
               "phân thứ lớp"
            combo: \3+5
         *  name: \parvclass
            prefixes:
               \parv-?class
               \parv-?classes
               \parv-?classis
               "tiểu lớp"
            combo: \3+6
         *  name: \legion
            prefixes:
               \legion
               \legions
               \đoàn
            combo: \4+2
         *  name: \supercohort
            prefixes:
               \super-?cohort
               \super-?cohorts
               \super-?cohors
               \super-?cohortes
               "liên đội"
            combo: \4+3
         *  name: \cohort
            prefixes:
               \cohort
               \cohorts
               \cohors
               \cohortes
               \đội
            combo: \4
         *  name: \magnorder
            prefixes:
               \magn-?order
               \mega-?order
               \magn-?orders
               \mega-?orders
               \magn-?ordo
               \mega-?ordo
               \magn-?ordines
               \mega-?ordines
               "tổng bộ"
               "đại bộ"
            combo: \5+3
         *  name: \superorder
            prefixes:
               \super-?order
               \super-?orders
               \super-?ordo
               \super-?ordines
               "liên bộ"
               "siêu bộ"
            suffixes: <[anae]>
            combo: \5+4
         *  name: \order
            prefixes:
               \order
               \orders
               \ordo
               \ordines
               \bộ
            suffixes: <[iformes ales]>
            combo: \5
         *  name: \suborder
            prefixes:
               \sub-?order
               \sub-?orders
               \sub-?ordo
               \sub-?ordines
               "phân bộ"
            suffixes: <[ineae]>
            combo: \5+6
         *  name: \infraorder
            prefixes:
               \infra-?order
               \infra-?orders
               \infra-?ordo
               \infra-?ordines
               "thứ bộ"
            suffixes: <[aria]>
            combo: \5+7
         *  name: \parvorder
            prefixes:
               \parv-?order
               \parv-?orders
               \parv-?ordo
               \parv-?ordines
               "tiểu bộ"
            combo: \5+8
         *  name: \section
            prefixes:
               \section
               \sections
               \sectio
               \sectiones
               \đoạn
            combo: \6+3
         *  name: \subsection
            prefixes:
               \subsection
               \subsections
               \subsectio
               \subsectiones
               "phân đoạn"
            combo: \6+4
         *  name: \superfamily
            prefixes:
               \super-?family
               \super-?families
               \super-?familia
               \super-?familiae
               "liên họ"
               "siêu họ"
            suffixes: <[oidea acea]>
            combo: \6+5
         *  name: \family
            prefixes:
               \family
               \families
               \familia
               \familiae
               \họ
            suffixes: <[idae aceae]>
            combo: \6
         *  name: \subfamily
            prefixes:
               \sub-?family
               \sub-?families
               \sub-?familia
               \sub-?familiae
               "phân họ"
            suffixes: <[inae oideae]>
            combo: \6+7
         *  name: \supertribe
            prefixes:
               \super-?tribe
               \super-?tribes
               \super-?tribus
               "liên tông"
            combo: \7+6
         *  name: \tribe
            prefixes:
               \tribe
               \tribes
               \tribus
               \tông
            suffixes: <[ini eae]>
            combo: \7
         *  name: \subtribe
            prefixes:
               \sub-?tribe
               \sub-?tribes
               \sub-?tribus
               "phân tông"
            combo: \7+8
         *  name: \genus
            prefixes:
               \genus
               \genera
               \chi
            combo: \8
         *  name: \subgenus
            prefixes:
               \sub-?genus
               \sub-?genera
               "phân chi"
            combo: \8+9
         *  name: \section
            prefixes:
               \section
               \sections
               \sectio
               \sectiones
               \mục
            combo: \8+0
         *  name: \subsection
            prefixes:
               \subsection
               \subsections
               \subsectio
               \subsectiones
               "phân mục"
            combo: \8+Minus
         *  name: \series
            prefixes:
               \series
               \loạt
            combo: \8+Equal
         *  name: \subseries
            prefixes:
               \subseries
               "phân loạt"
            combo: \8+Backspace
         *  name: \superspecies
            prefixes:
               \super-?species
               \complex
               "liên loài"
            combo: \9+8
         *  name: \species
            prefixes:
               \species
               \loài
            combo: \9
         *  name: \subspecies
            prefixes:
               \sub-?species
               "phân loài"
            combo: \9+0
         *  name: \variety
            prefixes:
               \variety
               \varieties
               \varietas
               \thứ
            combo: \9+Minus
         *  name: \form
            prefixes:
               \form
               \forms
               \forma
               \dạng
            combo: \9+Equal
      @ranks.prefixes = []
      @ranks.suffixes = []
      for rank, i in @ranks
         rank.lv = i
         rank.tab = \\t * i
         for text in rank.prefixes
            prefix =
               text: text
               regex: //#text//i
               startsRegex: //^#text[ \xa0:]+//i
               rank: rank
            @ranks.prefixes.push prefix
         if rank.suffixes
            for text in rank.suffixes
               suffix =
                  text: text
                  regex: //[A-Z][a-z]*#text//
                  startsRegex: //^[A-Z][a-z]*#text(?=[^a-z\-]|$)//
                  rank: rank
               @ranks.suffixes.push suffix
         @ranks[rank.name] = rank
      @ranks.prefixes.sort (a, b) ~>
         b.text.split(" ")length - a.text.split(" ")length or
         b.text.length - a.text.length
      @ranks.suffixes.sort (a, b) ~>
         b.text.length - a.text.length
      @regexes = {}
         ..prefixesStr = @ranks.prefixes.map (.text) .join \|
         ..prefixes = //(#{..prefixesStr})$//i
         ..startsPrefixes = //^(#{..prefixesStr})[ \xa0:]+//i
         ..extinct = /\b(tuyệt chủng|extinct|fossil)\b|†/i
         ..incSedis = /\b(incertae sedis|inc\. sedis|uncertain)\b/i
      @data = null
      @lineData = ["" "" "" ""]
      @notifies = []
      @modals = []
      @selection = getSelection!
      @selecting = no
      @sel = ""
      @token = null
      @album = null
      @canMiddleClick = yes
      @canContextMenu = no
      @comboRanks = []
      @resetCombo!
      @els = {}
      @shownUI = no
      @imgurEditRatio = 0
      @imgurEditRatioOrg = 0
      @imgurEditRatio1Img = (320 / 240)toFixed 3
      @imgurEditRatio2Img = (280 / 240)toFixed 3
      @inaturalistSearchImportedData = null
      window.addEventListener \selectionchange @onselectionchange, yes
      window.addEventListener \mousedown @onmousedown, yes
      window.addEventListener \mouseup @onmouseup, yes
      window.addEventListener \auxclick @onauxclick, yes
      window.addEventListener \contextmenu @oncontextmenu, yes
      window.addEventListener \keydown @onkeydown, yes
      window.addEventListener \keyup @onkeyup, yes
      window.addEventListener \visibilitychange @onvisibilitychange, yes
      if t.imgurAuth
         if el = document.querySelector ".authorize-banner-title>.green"
            if el.innerText is \tiencoffee
               document.getElementById \allow .click!
      else
         chrome.storage.local.get do
            <[cfg token tokenTime album inaturalistSearchImportedData]>
            ({@cfg = {}, @token, tokenTime, @album, @inaturalistSearchImportedData}) !~>
               unless t.imgur
                  unless @token and tokenTime + 6048e5 > Date.now!
                     await @getImgurToken!
                  unless @album
                     until await @getImgurAlbum! =>
               if t.inaturalistSearch
                  if @inaturalistSearchImportedData
                     @inaturalistSearchImportedData = JSON.parse @inaturalistSearchImportedData
                     @renderInaturalistSearchImportedData!
         switch
         | t.wiki
            switch
            | t.wikiPage
               @shownUI = yes
               @summ = null
               @lang = location.hostname.split \. .0
               @els
                  ..viLang = document.querySelector ".interlanguage-link-target[lang=vi]"
                  ..enLang = document.querySelector ".interlanguage-link-target[lang=en]"
                  ..esLang = document.querySelector ".interlanguage-link-target[lang=es]"
                  ..frLang = document.querySelector ".interlanguage-link-target[lang=fr]"
                  ..commons = document.querySelector ".wb-otherproject-commons > a"
                  ..species = document.querySelector ".wb-otherproject-species > a"
                  ..infoboxImg = document.querySelector ".infobox.biota a.image > img, .infobox.taxobox a.image > img"
                  ..infoboxLinkImg = ..infoboxImg?parentElement
               if el = document.querySelector '
               #Notes,#References,#External_links,#Reference\\/External_Links,#Sources,
               #Chú_thích,#Tham_khảo,#Liên_kết_ngoài'
                  el .= parentElement
                  do
                     nextEl = el.nextElementSibling
                     el.remove!
                  while el = nextEl
               @hasSubspecies = /sub-?species/i.test document.body.innerText
               if @els.commons
                  @prerender that.href
               if @els.viLang
                  @summ = yes
                  q = that.href.split \/ .[* - 1]
                  @summ = await (await fetch "https://vi.wikipedia.org/api/rest_v1/page/summary/#q")json!
                  m.redraw!
         | t.imgur
            switch
            | t.imgurEdit
               @shownUI = yes
               widthEl = document.getElementById \width
               heightEl = document.getElementById \height
               sizeEl = document.getElementById \crop-dimensions
               @imgurEditRatio = @imgurEditRatioOrg = +(widthEl.value / heightEl.value)toFixed 3
               window.addEventListener \mousemove (event) !~>
                  if event.which is 1
                     [, w, h] = /^(\d+)x(\d+)$/exec sizeEl.innerText
                     @imgurEditRatio = +(w / h)toFixed 3
                     m.redraw!
               for el in [widthEl, heightEl]
                  el.addEventListener \change (event) !~>
                     @imgurEditRatio = @imgurEditRatioOrg = +(widthEl.value / heightEl.value)toFixed 3
                     m.redraw!
            | t.imgurView
               usp = new URLSearchParams location.search
               if usp.get \_taxonDelete
                  timer = setInterval !~>
                     if el = document.querySelector \.image-delete
                        el.click!
                        clearInterval timer
                        setTimeout !~>
                           el = document.querySelector \.DeleteImageDialog-confirm--accountRemove
                           el.click!
                           timer2 = setInterval !~>
                              unless document.querySelector \.image-delete
                                 @closeTab!
                           , 500
                        , 100
                  , 500
            else
               if location.search is \?state=taxon
                  @token = /access_token=([a-z\d]+)/exec location.hash .1
                  chrome.storage.local.set do
                     token: @token
                     tokenTime: Date.now!
                     @closeTab
         | t.inaturalist
            switch
            | t.inaturalistSearch
               els = document.querySelectorAll ".taxon_list_taxon > .noimg"
               for el in els
                  el.remove!
         | t.biolib
            setTimeout !~>
               document.activeElement.blur!
            , 10

   oncreate: !->
      if t.wiki
         if el = document.querySelector \#toc
            _toc.appendChild el

   class: (...classes) ->
      res = []
      for cls in classes
         if Array.isArray cls
            res.push @class ...cls
         else if cls instanceof Object
            for k, v of cls
               res.push k if v
         else if cls?
            res.push cls
      res * " "

   style: (...styls) ->
      res = {}
      for styl in styls
         if Array.isArray styl
            styl = @style ...styl
         if styl instanceof Object
            for k, val of styl
               res[k] = val
               res[k] += \px if not @cssUnitless[k] and +val
      res

   upperFirst: (text) ->
      text.charAt 0 .toUpperCase! + text.substring 1

   table: (table) ->
      grid = []
      for row, y in table.rows
         for cell, x in row.cells
            rowSpan = cell.rowSpan
            colSpan = cell.colSpan
            while grid[x]?[y]? => x++
            for i from x til x + colSpan
               resRow = grid[][i]
               for j til rowSpan
                  resRow.row = row
                  resRow[y + j] = if i is x and not j => cell else no
      grid.filter (.length)

   tableCol: (td) ->
      table = td.closest \table
      grid = @table table
      col = grid.find (.includes td)
      col
         .slice col.indexOf td
         .filter Boolean

   findRank: (kind, fn) ->
      if typeof kind is \function
         [kind, fn] = [, kind]
      ranks = kind and @ranks[kind] or @ranks
      if rank = ranks.find fn
         rank = rank.rank if kind
         rank

   resetCombo: !->
      @combo = ""
      @modfCombo = ""
      @lastCode = void
      @target = null
      @node = null
      @nodeOffset = null

   makeModfCombo: (event) !->
      @modfCombo = ""
      @modfCombo += \Ctrl+ if event.ctrlKey
      @modfCombo += \Shift+ if event.shiftKey
      @modfCombo += \Alt+ if event.altKey
      @modfCombo += \Meta+ if event.metaKey

   onselectionchange: (event) !->
      @sel = @selection + ""
      if @sel and @combo is \LMB
         @selecting = yes

   onmousedown: (event) !->
      {which} = event
      event.preventDefault! if event.shiftKey
      @lastCode = which
      which = [, \LMB \MMB \RMB][which]
      @makeModfCombo event
      @combo += (@combo and \+ or '') + which

   onmouseup: (event) !->
      {which} = event
      if @lastCode is which
         @oncombo event

   onauxclick: (event) !->
      unless @canMiddleClick
         event.preventDefault!
         @canMiddleClick = yes

   oncontextmenu: (event) !->
      if @canContextMenu
         @canContextMenu = no
      else if not event.target.closest \._rightClickZone
         event.preventDefault!

   onkeydown: (event) !->
      unless event.repeat
         {code, key} = event
         @lastCode = code
         if event.altKey and code in [\KeyE \KeyF]
            event.preventDefault!
         if key in <[Control Shift Alt Meta]>
            if @combo
               @resetCombo!
         else
            @makeModfCombo event
            code -= /^(Key|Digit)/
            @combo += (@combo and \+ or '') + code
         combo = @modfCombo + @combo
         switch combo
         | \Ctrl+Shift+S
            @resetCombo!

   onkeyup: (event) !->
      if @lastCode is event.code
         @oncombo event

   onvisibilitychange: (event) !->
      @resetCombo!

   oncombo: (event) !->
      if @selecting
         @selecting = no
      else
         if not @sel and event.type is \mouseup
            @target = event.target
            @node = @selection.anchorNode
            @nodeOffset = @selection.anchorOffset
         el = document.activeElement
         if @combo and el.localName not in <[input textarea select]> and not el.isContentEditable
            @combo = @modfCombo + @combo
            sel = @sel.trim!
            @doCombo @combo, @target, sel, event, []
      @resetCombo!

   mark: (els) !->
      if els
         if els instanceof Node
            els = [els]
         for let el in els
            if el
               if el.nodeName is \#text
                  range = document.createRange!
                  range.selectNode el
                  el = range
               rects = el.getClientRects!
               for {x, y, width, height} in rects
                  markEl = document.createElement \div
                  markEl.className = \_mark
                  document.body.appendChild markEl
                  anim = markEl.animate do
                     *  left: [x + \px, x - 3 + \px]
                        top: [y + \px, y - 3 + \px]
                        width: [width + \px, width + 6 + \px]
                        height: [height + \px, height + 6 + \px]
                        background: [\#07d2 \#07d0]
                        boxShadow: ['0 0 0 2px #07d' '0 0 0 2px #07d0']
                     *  duration: 150
                  anim.onfinish = !~>
                     markEl.remove!

   emptySel: !->
      @selection.removeAllRanges!

   copy: (text) ->
      if text?
         if navigator.clipboard
            that.writeText text
         else
            el = document.createElement \textarea
            el.className = \_copy
            el.value = text
            el.onblur = el.focus.bind el
            document.body.appendChild el
            document.activeElement.blur!
            el.select!
            document.execCommand \copy
            el.remove!

   openLinksExtract: (targets, noOpen) !->
      urls = []
      @data = @extract targets,
         link: (target, link) !~>
            return if noOpen and urls.length >= 10
            unless target.dataset.openedLi
               target.dataset.openedLi = 1
               if link
                  unless link.classList.contains \new
                     link.dataset.openedA = 1
                     urls.push link.href
      if urls.length
         unless noOpen
            @copy @data
            chrome.runtime.sendMessage do
               act: \openUrls
               urls: urls
      else
         @notify "Đã mở hết link"

   prerender: (url) !->
      link = document.createElement \link
      link.rel = \prerender
      link.href = url
      document.head.appendChild link

   setCfg: (prop, val, cb) !->
      @cfg[prop] = val
      chrome.storage.local.set {@cfg}, cb

   openTabGetImgurToken: ->
      window.open do
         \https://api.imgur.com/oauth2/authorize?client_id=92ac14aabe20918&response_type=token&state=taxon

   closeTab: ->
      chrome.runtime.sendMessage \closeTab

   readAsBase64: (file) ->
      new Promise (resolve) !~>
         reader = new FileReader
         reader.onload = !~>
            resolve it.target.result - /^data:[a-z\d-]+\/[a-z\d-]+;base64,/
         reader.readAsDataURL file

   readCopiedImgBlob: ->
      [item] = await navigator.clipboard.read!
      if item
         [type] = item.types.filter (.startsWith \image/)
         item.getType type if type

   numToRadix62: (num) ->
      chrs = \0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
      base = chrs.length
      res = ""
      sign = num < 0 and \- or ""
      num = Math.floor Math.abs num
      do
         i = Math.floor num % base
         res = chrs[i] + res
      while num = Math.floor num / base
      sign + res

   uploadImgur: ({image, type = \URL, isOpenNewTab, isFemale}) !->
      if @token and @album
         {album} = @
         notify = @notify "Đang upload ảnh Imgur" -1
         formData = new FormData
            ..append \image image
            ..append \album album
            ..append \type type
         res = await fetch \https://api.imgur.com/3/image,
            method: \post
            headers:
               "Authorization": "Bearer #@token"
            body: formData
            background: yes
         if res.ok
            res = await res.json!
            if res.success
               {id, deletehash} = res.data
               notify.update "Đã upload ảnh Imgur: #id"
               sep = isFemale and \| or \#
               await @copy " #sep -#id"
               url = "https://imgur.com/edit?deletehash=#deletehash&album_id=#album&_taxonId=#id"
               if isOpenNewTab
                  window.open url
               else
                  location.href = url
            else
               notify.update "Upload ảnh Imgur thất bại"
         else
            notify.update "Không thể upload ảnh Imgur"
      else
         @notify "Chưa có token hoặc album"

   modalGetAlbums: ->
      new Promise (resolve) !~>
         if @token
            res = await fetch \https://api.imgur.com/3/account/tiencoffee/albums,
               headers:
                  "Authorization": "Bearer #@token"
            res = await res.json!
            if res.success
               albums = res.data
               album = await @modal "Chọn album Imgur",, (modal) ~>
                  m \._row6._gap2,
                     albums.map (album) ~>
                        m \._col._p2._column._center._round6._cursorPointer._hover,
                           class: @class do
                              "_active": @album is album.id
                           style: @style do
                              width: 80
                           onclick: !~>
                              modal.close album.id
                           m \img._round4,
                              src: "https://i.imgur.com/#{album.cover}s.png"
                              width: 48
                              height: 48
                           m \small album.images_count
                           m \small album.privacy
                           m \small album.title
                     m \._col._p2._column._center._round6._hover,
                        onclick: !~>
                           @modalCreateAlbum!
                        m \h1._border0 \+
                        m \small "Tạo album"
               resolve album
            else
               @notify "Lấy album Imgur thất bại"
         else
            resolve!

   modalCreateAlbum: ->
      new Promise (resolve) !~>
         data = await @modal "Tạo album Imgur",, (modal) ~>
            m \form,
               onsubmit: (event) !~>
                  event.preventDefault!
                  if @token
                     formData = new FormData
                        ..title = event.target.title.value
                        ..privacy = \hidden
                     res = await fetch \https://api.imgur.com/3/album,
                        method: \post
                        headers:
                           "Authorization": "Bearer #@token"
                        body: formData
                     res = await res.json!
                     if res.success
                        albumId = res.data.id
                        @notify "Đã tạo album Imgur: #albumId"
                        modal.close res.data
                        @getImgurAlbum albumId
                     else
                        @notify "Tạo album Imgur thất bại"
               m \p,
                  m \div "Tên album:"
                  m \input._input._mt2,
                     name: \title
                     required: yes
                     autocomplete: \off
                  m \._textRight._mt2,
                     m \button._button \OK
         resolve data

   getImgurToken: ->
      new Promise (resolve) !~>
         tab = @openTabGetImgurToken!
         timer = setInterval !~>
            if tab.closed
               clearInterval timer
               chrome.storage.local.get [\token] ({@token}) !~>
                  @notify "Đã đặt token Imgur: #@token"
                  resolve @token
         , 1000

   getImgurAlbum: (albumId) ->
      new Promise (resolve) !~>
         album = albumId or await @modalGetAlbums!
         if album
            chrome.storage.local.set {album} !~>
               @album = album
               @notify "Đã đặt album Imgur: #@album"
               resolve album
         else resolve!

   modalImgGithub: ({image, isFemale}) !->
      loaded = no
      img = new Image
      imgW = 0
      imgH = 0
      maxWidth = 320
      maxHeight = 240
      ratioMax = maxWidth / maxHeight
      width = 0
      height = 0
      ratio = 0
      g = void
      sel = void
      res = void
      modal = void
      copied = no
      compressed = no
      saved = no
      filename = void
      base64 = void
      size = void
      edges = [[0 -1] [-1 0] [1 0] [0 1] [-1 -1] [1 -1] [-1 1] [1 1]]
      resize = (w, h) !~>
         imgW := w
         imgH := h
         ratio := imgW / imgH
         if ratio >= ratioMax
            width := maxWidth
            height := Math.round width / ratio
         else
            height := maxHeight
            width := Math.round height * ratio
         loaded := yes
         m.redraw.sync!
         g := imgGithubCanvasEl.getContext \2d
      updateSelCropPos = (onlyXY) !~>
         sel.cx = Math.round sel.l / width * imgW
         sel.cy = Math.round sel.t / height * imgH
         unless onlyXY
            sel.cw = Math.round sel.w / width * imgW
            sel.ch = Math.round sel.h / height * imgH
            sel.ratio = sel.cw / sel.ch
      crop = !~>
         if sel and sel.phase < 2
            imgdata = g.getImageData sel.cx, sel.cy, sel.cw, sel.ch
            resize sel.cw, sel.ch
            g.putImageData imgdata, 0 0
            sel := void
            m.redraw!
      compress = (sharpen) !~>
         new Promise (resolve) !~>
            unless compressed
               compressed := yes
               m.redraw!
               unless window.pica
                  code = await (await fetch \https://cdn.jsdelivr.net/npm/pica@8.0.0/dist/pica.min.js)text!
                  window.eval code
               pic = new window.pica
               canvas = document.createElement \canvas
               canvas.width = width
               canvas.height = height
               if sharpen
                  await pic.resize imgGithubCanvasEl, canvas,
                     unsharpAmount: 80
                     unsharpRadius: 0.6
                     unsharpThreshold: 2
               else
                  await pic.resize imgGithubCanvasEl, canvas
               resize width, height
               g.drawImage canvas, 0 0
               dataUrl = canvas.toDataURL \image/webp 0.9
               img.src = dataUrl
               img.onload = !~>
                  g.drawImage img, 0 0
                  base64 := dataUrl.split \, .1
                  size := atob base64 .length
                  m.redraw!
      save = !~>
         unless saved
            saved := yes
            crop!
            filename := @numToRadix62 Date.now! / 100 - 16378201202
            unless window.Octokit
               {Octokit} = await import \https://cdn.skypack.dev/@octokit/rest?min
               window.Octokit = Octokit
            octo = new Octokit do
               auth: OCTOKEN
            res := await octo.repos.createOrUpdateFileContents do
               owner: \tiencoffee
               repo: \taimg
               path: "#filename.webp"
               message: image
               content: base64
            if res.status is 201
               @copy " #{isFemale and \| or \#} =#filename"
            else
               saved := no
            m.redraw!
      @modal "Tải hình ảnh lên Github",, (modal$) ~>
         modal := modal$
         m \.imgGithubModal,
            if loaded
               m \._row._top._gap4,
                  m \._col._relative,
                     m \canvas._block._outline#imgGithubCanvasEl,
                        style: @style do
                           width: width
                           height: height
                        width: imgW
                        height: imgH
                        onpointerdown: (event) !~>
                           event.redraw = no
                           imgGithubCanvasEl.setPointerCapture event.pointerId
                           sel :=
                              x: event.offsetX
                              y: event.offsetY
                              phase: 2
                           m.redraw!
                        onpointermove: (event) !~>
                           event.redraw = no
                           if sel and sel.phase
                              {offsetX, offsetY} = event
                              {x, y} = sel
                              sel.phase = 1
                              if offsetX < 0
                                 l = 0
                                 w = x
                              else if offsetX > width
                                 l = x
                                 w = width - x
                              else
                                 l = if offsetX < x => offsetX else x
                                 w = Math.abs offsetX - x
                              r = l + w
                              if offsetY < 0
                                 t = 0
                                 h = y
                              else if offsetY > height
                                 t = y
                                 h = height - y
                              else
                                 t = if offsetY < y => offsetY else y
                                 h = Math.abs offsetY - y
                              b = t + h
                              updateSelCropPos!
                              sel <<< {l, t, w, h, r, b}
                              m.redraw!
                        onlostpointercapture: (event) !~>
                           event.redraw = no
                           if sel
                              if sel.phase is 1
                                 sel.phase = 0
                              else
                                 sel := void
                              m.redraw!
                     if sel and sel.phase < 2
                        m \#imgGithubSelEl,
                           style: @style do
                              left: sel.l
                              top: sel.t
                              width: sel.w
                              height: sel.h
                           onpointerdown: (event) !~>
                              event.redraw = no
                              if event.target is imgGithubSelEl
                                 if sel
                                    imgGithubSelEl.setPointerCapture event.pointerId
                                    sel <<<
                                       x: event.x - imgGithubCanvasEl.offsetLeft
                                       y: event.y - imgGithubCanvasEl.offsetTop
                                       l0: sel.l
                                       t0: sel.t
                                       move: yes
                                    m.redraw!
                           onpointermove: (event) !~>
                              event.redraw = no
                              if sel and sel.move
                                 mx = event.x - imgGithubCanvasEl.offsetLeft
                                 my = event.y - imgGithubCanvasEl.offsetTop
                                 {w, h} = sel
                                 l = sel.l0 + mx - sel.x
                                 t = sel.t0 + my - sel.y
                                 r = l + w
                                 b = t + h
                                 if l < 0
                                    l = 0
                                 else if r > width
                                    l = width - w
                                 if t < 0
                                    t = 0
                                 else if b > height
                                    t = height - h
                                 r = l + w
                                 b = t + h
                                 updateSelCropPos yes
                                 sel <<< {l, t, r, b}
                                 m.redraw!
                           onlostpointercapture: (event) !~>
                              event.redraw = no
                              if sel and sel.move
                                 sel.move = no
                                 m.redraw!
                           m \.imgGithubSelEdges,
                              edges.map (edge) ~>
                                 m \.imgGithubSelEdge,
                                    style: @style do
                                       left: edge.0 * 50 + 50 + \%
                                       top: edge.1 * 50 + 50 + \%
                                    onpointerdown: (event) !~>
                                       event.redraw = no
                                       if sel
                                          event.target.setPointerCapture event.pointerId
                                          sel <<<
                                             x: event.x - imgGithubCanvasEl.offsetLeft
                                             y: event.y - imgGithubCanvasEl.offsetTop
                                             l0: sel.l
                                             t0: sel.t
                                             w0: sel.w
                                             h0: sel.h
                                             r0: sel.r
                                             b0: sel.b
                                             resize: yes
                                          m.redraw!
                                    onpointermove: (event) !~>
                                       event.redraw = no
                                       if sel and sel.resize
                                          mx = event.x - imgGithubCanvasEl.offsetLeft
                                          my = event.y - imgGithubCanvasEl.offsetTop
                                          dx = mx - sel.x
                                          dy = my - sel.y
                                          {l, t, w, h, r, b} = sel
                                          if edge.0
                                             w = sel.w0 + dx * edge.0
                                          if edge.0 is -1
                                             l = sel.l0 + dx
                                             if l < 0
                                                l = 0
                                                w = sel.r0
                                             else if l > sel.r0
                                                l = sel.r0
                                                w = 0
                                          else if edge.0 is 1
                                             r = l + w
                                             if r > width
                                                w = width - sel.l0
                                             else if r < sel.l0
                                                w = 0
                                             r = l + w
                                          if edge.1
                                             h = sel.h0 + dy * edge.1
                                          if edge.1 is -1
                                             t = sel.t0 + dy
                                             if t < 0
                                                t = 0
                                                h = sel.b0
                                             else if t > sel.b0
                                                t = sel.b0
                                                h = 0
                                          else if edge.1 is 1
                                             b = t + h
                                             if b > height
                                                h = height - sel.t0
                                             else if b < sel.t0
                                                h = 0
                                             b = t + h
                                          updateSelCropPos!
                                          sel <<< {l, t, w, h, r, b}
                                          m.redraw!
                                    onlostpointercapture: (event) !~>
                                       event.redraw = no
                                       if sel and sel.resize
                                          sel.resize = no
                                          m.redraw!
                  m \._column._gap3,
                     style:
                        minWidth: \200px
                     m \div,
                        class: @class do
                           ratio < ratioMax and \_textRed or \_textGreen
                        "Tỷ lệ: " + ratio.toFixed 3
                     m \._row._middle._gap3,
                        "w:"
                        m \input._col,
                           value: imgW
                        "h:"
                        m \input._col,
                           value: imgH
                     if sel and sel.phase < 2
                        m.fragment do
                           m \div,
                              class: @class do
                                 sel.ratio < ratioMax and \_textRed or \_textGreen
                              "Tỷ lệ: " + sel.ratio.toFixed 3
                           m \._row._middle._gap3,
                              "w:"
                              m \input._col,
                                 type: \number
                                 value: sel.cw
                                 oninput: (event) !~>
                                    val = event.target.valueAsNumber
                                    if val?
                                       sel.w = val / imgW * width
                                       updateSelCropPos!
                              "h:"
                              m \input._col,
                                 type: \number
                                 value: sel.ch
                                 oninput: (event) !~>
                                    val = event.target.valueAsNumber
                                    if val?
                                       sel.h = val / imgH * height
                                       updateSelCropPos!
                           m \._row._middle._gap3,
                              "x:"
                              m \input._col,
                                 type: \number
                                 value: sel.cx
                                 oninput: (event) !~>
                                    val = event.target.valueAsNumber
                                    if val?
                                       sel.l = val / imgW * width
                                       updateSelCropPos yes
                              "y:"
                              m \input._col,
                                 type: \number
                                 value: sel.cy
                                 oninput: (event) !~>
                                    val = event.target.valueAsNumber
                                    if val?
                                       sel.t = val / imgH * height
                                       updateSelCropPos yes
                           m \button,
                              onclick: (event) !~>
                                 crop!
                              "Cắt ảnh"
                           m \div,
                     if size
                        m \div,
                           "Kích thước: #{(size / 1024)toFixed 2} KB"
                     unless base64
                        m.fragment do
                           m \button,
                              disabled: compressed or saved
                              onclick: (event) !~>
                                 compress no
                              "Nén mặc định"
                           m \button,
                              disabled: compressed or saved
                              onclick: (event) !~>
                                 compress yes
                              "Nén sắc nét"
                     if res
                        if res.status is 201
                           m \._row._middle._gapX3._textGreen,
                              "Đã tải lên: "
                              m \._select._cursorCopy,
                                 onclick: (event) !~>
                                    @copy " # =#filename"
                                 oncontextmenu: (event) !~>
                                    @copy " | =#filename"
                                 "=#filename"
                        else
                           m \._textRed "Đã xảy ra lỗi"
                     m \button,
                        disabled: saved
                        onclick: (event) !~>
                           save!
                        "Lưu"
            else
               m \._column._center,
                  m \img._contain._bgBlack._rightClickZone,
                     style: @style do
                        maxWidth: maxWidth
                        maxHeight: maxHeight
                     src: image
                     oncontextmenu: !~>
                        copied := yes
                  m \._my4._textSmall._textGray "Sao chép ảnh trên, sau đó bấm tiếp tục"
                  m \button,
                     disabled: not copied
                     onclick: !~>
                        blob = await @readCopiedImgBlob!
                        url = await @readAsBase64 blob
                        url = "data:#{blob.type};base64,#url"
                        img.src = url
                        img.onload = !~>
                           resize img.naturalWidth, img.naturalHeight
                           g.drawImage img, 0 0 imgW, imgH
                     "Tiếp tục"

   notify: (html, ms) ->
      notify =
         html: ""
         ms: 0
         timer: 0
         update: (html, ms = 2000) !~>
            notify.html? = html
            notify.ms = ms
            clearTimeout notify.timer
            if ms >= 0
               notify.timer = setTimeout !~>
                  @notifies.splice @notifies.indexOf(notify), 1
                  m.redraw!
               , ms
            m.redraw!
      @notifies.push notify
      notify.update html, ms
      notify

   modal: (title, width, view) ->
      new Promise (resolve) !~>
         modal =
            title: title
            width: width
            view: view
            close: (val) !~>
               @modals.splice @modals.indexOf(modal), 1
               resolve val
               m.redraw!
         @modals.push modal
         m.redraw!

   extract: (targets, opts = {}, parent, items = [], index = 0) ->
      if typeof targets is \string
         targets = targets
            .trim!
            .split /\n+/
            .filter (.trim!)
      unless \length of targets
         targets = [targets]
      targets = Array.from targets
      opts = {
         notMatchText: \?
         deep: no
         ranks: @comboRanks
         ...opts
      }
      notMatchTab = void
      formatItems = (items) !~>
         if items.length
            if parent
               if items.every (.0.extinct)
                  for item in items
                     item.0.extinct = ""
                  parent.extinct = \*
         uniqItems = []
         uniqTexts = []
         for item in items
            itemName = item.0.name - \*
            if itemName is \? or not uniqTexts.includes itemName
               uniqItems.push item
               uniqTexts.push itemName
         items.splice 0 Infinity, ...uniqItems
         items.sort (a, b) ~>
            a.0.extinct.length - b.0.extinct.length or
            (a.0.name is \?) - (b.0.name is \?) or
            (a.0.name is \_) - (b.0.name is \_)
      for target, i in targets
         isElTarget = target instanceof Element
         name = void
         rank = opts.ranks[index]
         formRegex = //
            ^[A-Z]([a-z]+|\.)?\s
            ([a-z-]{2,}|[a-z]\.)\s+
            ([a-z-]{2,}|[a-z]\.)\s+
            f\.\s
            ([a-z-]{2,})
         //
         varietyRegex = //
            ^[A-Z]([a-z]+|\.)?\s
            ([a-z-]{2,}|[a-z]\.)\s+
            var\.\s
            ([a-z-]{2,})
         //
         varietyNameRegex = /^[a-z]{2,}$/
         subspeciesRegex = //
            ^[A-Z]([a-z]+|\.)?\s
            (?:\([A-Z]\.\)\s)?
            (\([a-z-]{2,}\)|[a-z-]{2,}|[a-z]\.)\s
            (?:subsp\.\s)?
            ([a-z-]{2,})
         //
         subspeciesNameRegex = /^[a-z]{2,}$/
         speciesRegex = /^[A-Z]([a-z]+|\.)\s([A-Z]([a-z]+|\.)\s)?([a-z-]{2,})/
         otherRankRegex = /^([A-Z][a-z]+)/
         if isElTarget
            if target.childNodes.length is 1 and target.firstElementChild?matches "ul, ol, dl"
               @extract target.firstChild.children,
                  opts
                  parent
                  items
                  index + 1
               continue
            targetText = target.innerText
               .trim!
               .split \\n 1 .0
               .trim!
         else
            targetText = target.trim!
         extinct = parent?extinct ? ""
         unless extinct
            if @regexes.extinct.test targetText
               extinct = \*
         targetText = targetText
            .replace @regexes.extinct, ""
            .trim!
         if isElTarget
            links = [...target.querySelectorAll ":scope > i > a, :scope > b > a, :scope > a"]
            if links.length
               for link in links
                  innerText = link.innerText.trim!
                  switch
                  | innerText is \†
                     link.dataset.excl = 1
                  # | @regexes.prefixes.test innerText
                  # 	link.dataset.excl = 1
                  else
                     opts.link? target, link
            nameEl = null
            unless nameEl
               if el = target.querySelector ':scope > a > .toctext'
                  if el.innerText.trim!0 is /[A-Z]/
                     nameEl = el
            unless nameEl
               if el = target.querySelector ':scope > a:not([data-excl])'
                  if el.nextSibling?textContent.0 is \:
                     nameEl = el
            unless nameEl
               if el = target.querySelector ':scope > i:first-child'
                  if el.innerText.trim!0 is /[A-Z]/
                     nameEl = el
            unless nameEl
               if el = target.querySelector ':scope > i > a:not([data-excl])'
                  val = el.innerText.trim!
                  if val.0 is /[A-Z]/
                     if rank
                        if rank.lv is 38 and speciesRegex.test val or rank.lv is 39 and subspeciesRegex.test val
                           nameEl = el
                     else
                        nameEl = el
            unless nameEl
               if el = target.querySelector ':scope > b > a:not([data-excl])'
                  if el.innerText.trim!0 is /[A-Z]/
                     nameEl = el
            unless nameEl
               if el = target.querySelector ':scope > i'
                  if el.innerText.trim!
                     nameEl = el
            unless nameEl
               if el = target.querySelector ':scope > a:not([data-excl])'
                  nameEl = el
            if nameEl
               if nameEl.localName is \i and (node = nameEl.nextSibling) and node.nodeName is \#text
                  if node.wholeText is /^( subsp\. | sp\. | +var\. )/
                     nameEl = null
                  else if node.wholeText.trim! is \f.
                     if el = nameEl.nextElementSibling
                        name = el.innerText
                        nameEl = null
            if nameEl
               name = nameEl.innerText.trim!
         name ?= targetText
         name = name
            .replace @regexes.startsPrefixes, ""
            .replace /["'?]|=.+$/g ""
            .replace /^([A-Z][a-z]+) \([A-Z][a-z]+\)( [a-z]{2,})$/ \$1$2
            .replace /\([A-Z]\.\)\s/ ""
            .replace /[()]/g ""
         # if name is /^[A-Z][a-z]+ \(([A-Z][a-z]+)\) [a-z]{2,}$/
         # 	subgenera[that.1] = yes
         if /\ cf\. |(?<!sub)sp\. | sp\. (?![a-z])/ is name
            continue
         tab = void
         rank ?= @findRank \prefixes (.startsRegex.test targetText)
         rank ?= @findRank \suffixes (.startsRegex.test name)
         tab = rank?tab ? ""
         notMatchTab ?= tab
         if rank
            switch
            | rank.lv is 41
               if matched = formRegex.exec name
                  name = matched.4
               name .= split " " .0
            | rank.lv is 40
               if matched = varietyRegex.exec name
                  name = matched.3
               else if matched = varietyNameRegex.exec name
                  name = matched.0
               else
                  name = opts.notMatchText
            | rank.lv is 39
               if matched = subspeciesRegex.exec name
                  name = matched.3
               else if matched = subspeciesNameRegex.exec name
                  name = matched.0
               else
                  name = opts.notMatchText
            | rank.lv is 38
               if matched = speciesRegex.exec name
                  name = matched.4
               else
                  name = opts.notMatchText
            | @regexes.incSedis.test name
               name = \?
            | matched = otherRankRegex.exec name
               name = matched.1
            else
               name = opts.notMatchText
         else
            switch
            | @regexes.incSedis.test name
               name = \?
               tab = notMatchTab
            | matched = varietyRegex.exec name
               name = matched.3
               tab = @ranks.variety.tab
            | matched = subspeciesRegex.exec name
               name = matched.3
               tab = @ranks.subspecies.tab
            | matched = speciesRegex.exec name
               name = matched.4
               tab = @ranks.species.tab
            | matched = otherRankRegex.exec name
               name = matched.1
               tab = @ranks.genus.tab
            else
               name = opts.notMatchText
               tab = notMatchTab
         if nameEl
            if aEl = nameEl.querySelector 'a[href*="_("]'
               ma = /_\((.+?)\)/exec aEl
               name += " \\#{ma.1}"
         text = void
         if tab.length in [38 39]
            if target instanceof Element
               textEl = null
               do !~>
                  if el = target.querySelector ':scope > a:first-child'
                     textEl := el
                     return
                  if el = target.querySelector ':scope > i + small + span'
                     if val = el.nextSibling?textContent
                        if mat = val.match /\((.+?)\)/
                           text := mat.1
                           return
                  if el = target.querySelector ':scope > i + small'
                     if val = el.nextSibling?textContent
                        if mat = val.match /\((.+?)\)/
                           text := mat.1
                           return
                        if mat = val.match /^ – (.+?)$/
                           text := mat.1
                           return
                  if el = target.querySelector ':scope > i + span'
                     if val = el.nextSibling?textContent
                        if mat = val.match /^ \u2013 (.+)$/
                           text := mat.1
                           return
                  if el = target.querySelector ':scope > i'
                     if val = el.nextSibling?wholeText
                        if val.includes " – "
                           val = val.replace " – " "" .trim!
                           unless val.endsWith \(
                              return
               if textEl
                  if textEl is nameEl
                     textEl = null
               if textEl
                  text = textEl.innerText
               if text
                  text = text.split /, ?/ 1 .0
                  text = @upperFirst text
         item =
            *  tab: tab
               name: name
               text: text
               extinct: extinct
            *  []
         if i
            if tab.length < items.0.0.tab.length
               notMatchTab = tab
               newItem =
                  *  tab: tab
                     name: \_
                     extinct: ""
                  *  items.splice 0
               items.0 = newItem
               formatItems newItem.1
         if opts.deep and isElTarget
            if ul = target.querySelector "ul, ol, dl"
               @extract ul.children,
                  opts
                  item.0
                  item.1
                  index + 1
         items.push item
      formatItems items
      unless parent
         items = items
            .flat Infinity
            .map (item) ~>
               val = \\n + item.tab + item.name + item.extinct
               if item.text
                  val += " # " + item.text
               val
            .join ""
         @comboRanks = []
         m.redraw!
      items

   doCombo: (combo, target, sel, event, args) !->
      doCombo = (combo2 = combo, target2 = target, sel2 = sel, args2 = args) !~>
         @doCombo combo2, target2, sel2, event, args2
      comboIncludes = (...keys) ~>
         //(^|\+)(#{keys.join \|})(\+|$)//test combo
      if @modals.length
         return
      if rank = @findRank (.combo is combo)
         @comboRanks.push rank
      else if combo is \0
         @comboRanks = []
      didSel = no
      if sel
         data = sel.replace @regexes.startsPrefixes, ""
         data = @upperFirst data
         switch combo
         | \LMB
            @lineData.0 = " # #data"
            didSel = yes
         | \RMB
            @lineData.1 = " | #data"
            didSel = yes
         | \Shift+LMB
            @lineData.0 = " #"
            @lineData.1 = " | #data"
            didSel = yes
         if didSel
            if @cfg.lineDataSeparateNameAndImg
               @lineData.2 = ""
               @lineData.3 = ""
            @data = @lineData.join ""
            @copy @data
            @mark target
            @emptySel!
      unless didSel
         if target
            if target.closest \span#Tạo_mới
               return
            switch
            | combo is \Backquote+RMB
               @canContextMenu = yes
            | (target.localName is \img) or
               (t.inaturalist and target.matches "a.photo-container, a.photo") or
               (t.flickr and target.matches ".photo")
               unless t.imgurEdit
                  captions =
                     "RMB": " # %"
                     "A+RMB": " # % ; adult"
                     "B+RMB": " # % ; breeding"
                     "C+RMB": " # % ; reconstruction"
                     "D+RMB": " # % ; drawing"
                     "E+RMB": " # % ; exhibit"
                     "F+RMB": " # % ; fossil"
                     "G+RMB": " # % ; light morph"
                     "H+RMB": " # % ; holotype"
                     "J+RMB": " # % ; jaw"
                     "K+RMB": " # % ; skeleton"
                     "L+RMB": " # % ; illustration"
                     "M+RMB": " # % ; mandible"
                     "N+RMB": " # % ; non-breeding"
                     "P+RMB": " # % ; paratype"
                     "Q+RMB": " # %"
                     "R+RMB": " # % ; restoration"
                     "S+RMB": " # % ; specimen"
                     "T+RMB": " # % ; caterpillar"
                     "U+RMB": " # % ; skull"
                     "V+RMB": " # % ; larva"
                     "W+RMB": " | %"
                     "X+RMB": " # % ; dark morph"
                     "Alt+V+RMB": " ; % ; larva"
                     "Alt+T+RMB": " ; % ; caterpillar"
                     "Shift+RMB": " | %"
                     "Alt+RMB": " ; % ; "
                     "Shift+B+RMB": " | % ; breeding"
                     "Shift+N+RMB": " | % ; non-breeding"
                     "Alt+B+RMB": " ; % ; breeding"
                     "Alt+N+RMB": " ; % ; non-breeding"
                     "Shift+G+RMB": " | % ; light morph"
                     "Shift+X+RMB": " | % ; dark morph"
                     "Alt+G+RMB": " ; % ; light morph"
                     "Alt+X+RMB": " ; % ; dark morph"
                  if caption = captions[combo]
                     {src} = target
                     unless src
                        src = target.style.backgroundImage - /^url\("|"\)$/g
                     data = ""
                     if src.includes \//upload.wikimedia.org/
                        data = match src
                           | /\/\d+px-.+/
                              src
                                 .replace /\https:\/\/upload\.wikimedia\.org\/wikipedia\/(commons|en)\/thumb\/./ ""
                                 .replace /\/\d+px-.+$/ ""
                           | /-\d+px-.+/
                              src.replace /-\d+px-/ \-220px-
                           else
                              src.replace /https:\/\/upload\.wikimedia\.org\/wikipedia\/(commons|en)\/./ ""
                        if src.includes \/wikipedia/en/
                           data = \/ + data
                     else if matched = src is /\/\/(static\.inaturalist\.org|inaturalist-open-data\.s3\.amazonaws\.com)\//
                        isAmazonAws = matched.1 is \inaturalist-open-data.s3.amazonaws.com and \: or ""
                        [, name, ext] = /\/photos\/(\d+)\/[a-z]+\.([a-zA-Z]*)/.exec src
                        type = {jpg: "" jpeg: \e png: \p JPG: \J JPEG: \E PNG: \P "": \u}[ext]
                        data = ":#isAmazonAws#name#type"
                        if @inaturalistSearchImportedData
                           isWriteLocalData = no
                           {genusName, speciesList} = @inaturalistSearchImportedData
                           if target.classList.contains \inaturalistSearchFigureImg
                              {speciesName} = target.dataset
                              species = speciesList.find (.name is speciesName)
                              if species
                                 species.newImg = species.oldImg
                                 isWriteLocalData = yes
                              else
                                 @notify "Không có loài này trong danh sách"
                           else if el = target.closest ".taxon_list_taxon:has(.species > .sciname)"
                              vals = el.querySelector \.sciname .innerText .split ' '
                              if vals.length is 2
                                 if genusName is vals.0
                                    species = speciesList.find (.name is vals.1)
                                    if species
                                       species.newImg = data
                                       isWriteLocalData = yes
                                    else
                                       @notify "Không có loài này trong danh sách"
                                 else
                                    @notify "Không phải Chi đã nhập"
                           if isWriteLocalData
                              text = JSON.stringify @inaturalistSearchImportedData
                              chrome.storage.local.set do
                                 inaturalistSearchImportedData: text
                                 !~>
                                    @renderInaturalistSearchImportedData!
                     else if src.includes \//live.staticflickr.com/
                        name = /^(?:https:)?\/\/live\.staticflickr\.com\/(\d+\/\d+_[\da-f]+)_[a-z]\.jpg+/.exec src .1
                        data = "@#name"
                     else if src.includes \//www.biolib.cz/
                        name = /(\d+)\.jpg$/.exec src .1
                        data = "%#name"
                     else if src.includes \//bugguide.net/
                        name = /([A-Z\d]+)\.jpg$/.exec src .1
                        if src.includes \/raw/
                           name += \r
                        data = "~#name"
                     else if src is /fishbase\.[a-z]+\//
                        isUpload = src is /uploadphoto/i and \^ or ""
                        regex =
                           if src.includes \workimagethumb
                              /%2fuploadphoto%2fuploads%2f(.+)\.[a-z]+&w=\d+$/i
                           else /(?:tn_)?([^/]+)\.[a-z]+$/i
                        name = regex.exec src .1 .toLowerCase!
                        data = "^#isUpload#name"
                     else if src.includes \//cdn.download.ams.birds.cornell.edu/
                        if name = /\/asset\/(\d+)1(\/|$)/exec src ?.1
                           data = "+#name"
                        else
                           @notify "Không thể lấy dữ liệu hình ảnh"
                     else if matched = src is /reptarium\.cz\/content\/photo_(.+)\.jpg$/
                        name = matched.1
                        data = "$#name"
                     else if matched = src is /www\.fishwisepro\.com\/pics\/JPG\/(?:TN\/TN)?(\w+)\.jpg$/
                        name = matched.1
                        data = "<#name"
                     else if matched = src is /biogeodb\.stri\.si\.edu\/(\w+)\/resources\/img\/images\/species\/(\w+)\.jpg$/
                        node = matched.1
                        name = matched.2
                        data = ">#node/#name"
                     else if src.includes \//i.pinimg.com/
                        name = /^https:\/\/i\.pinimg\.com\/\w+\/(.+?)\.jpg$/exec src .1
                        data = "!#name"
                     else if src.includes \//i.imgur.com/
                        name = /^https:\/\/i\.imgur\.com\/([A-Za-z\d]{7})/exec src .1
                        data = "-#name"
                     data = caption.replace \% data
                     switch
                     | combo is \RMB
                        @lineData.2 = data
                     | combo is \Q+RMB
                        @lineData.2 = data
                        @lineData.3 = " | ?"
                     | combo is \W+RMB
                        @lineData.2 = " # ?"
                        @lineData.3 = data
                     | comboIncludes \Shift \Alt
                        @lineData.3 = data
                     else
                        @lineData.2 = data
                        @lineData.3 = ""
                     if @cfg.lineDataSeparateNameAndImg
                        @lineData.0 = ""
                        @lineData.1 = ""
                     @data = @lineData.join ""
                     @copy @data
                     @mark target
                  else
                     switch combo
                     | \I+RMB \I+MMB \Shift+I+RMB \Shift+I+MMB \T+RMB \T+Shift+RMB
                        unless t.wikiPage and target.closest '.thumbimage,.infobox.biota'
                           @canMiddleClick = no
                           image = target.src
                           isOpenNewTab = comboIncludes \MMB or (t.inaturalist and target.classList.contains \photo)
                           isFemale = comboIncludes \Shift
                           @mark target
                           if comboIncludes \I
                              await @uploadImgur do
                                 image: image
                                 type: \URL
                                 isOpenNewTab: isOpenNewTab
                                 isFemale: isFemale
                           else
                              await @modalImgGithub do
                                 image: image
                                 isFemale: isFemale
            | target.matches "a:not(.new)[href]" and combo is \RMB
               if combo is \RMB
                  window.open target.href
            | td = target.closest ".infobox.biota td:nth-child(2), .infobox.taxobox td:nth-child(2)"
               if combo in [\RMB \LMB]
                  rankName = td.previousElementSibling.innerText
                     .replace \: ""
                     .trim!
                  rank = @findRank \prefixes (.regex.test rankName)
                  if rank
                     @data = @extract td,
                        ranks: [rank]
                     @copy @data
                     @mark td
            | el = target.closest ".infobox.biota .binomial, .infobox.taxobox .binomial"
               if combo in [\RMB \LMB]
                  @data = @extract el,
                     ranks: [@ranks.species]
                  @copy @data
                  @mark el
            | el = target.closest "dl> dt:only-child"
               if combo in [\RMB \LMB]
                  @data = @extract el
                  @copy @data
                  @mark el
            | target is target.closest ".infobox.biota, .infobox.taxobox" ?.querySelector \th
               doCombo combo,, target.innerText
            | target.closest \.CategoryTreeItem
               wrapper = target.closest \#mw-subcategories
               switch combo
               | \Alt+RMB \Shift+Alt+RMB \Alt+LMB \Shift+Alt+LMB
                  links = wrapper.querySelectorAll \.CategoryTreeItem
                  @openLinksExtract links, combo in [\Shift+Alt+RMB \Shift+Alt+LMB]
            | t.wikispecies and target.localName is \p
               if combo in [\RMB \LMB]
                  text = target.innerText.trim!split /\n+/ .[* - 1]trim!
                  rank = @findRank \prefixes (.startsRegex.test text)
                  text = text
                     .replace /^.+?:\s*/ ""
                     .replace /\s+-\s+|\s*\u2013\s*/g \\n
                  @data = @extract text,
                     ranks: [rank]
                  @copy @data
                  @mark target
            | target.matches '#firstHeading, ._summTitle, h1, b'
               doCombo combo,, target.innerText
            | target.matches 'i'
               @data = @extract target
               @copy @data
               @mark target
            | @node and 0 < @nodeOffset < @node.length - 1
               text = @node.wholeText.trim!
               if ma = /\d{4}\)? - (.+)/exec text
                  text = ma.1
               else if ma = /\((.+?)\)/exec text
                  text = ma.1
               if text.includes \,
                  text = text
                     .split \,
                     .filter (s) ~>
                        s and not /[)]/test s
                     .0
                     .trim!
               text = text
                  .replace /[–—]/gu ""
                  .replace /^- | \($/ ""
                  .trim!
               text = @upperFirst text
               @data = " # #text"
               @copy @data
               @mark @node
            | target.localName in [\li \dd]
               ul = target.parentElement
               switch combo
               | \RMB \LMB
                  @data = @extract ul.children,
                     deep: yes
                  await @copy @data
                  @mark ul
                  if @cfg.copyExtractDeepAndOpenLinkExtract
                     @openLinksExtract ul.children
               | \Alt+RMB \Shift+Alt+RMB \Alt+LMB \Shift+Alt+LMB
                  @openLinksExtract ul.children, combo in [\Shift+Alt+RMB \Shift+Alt+LMB]
               | \Backspace+RMB \Backspace+LMB
                  subUls = ul.querySelectorAll \ul
                  for subUl in subUls
                     subUl.remove!
            | el = target.closest "
            .infobox.biota p, .infobox.biota td:only-child,
            .infobox.taxobox p, .infobox.taxobox td:only-child"
               if combo in [\RMB \LMB]
                  if tr = target.closest \tr ?.previousElementSibling
                     rankName = tr.innerText
                        .replace \Type ""
                        .trim!
                     rank = @findRank \prefixes (.regex.test rankName)
                  switch el.localName
                  | \p
                     text = el.innerText
                        .replace /\u2013.*/ ""
                        .replace /\(but see text\)/ ""
                  else
                     text = el.innerText
                        .trim!
                        .split \\n 1 .0
                        .trim!
                  @data = @extract text,
                     ranks: [rank]
                  @copy @data
                  @mark el
            | t.wiki and td = target.closest \td
               table = td.closest \table
               col = @tableCol td
               switch combo
               | \RMB \LMB
                  data = @extract col
                  await @copy data
                  @mark col
                  if @cfg.copyExtractDeepAndOpenLinkExtract
                     @openLinksExtract col
               | \Alt+RMB \Shift+Alt+RMB \Alt+LMB \Shift+Alt+LMB
                  @openLinksExtract col, combo in [\Shift+Alt+RMB \Shift+Alt+LMB]
         else
            switch combo
            | \C
               (@els.commons or @els.enLang)?click!
            | \D
               if t.inaturalist
                  document.querySelector \.next_page ?.click!
               else
                  (@els.enLang or @els.viLang)?click!
            | \D+V
               (@els.viLang or @els.enLang)?click!
            | \D+E
               (@els.esLang or @els.enLang)?click!
            | \D+F
               (@els.frLang or @els.enLang)?click!
            | \S
               if t.imgurEdit
                  document.getElementById \save .click!
               else
                  (@els.species or @els.enLang)?click!
            | \E
               try
                  @lineData = ["" "" "" ""]
                  navigator.clipboard.writeText ""
               catch
                  alert e.message
            | \R
               if @data.includes \*
                  @data -= /\*/g
               else
                  @data .= replace /(?!^)(?=\n|$)/g \*
               @copy @data
            | \V
               if t.inaturalist
                  if el = document.querySelector "[name=taxon_name]"
                     text = await navigator.clipboard.readText!
                     el.select!
                     el.value = text
            | \O \Shift+O \P \Shift+P
               lang = comboIncludes \P and \vi or \en
               text = await navigator.clipboard.readText!
               url = "https://#lang.wikipedia.org/wiki/#text"
               if comboIncludes \Shift
                  window.open url
               else
                  location.href = url
            | \F
               find \subspecies no no yes
            | \Shift+F
               find \subspecies no yes yes
            | \G \G+N \G+E \G+H \G+S \G+K \N \H \K
               switch
               | t.google
                  q = document.querySelector \#REsRA .value
               | t.fishbase
                  q = document.querySelector ".ptitle a" .textContent
               | t.ebird
                  q = document.querySelector \.Heading-sub--sci .textContent
               | t.inaturalist
                  q = document.querySelector \#q .value
               | t.seriouslyfish
                  q = /[^/]+$/exec location.pathname .0
                     .replace /^./ (.toUpperCase!)
                     .replace /-/g " "
               | t.flickr
                  q = document.querySelector \#search-field .value
               | t.wikiPage
                  switch
                  | t.wikicommons
                     q = document.querySelector \#firstHeading .innerText .replace \Category: ""
                  | t.wikispecies
                     q = document.querySelector \#firstHeading .innerText
                  else
                     el = document.querySelector \.binomial or document.querySelector \#firstHeading
                     q = el?innerText
               switch combo
               | \G
                  {keyGPlus} = @cfg
                  if keyGPlus
                     doCombo "G+#keyGPlus"
                  else
                     location.href = "https://google.com/search?tbm=isch&q=#q"
               | \G+N \N
                  location.href = "https://inaturalist.org/taxa/search?view=list&q=#q"
               | \G+E
                  data = await (await fetch "https://api.ebird.org/v2/ref/taxon/find?key=jfekjedvescr&q=#q")json!
                  item = data.find (.name.includes name) or data.0
                  if item
                     location.href = "https://ebird.org/species/#{item.code}"
                  else
                     if args.0
                        @notify "Không tìm thấy trên ebird.org"
                     else
                        doCombo \G+E,,, [yes]
               | \G+H \H
                  [genus, species] = q.split " "
                  location.href = "https://fishbase.us/photos/ThumbnailsSummary.php?Genus=#genus&Species=#species"
               | \G+S
                  q = q.toLowerCase!replace /\ /g \-
                  location.href = "https://www.seriouslyfish.com/species/#q"
               | \G+K \K
                  location.href = "https://www.flickr.com/search/?text=#q"
            | \I+U
               if blob = await @readCopiedImgBlob!
                  base64 = await @readAsBase64 blob
                  await @uploadImgur do
                     image: base64
                     type: \base64
            | \I+A
               @getImgurAlbum!
            | \I+T
               @getImgurToken!
            | \I+L
               {data} = await (await fetch "https://api.imgur.com/3/credits",
                  headers:
                     "Authorization": "Bearer #@token"
               )json!
               now = Math.floor Date.now! / 1000
               @modal "Giới hạn Imgur", 340, (modal) ~>
                  m \._row._wrap,
                     m \._col9._mb2 "Giới hạn người dùng"
                     m \._col3._mb2 data.UserLimit
                     m \._col9._mb2 "Giới hạn người dùng còn lại"
                     m \._col3._mb2 data.UserRemaining
                     m \._col9._mb2 "Thời gian reset giới hạn người dùng"
                     m \._col3._mb2 Math.floor((data.UserReset - now) / 60) + " phút"
                     m \._col9._mb2 "Giới hạn ứng dụng"
                     m \._col3._mb2 data.ClientLimit
                     m \._col9._mb2 "Giới hạn ứng dụng còn lại"
                     m \._col3._mb2 data.ClientRemaining
            | \W+P
               location.href = \https://en.wikipedia.org/wiki/Special:Preferences
            | \W+E
               location.href = document.querySelector '#ca-ve-edit a,#ca-edit a' .href
            | \W+H
               location.href = document.querySelector '#ca-history a' .href
            | \W+M
               location.href = document.querySelector '#ca-move a' .href
            | \W+L
               document.querySelector \#pt-login>a .click!
            | \W+D
               document.querySelector \.wbc-editpage .click!
            | \K+L
               location.href = \https://www.flickr.com/signin
            | \N+I
               if t.inaturalistSearch
                  if text = prompt "Nhập danh sách dữ liệu Chi và Loài:"
                     if text .= replace /^\r?\n+|\r?\n+$/g ""
                        lineRegex = /^(\t*)([^ ]+)(\*?)(?: # (.+))?$/
                        tailRegex = /^([-/:@%~^+$<>=?]|https?:\/\/)/
                        text = text.split /\r?\n/
                        [,, genusName, genusExtinct, genusTail] = lineRegex.exec text.0
                        lines = text.slice 1
                        text =
                           genusName: genusName
                           genusExtinct: genusExtinct
                           genusTail: genusTail
                           speciesList: []
                        species = void
                        for line in lines
                           [, tab, name, extinct, tail] = lineRegex.exec line
                           if tab.length is 38
                              textEn = void
                              img = void
                              if tail
                                 if tailRegex.test tail
                                    img = tail
                                 else
                                    [textEn, img] = tail.split " # "
                              species =
                                 name: name
                                 extinct: extinct
                                 textEn: textEn
                                 oldImg: img
                                 newImg: img
                              text.speciesList.push species
                           else
                              species.subsps ?= ""
                              species.subsps += "\n#line"
                        @inaturalistSearchImportedData = text
                        text = JSON.stringify text
                        chrome.storage.local.set do
                           inaturalistSearchImportedData: text
                           !~>
                              @renderInaturalistSearchImportedData!
                              @notify "Đã nhập danh sách dữ liệu Chi và Loài"
            | \N+O
               if t.inaturalistSearch
                  if data = @inaturalistSearchImportedData
                     text = "\n#{'\t'repeat 31}#{data.genusName}"
                     text += data.genusExtinct if data.genusExtinct
                     text += data.genusTail if data.genusTail
                     for {name, extinct, textEn, newImg, subsps} in data.speciesList
                        text += "\n#{'\t'repeat 38}#{name}"
                        text += extinct if extinct
                        text += " # #textEn" if textEn
                        text += " # #newImg" if newImg
                        text += subsps if subsps
                     await @copy text
                     @notify "Đã sao chép danh sách dữ liệu Chi và Loài"
            | \N+Delete
               if t.inaturalistSearch
                  if data = @inaturalistSearchImportedData
                     @inaturalistSearchImportedData = null
                     chrome.storage.local.remove do
                        \inaturalistSearchImportedData
                        !~>
                           @notify "Đã xóa danh sách dữ liệu Chi và Loài"
                           location.reload!
            | \N+L
               if t.inaturalistSearch
                  if data = @inaturalistSearchImportedData
                     console.log data
            | \A
               cfgs =
                  c: \copyExtractDeepAndOpenLinkExtract
                  g: \keyGPlus
                  s: \lineDataSeparateNameAndImg
               text = "Đặt cấu hình (key + val, val sẽ được convert sang số nếu có thể, vd: c1):"
               for k, val of cfgs
                  text += "\n#k): #val: #{@cfg[val]}"
               if text = prompt text
                  key = text.0
                  prop = cfgs[key]
                  if prop
                     if val = text.substring 1
                        val = +val if isFinite val
                     else
                        val = void
                     @setCfg prop, val, !~>
                        @notify "#{cfgs[key]}: #val"
                  else
                     @notify "Key '#key' không hợp lệ"
            | \Delete
               if t.imgurEdit
                  usp = new URLSearchParams location.search
                  id = usp.get \_taxonId
                  location.href = "https://imgur.com/#id?_taxonDelete=1"
            | \Escape
               if t.flickr
                  if el = document.querySelector \.entry-type.do-not-evict
                     el.click!
            | \Z
               history.back!
            | \X
               history.forward!
            | \W
               @closeTab!
      m.redraw!

   renderInaturalistSearchImportedData: !->
      if t.inaturalistSearch
         if @inaturalistSearchImportedData
            {genusName, speciesList} = @inaturalistSearchImportedData
            inaturalistRegex = /^(:?)(\d+)([epJEPu]?)$/
            inaturalistExts = "": \jpg e: \jpeg p: \png J: \JPG E: \JPEG P: \PNG u: ""
            listEl = document.querySelector \.taxa.list
            for itemEl in listEl.children
               vals = itemEl.querySelector \.sciname .innerText .split ' '
               if vals.length is 2
                  speciesName = vals.1
                  if species = speciesList.find (.name is speciesName)
                     figureEl = itemEl.querySelector \.inaturalistSearchFigure
                     src = species.newImg
                     if src
                        unless figureEl
                           figureEl = document.createElement \figure
                           figureEl.className = \inaturalistSearchFigure
                           figureEl.innerHTML = """
                              <img class="inaturalistSearchFigureImg" data-species-name="#{species.name}">
                              <figcaption></figcaption>
                           """
                           itemEl.appendChild figureEl
                        key = src.0
                        src .= substring 1
                        switch key
                        | \-
                           src = "https://i.imgur.com/#{src}m.png"
                        | \/
                           if src.0 is \/
                              type = \en
                              src .= substring 1
                           else
                              type = \commons
                           ext = src.split \. .at -1
                           src = "https://upload.wikimedia.org/wikipedia/#type/thumb/#{src.0}/#src/320px-#{src.0}.#ext"
                        | \:
                           [, host, src, ext] = inaturalistRegex.exec src
                           host = host and \inaturalist-open-data.s3.amazonaws.com or \static.inaturalist.org
                           ext = inaturalistExts[ext]
                           src = "https://#host/photos/#src/medium.#ext"
                        | \@
                           src = "https://live.staticflickr.com/#{src}_e.jpg"
                        figureEl.dataset.isNewImg = species.newImg isnt species.oldImg
                        imgEl = figureEl.querySelector 'img'
                        imgEl.src = src
                        figcaptionEl = figureEl.querySelector \figcaption
                        figcaptionEl.innerText = species.newImg
                     else
                        figureEl?remove!

   view: ->
      m.fragment do
         if @shownUI and t.wikiPage
            m \._sideLeft,
               m \._column._p4._h100._scroll._noscrollbar,
                  m \._col,
                     m \#_toc
                  m \._col0._mt3,
                     @comboRanks.map (rank) ~>
                        m \div,
                           style: @style do
                              marginLeft: rank.lv * 4
                           rank.tab + rank.name
         m \._sideCenter._col,
            m \._notifies,
               @notifies.map (notify) ~>
                  m \._notify m.trust notify.html
            m \._modals._row._center,
               @modals.map (modal, i) ~>
                  m \._modal._column,
                     key: modal
                     style: @style do
                        width: modal.width
                        marginTop: i * 32
                     onbeforeremove: (vnode) ~>
                        new Promise (resolve) !~>
                           vnode.dom.classList.add \_fadeOut95
                           setTimeout resolve, 1000
                     m \._row._middle._gap4._pl4._pr3._pt3,
                        m \._col._textTruncate._textBold,
                           modal.title
                        m \button._modalClose,
                           onclick: !~>
                              modal.close!
                           "\u2a09"
                     m \._col._scroll._px4._pt3._pb4,
                        modal.view modal
         if @shownUI and (t.wikiPage or t.imgurEdit)
            m \._sideRight,
               switch
               | t.wikiPage
                  m \._column._p4._h100._scroll._noscrollbar,
                     if @summ
                        if @summ is yes
                           m \._mt5._textCenter "Đang tải..."
                        else
                           m \._summ,
                              m \h3._summTitle @summ.title
                              m \._summBox._p3._border._round4,
                                 m \img._summImg._block src: @summ.thumbnail?source
                                 m \._summExtract._mt3._mb-0._textJustify m.trust @summ.extract_html
                     else
                        m \._mt5._textCenter._textRed "Không có tiếng Việt"
                     m \._row._center._top._mt3,
                        if @hasSubspecies
                           m \._col6._row._center._middle,
                              "Subspecies"
                        if el = @els.commons
                           m \a._col6._row._center._middle._textGreen,
                              href: el.href
                              "Commons"
               | t.imgurEdit
                  m \._p3,
                     m \p "Tỷ lệ h.tại: #@imgurEditRatio"
                     m \p "Tỷ lệ gốc: #@imgurEditRatioOrg"
                     m \p,
                        class: @imgurEditRatio < @imgurEditRatio1Img and \_textRed or \_textGreen
                        "Tỷ lệ 1 ảnh: #@imgurEditRatio1Img"
                     m \p,
                        class: @imgurEditRatio < @imgurEditRatio2Img and \_textRed or \_textGreen
                        "Tỷ lệ 2 ảnh: #@imgurEditRatio2Img"

appEl = document.createElement \div
appEl.id = \_app
document.body.appendChild appEl
m.mount appEl, App
