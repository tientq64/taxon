localStorage
	..taxonFindExact ?= ""
	..taxonFindCase ?= \1
	..taxonInfoLv ?= \0
	..taxonRightClickAction ?= \g
	..taxonPopupLang ?= \vi

lineH = 18
code = void
isKeyDown = yes
lines = []
chars = {}
isDev = location.hostname is \localhost
maxLv = 99
infoMaxLv = 2
infoLv = +localStorage.taxonInfoLv
infos =
	taxon:
		label: "Tổng số mục"
		lv: 1
	family:
		label: "Tổng số họ"
	genus:
		label: "Tổng số chi"
	speciesSubsp:
		label: "Tổng số phân loài hoặc loài"
		lv: 1
	speciesSubspExists:
		label: "Phân loài hoặc loài còn tồn tại"
	speciesSubspExtinct:
		label: "Phân loài hoặc loài tuyệt chủng"
	speciesSubspHasViName:
		label: "Phân loài và loài có tên tiếng Việt"
	speciesSubspHasImg:
		label: "Phân loài hoặc loài có hình ảnh"
		lv: 1
	img:
		label: "Tổng số hình ảnh"
		lv: 1
for , info of infos
	info.lv ?= infoMaxLv

parse = !->
	data = await (await fetch \tree.taxon)text!
	data .= split \\n
	tree = [0 \Organism no \/Sinh_vật [] "Sinh vật"]
	refs = [tree]
	headRegex = /^(\t*)(.+?)(\*)?(?: ([\\/].*))?$/
	tailRegex = /^([-/:@%~^+$<>?]|https?:\/\/)/
	inaturalistRegex = /^(:?)(\d+)([epJEPu]?)$/
	inaturalistExts = "": \jpg e: \jpeg p: \png J: \JPG E: \JPEG P: \PNG u: ""
	bugguideRegex = /^([A-Z\d]+)([r]?)$/
	bugguideTypes = "": \cache r: \raw
	lines := []
	chars := {}
	charsId = 0
	index = -1
	numFmt = new Intl.NumberFormat \en
	translates =
		headed: "đầu"
		tailed: "đuôi"
		bellied: "bụng"
		chested: "ngực"
		breasted: "ngực"
		backed: "lưng"
		faced: "mặt"
		nosed: "mũi"
		eared: "tai"
		cheeked: "má"
		chinned: "cằm"
		necked: "cổ"
		throated: "họng"
		footed: "chân"
		rumped: "phao câu"
		billed: "mỏ"
		crested: "mào"
		winged: "cánh"
		bearded: "râu"
		scaly: "vảy"
		sword: "kiếm"
		needle: "kim"
		crowned: "vương miện"
		masked: "mặt nạ"
		spectacled: "đeo kính"
		king: "vua"
		ghost: "ma"
		black: "đen"
		white: "trắng"
		gray: "xám"
		grey: "xám"
		red: "đỏ"
		orange: "da cam"
		yellow: "vàng"
		green: "lục"
		blue: "lam"
		purple: "tía"
		violet: "tím"
		pink: "hồng"
		brown: "nâu"
		silver: "bạc"
		olive: "ô liu"
		chestnut: "hạt dẻ"
		rainbow: "cầu vồng"
		fiery: "lửa"
		plain: "trơn"
		spot: "đốm"
		spotted: "đốm"
		speckled: "lốm đốm"
		stripe: "sọc"
		banded: "vằn"
		starred: "sao"
		wood: "gỗ"
		marbled: "cẩm thạch"
		velvet: "nhung"
		broad: "rộng"
		hook: "quăm"
		giant: "khổng lồ"
		large: "lớn"
		little: "nhỏ"
		lesser: "nhỏ"
		long: "dài"
		short: "ngắn"
		pygmy: "lùn"
		northern: "phương bắc"
		southern: "phương nam"
		common: "thông thường"
		domestic: "nhà"
		wild: "hoang"
		mountain: "núi"
		desert: "sa mạc"
		bay: "vịnh"
		cave: "hang"
		hyena: "linh cẩu"
		hummingbird: "chim ruồi"
		potoo: "chim potoo"
		flamingo: "hồng hạc"
		duck: "vịt"
		teal: "mòng két"
		shrimp: "tôm"
		crab: "cua"
		cricket: "dế"
		grasshopper: "châu chấu"
		mosquito: "muỗi"
		African: "châu Phi"
		Pacific: "Thái Bình Dương"
		Vietnam: "Việt Nam"
		Vietnamese: "Việt Nam"
		American: "Mỹ"
		Chinese: "Trung Quốc"
		Taiwan: "Đài Loan"
		Philippine: "Philippine"
		Australian: "Úc"
		Australasian: "Úc"
		Egyptian: "Ai Cập"
		Madagascan: "Madagascar"
		Mexican: "Mexico"
		Chilean: "Chile"
		Hainan: "Hải Nam"
		California: "California"
		Andean: "Andes"
		Baikal: "Baikal"
		Javan: "Java"
		Laysan: "Laysan"
		"James's": "James"
		"Hartlaub's": "Hartlaub"
	for , info of infos
		info.count = 0
	for line in data
		imgs = void
		textEn = void
		textVi = void
		[head, text, tail] = line.split " # "
		[, lv, name, ex, disam] = headRegex.exec head
		lv = lv.length + 1
		name = " " if name is \_
		ex = Boolean ex
		if text
			if tailRegex.test text
				tail = text
				text = void
			if text
				[textEn, textVi] = text.split /\ ?\| /
			# if textEn and not textVi and lv > 34
			# 	translateText = []
			# 	words = textEn.split /-| / .reverse!
			# 	if words.length > 1
			# 		for word in words
			# 			if translate = translates[word] or translates[word.toLowerCase!]
			# 				translateText.push translate
			# 			else
			# 				translateText = []
			# 				break
			# 		if translateText.length
			# 			textVi = translateText.join " "
			# 			textVi = "dịch: " + textVi.0.toUpperCase! + textVi.substring 1
			if tail
				imgs = tail
					.split " | "
					.map (imgg) ~>
						[src, captn] = imgg.split " ; "
						unless src is \?
							captn = void if captn is \.
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
								src = "https://upload.wikimedia.org/wikipedia/#type/thumb/#{src.0}/#src/320px-..webp"
							| \:
								[, host, src, ext] = inaturalistRegex.exec src
								host = host and \inaturalist-open-data.s3.amazonaws.com or \static.inaturalist.org
								ext = inaturalistExts[ext]
								src = "https://#host/photos/#src/medium.#ext"
							| \@
								src = "https://live.staticflickr.com/#{src}_n.jpg"
							| \%
								src = "https://www.biolib.cz/IMG/GAL/#src.jpg"
							| \~
								[, src, type] = bugguideRegex.exec src
								type = bugguideTypes[type]
								src = "https://bugguide.net/images/#type/#{src.substring 0 3}/#{src.substring 3 6}/#src.jpg"
							| \^
								if src.0 is \^
									path = \tools/uploadphoto/uploads
									src .= substring 1
								else
									path = \images/species
								src = "https://d1iraxgbwuhpbw.cloudfront.net/#path/#src.jpg"
							| \+
								src = "https://cdn.download.ams.birds.cornell.edu/api/v1/asset/#{src}1/320"
							| \$
								src = "https://www.reptarium.cz/content/photo_#src.jpg"
							| \<
								src = "https://www.fishwisepro.com/pics/JPG/#src.jpg"
							| \>
								[node, src] = src.split \/
								src = "https://biogeodb.stri.si.edu/#node/resources/img/images/species/#src.jpg"
							else
								src .= replace /^ttps?:/ ""
							{src, captn}
		node = [lv, name, ex, disam,, textEn, textVi, imgs]
		if refs.some (.0 >= lv)
			refs .= filter (.0 < lv)
		ref = refs[* - 1]
		ref[]4.push node
		refs.push node
	addNode = (node, parent, parentLv, parentName, extinct, chrs, first, last, nextSiblExtinct) !~>
		[lv, name, ex, disam, childs, textEn, textVi, imgs] = node
		if lv <= maxLv
			extinct = yes if ex
			if parentLv >= 0
				lvRange = lv - parentLv - 1
				if extinct
					chrs2 = (chrs + if first => "╸╸"repeat(lvRange) + \╸┓ else "  "repeat(lvRange) + " ╏")
						.replace /\ (?=[╸━┓])/ \╹
						.replace /┃(?=[━┓])/ \┣
				else
					chrs2 = (chrs + if first => "━━"repeat(lvRange) + \━┓ else "  "repeat(lvRange) + " ┃")
						.replace /\ (?=[╸━┓])/ \┗	
						.replace /[┃╏](?=[━┓])/ \┣
			else
				chrs2 = " ┃"
			if chars[chrs2]?
				chrs2 = chars[chrs2]
			else
				chrs2 = chars[chrs2] = charsId++
			if lv >= 35
				if lv is 37
					fullName = "#parentName var. #name"
				else
					fullName = "#parentName #name"
				infos.speciesSubspHasViName.count++ if textEn
				unless childs
					infos.speciesSubsp.count++
					infos.speciesSubspHasImg.count++ if imgs
					infos.speciesSubspExtinct.count++ if extinct
			else if lv is 30
				infos.genus.count++
			else if lv is 25
				infos.family.count++
			line =
				index: ++index
				lv: lv
				name: name
				chrs: chrs2
			line.textEn = textEn if textEn
			line.textVi = textVi if textVi
			if maxLv < 35 and childs and childs.0.0 > maxLv
				line.textVi = childs.length
			if imgs
				line.imgs = imgs
				infos.img.count += imgs.length
			line.extinct = extinct if extinct
			line.disam = disam if disam
			line.fullName = fullName if fullName
			line.parent = parent if parent
			lines.push line
			if childs
				line.childs = []
				chrs += "  "repeat(lvRange) + (last and "  " or (if extinct or nextSiblExtinct => " ╏" else " ┃"))
				if lv < 32 or lv > 34
					if name not in [\? " "]
						if lv is 31
							parentName = "#parentName (#name)"
						else
							parentName = fullName or name
					else if lv is 30
						parentName = \" + parentName + \"
				lastIndex = childs.length - 1
				for child, i in childs
					addNode child, line, lv, parentName, extinct, chrs, not i, i is lastIndex, childs[i + 1]?2
	addNode tree,, -1, "" no "" yes yes
	chars := Object.keys chars
	infos.taxon.count = lines.length
	infos.speciesSubspExists.count = infos.speciesSubsp.count - infos.speciesSubspExtinct.count
	for , info of infos
		info.count = numFmt.format info.count

await parse!

App =
	oninit: !->
		for k, prop of @
			@[k] = prop.bind @ if typeof prop is \function
		@lines = []
		@start = void
		@len = 0
		@finding = no
		@findVal = ""
		@findLines = []
		@findIndex = 0
		@findExact = !!localStorage.taxonFindExact
		@findCase = !!localStorage.taxonFindCase
		@popper = null
		@summaryEl = null
		@abortCtrler = void
		@chrsRanks =
			[\life 0 1]
			[\domain 1 2]
			[\kingdom 2 5]
			[\phylum 5 10]
			[\class 10 16]
			[\order 16 24]
			[\family 24 27]
			[\tribe 27 30]
			[\genus 30 34]
			[\species 34 36]
			[\subspecies 36 39]
		@rightClickAction = localStorage.taxonRightClickAction
		@popupLang = localStorage.taxonPopupLang

	oncreate: !->
		heightEl.style.height = lines.length * lineH + \px
		addEventListener \keydown @onkeydown
		addEventListener \keyup @onkeyup
		addEventListener \mousedown @onmousedown
		addEventListener \blur @onblur
		scrollEl.scrollTop = +localStorage.taxonTop or 0
		scrollEl.style.scrollBehavior = \smooth
		addEventListener \resize @onresize
		@onresize!

	class: (...items) ->
		res = []
		for item in items
			if Array.isArray item
				res.push @class.apply ...item
			else if item instanceof Object
				for k, val of item
					res.push k if val
			else if item?
				res.push item
		res.join " "

	getRankName: (lv) ->
		@chrsRanks.find (.2 > lv) .0

	find: (val = @findVal) !->
		@findVal? = val
		unless @finding
			@finding = yes
			m.redraw.sync!
		findInputEl.focus!
		if val.trim!
			unless @findCase
				val .= toLowerCase!
			@findLines = lines.filter (line) ~>
				{name, textVi = ""} = line
				if Number.isFinite textVi
					textVi = ""
				unless @findCase
					name .= toLowerCase!
					textVi .= toLowerCase!
				if @findExact
					name is val or textVi is val
				else
					name.includes val or textVi.includes val
			if @findIndex >= @findLines.length
				@findIndex = @findLines.length - 1
		else
			@findLines = []
		if @findLines.length
			@findGo!
		m.redraw!

	findGo: (num = 0) !->
		if @findLines.length
			@findIndex = (@findIndex + num) %% @findLines.length
			scrollEl.scrollTop = (@findLines[@findIndex]index - 4) * lineH
			@onscroll!

	toggleFindExact: !->
		not= @findExact
		localStorage.taxonFindExact = @findExact and \1 or ""
		@find!

	toggleFindCase: !->
		not= @findCase
		localStorage.taxonFindCase = @findCase and \1 or ""
		@find!

	closeFind: !->
		if @finding
			@finding = no
			@findLines = []
			m.redraw!

	mousedownImg: (img, event) !->
		{target} = event
		{src} = img
		switch event.which
		| 1
			switch
			| src.includes \upload.wikimedia.org
				width = 10 * Math.round target.naturalWidth / target.naturalHeight * 80
				src .= replace /\/320px-/ "/#{width}px-"
			| src.includes \static.inaturalist.org
				src .= replace \/medium. \/large.
			| src.includes \inaturalist-open-data.s3.amazonaws.com
				src .= replace \/medium. \/large.
			| src.includes \live.staticflickr.com
				src .= replace \_n. \_b.
			# | src.includes \biolib.cz
			# 	src .= replace \/GAL/ \/GAL/BIG/
			| src.includes \cdn.download.ams.birds.cornell.edu
				src .= replace /\d+$/ \1800
			| src.includes \i.imgur.com
				if code is \Delete
					src -= /(?<=:\/\/)i\.|m\.\w+$/g
					src += \?_taxonDelete=1
				else
					src .= replace /m(?=\.\w+$)/ \r
			window.open src, \_blank

	mousedownName: (line, event) !->
		unless line.name in ["" \?]
			switch event.which
			| 1
				if isDev
					lang = event.altKey and \vi or \en
					q = @getWikiPageName line
					window.open "https://#lang.wikipedia.org/wiki/#q" \_blank
				else
					q = @getWikiPageName line
					window.open "https://vi.wikipedia.org/wiki/#q" \_blank
			| 2
				event.preventDefault!
				if isDev
					try
						navigator.clipboard.writeText line.name
					catch
						alert e.message
				else
					name = @getFullNameNoSubgenus line
					try
						navigator.clipboard.writeText name
					catch
						alert e.message

	contextmenuName: (line, event) !->
		event.preventDefault!
		if isDev
			unless line.name in ["" \?]
				name = @getFullNameNoSubgenus line
				action =
					| event.altKey => \g
					| code is \KeyB => \b
					| code is \KeyL => \l
					| code is \KeyH => \h
					| code is \KeyE => \e
					| code is \KeyS => \s
					| code is \KeyN => \n
					| code is \KeyK => \k
					else @rightClickAction
				text = name.split " " .0
				try
					navigator.clipboard.writeText text
				catch
					alert e.message
				switch action
				| \g
					window.open "https://google.com/search?tbm=isch&q=#name" \_blank
				| \b
					window.open "https://bugguide.net/index.php?q=search&keys=#name"
				| \l
					window.open "https://www.biolib.cz/en/formsearch/?string=#name&searchgallery=1&action=execute"
				| \h
					[genus, species] = name.split " "
					if species
						window.open "https://fishbase.us/photos/ThumbnailsSummary.php?Genus=#genus&Species=#species" \_blank
					else
						window.open "http://fishbase.us/Nomenclature/ValidNameList.php?syng=#genus&crit2=CONTAINS&crit1=EQUAL"
				| \e
					handle = (name) ~>
						data = await (await fetch "https://api.ebird.org/v2/ref/taxon/find?key=jfekjedvescr&q=#name")json!
						item = data.find (.name.includes name) or data.0
						if item
							window.open "https://ebird.org/species/#{item.code}"
							yes
					unless await handle name
						if line.textEn
							await handle line.textEn
				| \s
					name = name.toLowerCase!replace /\ /g \-
					window.open "https://www.seriouslyfish.com/species/#name"
				| \k
					window.open "https://www.flickr.com/search/?tags=#name"
				else
					window.open "https://inaturalist.org/taxa/search?view=list&q=#name"
		else
			q = @getWikiPageName line
			window.open "https://en.wikipedia.org/wiki/#q" \_blank

	mouseleaveName: !->
		if @popper
			if @abortCtrler
				@abortCtrler.abort!
				@abortCtrler = void
			@popper.destroy!
			@popper = null
			@summaryEl = null
			m.mount popupEl

	mouseenterName: (line, event) !->
		unless line.name in [\? " "]
			summary = void
			{imgs} = line
			width = 320
			isTwoImage = imgs and imgs.0 and imgs.1
			name = @getFullNameNoSubgenus line
			popup =
				oncreate: (vnode) !~>
					@summaryEl = vnode.dom.querySelector \#popupSummary
				view: ~>
					m \#popupBody,
						class: @class do
							"popupIsTrinomial": line.lv > 35
						style:
							minWidth: width + \px
						m \#popupName name
						if line.textEn
							m \#popupText line.textEn
						if line.textVi and isNaN line.textVi
							m \#popupText line.textVi
						if imgs
							m \#popupGenders,
								class: @class do
									"popupGendersTwoImg": isTwoImage
									"popupGendersNoCap": not isTwoImage
								imgs.map (img, i) ~>
									if img
										m \.popupGender,
											m \.popupPicture,
												m \img.popupBgImg,
													src: img.src
												m \img.popupImg,
													src: img.src
													onload: (event) !~>
														unless isTwoImage
															{target} = event
															ratio = target.width / target.height
															if 1.233 < ratio < 1.333
																target.classList.add \popupImg--cover
														if @popper
															updateHeight!
											if imgs.length is 2 or imgs.some (?captn)
												m \.popupGenderCaptn,
													if imgs.length is 2
														i and \Cái or \Đực
													if img.captn
														" (#{img.captn})"
						m \#popupSummary
			m.mount popupEl, popup
			@popper = Popper.createPopper event.target, popupEl,
				placement: \left
				modifiers:
					* name: \offset
						options:
							offset: [0 18]
					* name: \preventOverflow
						options:
							padding: 2
			{summary} = await @fetchWiki line
			updateHeight = !~>
				if popupEl.offsetHeight > innerHeight - 4
					summary := summary.split " " .slice 0 -1 .join " " .concat \...
					@summaryEl.innerHTML = summary
					updateHeight!
				else
					@popper.update!
			if @summaryEl
				if summary
					summary = summary
						.replace /<br \/>/g ""
						.replace /(?<!\.)\.\.(?!\.)/g \.
				@summaryEl.innerHTML = summary
				updateHeight!

	getFullNameNoSubgenus: (line) ->
		(line.fullName or line.name)replace /\ \(.+?\)/ ""

	getWikiPageName: (line) ->
		{disam} = line
		if disam
			chr = disam.0
			disam .= substring 1
		name = @getFullNameNoSubgenus line
		name .= replace /\ /g \_
		switch chr
		| \/ => disam or \_
		| \\ => "#{name}_(#disam)"
		else name

	fetchWiki: (line, cb) !->
		try
			q = @getWikiPageName line
			lang = cb and \en or @popupLang
			opts = {}
			unless cb
				@abortCtrler = new AbortController
				opts.signal = @abortCtrler.signal
			data = await (await fetch "https://#lang.wikipedia.org/api/rest_v1/page/summary/#q" opts)json!
			{extract_html} = data
			if data.type is \standard
				title = data.title.replace /\ \(.+?\)/ ""
				name1 = line.fullName or line.name
				names = [name1]
				name2 = @getFullNameNoSubgenus line
				names.push name2 unless name2 is name1
				node = line
				while node .= parent
					names.push @getFullNameNoSubgenus node
				matches = [title]
				if rs = extract_html.match /<(b)>.+?<\/\1>/g
					matches.push ...rs
				for title in matches
					if r = /<(\w+)[^>]*>(.+?)<\/\1>/exec title
						title = r.2
					title = title
						.replace /,/g ""
						.trim!
					if title and not names.includes title and not title.includes ". "
						title = title.0.toUpperCase! + title.substring 1
						titles ?= []
						unless titles.includes title
							titles.push title
			if data.type is \standard and extract_html
				summary = /<p>(.+?)<\/p>/su.exec extract_html .0 .replace /\n+/g " "
			else throw
		catch
			summary = "<i>Không có dữ liệu<i>"
		res = {summary, titles}
		if cb => cb line, res else return res

	onscroll: (evt) !->
		evt.redraw = no if evt
		top = scrollEl.scrollTop
		mod = top % lineH
		transY = top - mod
		presEl.style.transform = "translateY(#{transY}px)"
		localStorage.taxonTop = top
		start = Math.floor top / lineH
		unless start is @start and @lines.length is @len
			@start = start
			@lines = lines.slice start, start + @len
			if isDev
				for line in @lines
					if line.lv > 34 and line.textEn is void
						line.textEn = "..."
						@fetchWiki line, (line, {titles}) !~>
							line.textEn = titles or no
							m.redraw!
			evt.redraw = yes if evt
		@mouseleaveName!

	onkeydown: (event) !->
		unless event.repeat
			unless event.location in [1 2]
				noFocus = document.activeElement is document.body
				isKeyDown := yes
				code := event.code
				if noFocus
					switch code
					| \KeyF
						if event.ctrlKey
							event.preventDefault!

	onkeyup: (event) !->
		if isKeyDown
			{ctrlKey: ctrl, shiftKey: shift, altKey: alt} = event
			noFocus = document.activeElement is document.body
			switch code
			| \KeyF
				if noFocus
					@find!
			| \KeyX
				if @finding
					if alt
						@toggleFindExact!
			| \KeyC
				if @finding
					if alt
						@toggleFindCase!
			| \KeyI
				if noFocus
					val = event.shiftKey and 2 or 1
					infoLv := if infoLv and infoLv is val => 0 else val
					localStorage.taxonInfoLv = infoLv
					m.redraw!
			| \KeyA
				if isDev
					unless ctrl
						if noFocus
							action = prompt """
								Nhập hành động khi bấm chuột phải:
								g) google
								b) bugguide
								l) biolib
								h) fishbase
								e) ebird
								s) seriouslyfish
								k) flickr
								n) inaturalist (mặc định)
							""" @rightClickAction
							if action
								@rightClickAction = action
								localStorage.taxonRightClickAction = action
			| \KeyR
				if isDev
					unless ctrl
						if noFocus
							lv = +prompt """
								Rank tối đa được hiển thị:
								1) vực                  2) giới               3) phân giới         4) thứ giới
								5) liên ngành       6) ngành          7) phân ngành     8) thứ ngành
								9) tiểu ngành      10) liên lớp       11) lớp                 12) phân lớp
								13) thứ lớp          14) tiểu lớp      15) đoàn              16) liên đội
								17) đội                18) tổng bộ      19) liên bộ            20) bộ
								21) phân bộ         22) thứ bộ       23) tiểu bộ           24) liên họ
								25) họ                  26) phân họ     27) liên tông        28) tông
								29) phân tông     30) chi              31) phân chi         32) mục
								33) loạt                34) liên loài      35) loài                 36) phân loài
								37) thứ                 38) dạng
							"""
							if lv
								maxLv := lv
								@lines = []
								{scrollTop} = scrollEl
								await parse!
								heightEl.style.height = lines.length * lineH + \px
								@onscroll!
								m.redraw.sync!
								scrollEl.style.scrollBehavior = ""
								scrollEl.scrollTop = 0
								scrollEl.style.scrollBehavior = \smooth
								scrollEl.scrollTop = scrollTop
			| \KeyV
				unless ctrl
					@popupLang = @popupLang is \vi and \en or \vi
					localStorage.taxonPopupLang = @popupLang
			| \KeyE
				if isDev
					try
						await navigator.clipboard.writeText ""
					catch
						alert e.message
			| \Escape
				if @finding
					@closeFind!
			code := void
			isKeyDown := no
			m.redraw!

	onmousedown: (event) !->
		isKeyDown := no

	onblur: (event) !->
		code := void
		isKeyDown := no

	onresize: !->
		@len = Math.ceil(innerHeight / lineH) + 1
		@onscroll!
		m.redraw!

	view: ->
		m \div,
			m \#scrollEl,
				onscroll: @onscroll
				m \#presEl,
					@lines.map (line) ~>
						m \.line,
							key: line.index
							class: @class do
								"lineFind": @finding and line is @findLines[@findIndex]
							@chrsRanks.map (rank) ~>
								if line.lv >= rank.1
									m \span,
										class: rank.0
										chars[line.chrs]substring rank.1 * 2 rank.2 * 2
							m \.node,
								m \span,
									class: @getRankName line.lv
									onmouseenter: !~>
										@mouseenterName line, it
									onmouseleave: @mouseleaveName
									onmousedown: !~>
										@mousedownName line, it
									oncontextmenu: !~>
										@contextmenuName line, it
									line.name
								if line.textEn and line.textEn isnt \... or line.textVi
									m \span.dash \\u2014
								if line.textEn
									if Array.isArray line.textEn
										m \.textEn,
											line.textEn.map (text) ~>
												m \.textEnCopy,
													onclick: !~>
														line.textEn = text
														row = line.index
														try
															copyText = await navigator.clipboard.readText!
															copyText and+= \\n
															copyText += "#row||"
															copyText += switch
																| line.textVi => " #text"
																| line.imgs => " #text #"
																else " # #text"
															await navigator.clipboard.writeText copyText
														catch
															alert e.message
													text
									else
										m \span.textEn line.textEn
								if line.textVi
									m \span.textVi "(#{line.textVi})"
								line.imgs?map (img) ~>
									if img
										m \img.img,
											src: img.src
											onmousedown: !~>
												@mousedownImg img, it
				m \#heightEl
			if infoLv
				m \#infosEl,
					for , info of infos
						if infoLv >= info.lv
							m.fragment do
								m \.info info.label
								m \.info info.count
					m \.info "Ngôn ngữ popup"
					m \.info @popupLang
			if @finding
				m \#findEl,
					m \input#findInputEl,
						placeholder: "Tìm kiếm"
						autocomplete: \off
						value: @findVal
						oninput: !~>
							@find it.target.value
						onkeydown: !~>
							if it.key is \Enter
								@findGo it.shiftKey && -1 || 1
					m \#findTextEl,
						(@findLines.length and @findIndex + 1 or 0) + \/ + @findLines.length
					m \.findButton,
						class: \findButtonOn if @findExact
						title: "Tìm chính xác"
						onclick: @toggleFindExact
						'""'
					m \.findButton,
						class: \findButtonOn if @findCase
						title: "Phân biệt hoa-thường"
						onclick: @toggleFindCase
						"Tt"
					m \.findButton#findClose,
						title: "Đóng"
						onclick: @closeFind
						"\u2a09"
			m \#popupEl

m.mount appEl, App
