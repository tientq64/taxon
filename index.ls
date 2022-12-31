localStorage
	..taxonFindExact ?= ""
	..taxonFindCase ?= \1
	..taxonInfoLv ?= \0
	..taxonRightClickAction ?= \g
	..taxonPopupLang ?= \vi
	..taxonTheme ?= \default

document.documentElement.classList.add localStorage.taxonTheme
cstyle = getComputedStyle document.documentElement
lineH = parseInt cstyle.getPropertyValue \--lineH
lines = []
chars = {}
chrsRanks =
	[\life 0 1]
	[\domain 1 2]
	[\kingdom 2 5]
	[\phylum 5 10]
	[\class 10 16]
	[\order 16 24]
	[\family 24 29]
	[\tribe 29 32]
	[\genus 32 38]
	[\species 38 40]
	[\subspecies 40 43]
isDev = location.hostname is \localhost
numFmt = new Intl.NumberFormat \en
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
	species:
		label: "Tổng số loài"
		lv: 1
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
	tree = [0 \Life no [, \/Sự_sống] [] "Life" "Sự sống"]
	refs = [tree]
	headRegex = /^(\t*)(.+?)(\*)?(?: ([\\/].*?))?(?: \|([-a-z]+?))?$/
	tailRegex = /^([-/:@%~^+$<>=?]|https?:\/\/)/
	disamSplitRegex = /(?=[\\/])/
	inaturalistRegex = /^(:?)(\d+)([epJEPu]?)$/
	inaturalistExts = "": \jpg e: \jpeg p: \png J: \JPG E: \JPEG P: \PNG u: ""
	bugguideRegex = /^([A-Z\d]+)([r]?)$/
	bugguideTypes = "": \cache r: \raw
	lines := []
	chars := {}
	charsId = 0
	index = -1
	# translates =
	# 	headed: "đầu"
	# 	tailed: "đuôi"
	# 	bellied: "bụng"
	# 	chested: "ngực"
	# 	breasted: "ngực"
	# 	backed: "lưng"
	# 	faced: "mặt"
	# 	nosed: "mũi"
	# 	eared: "tai"
	# 	cheeked: "má"
	# 	chinned: "cằm"
	# 	necked: "cổ"
	# 	throated: "họng"
	# 	footed: "chân"
	# 	rumped: "phao câu"
	# 	billed: "mỏ"
	# 	crested: "mào"
	# 	winged: "cánh"
	# 	bearded: "râu"
	# 	scaly: "vảy"
	# 	sword: "kiếm"
	# 	needle: "kim"
	# 	crowned: "vương miện"
	# 	masked: "mặt nạ"
	# 	spectacled: "đeo kính"
	# 	king: "vua"
	# 	ghost: "ma"
	# 	black: "đen"
	# 	white: "trắng"
	# 	gray: "xám"
	# 	grey: "xám"
	# 	red: "đỏ"
	# 	orange: "da cam"
	# 	yellow: "vàng"
	# 	green: "lục"
	# 	blue: "lam"
	# 	purple: "tía"
	# 	violet: "tím"
	# 	pink: "hồng"
	# 	brown: "nâu"
	# 	silver: "bạc"
	# 	olive: "ô liu"
	# 	chestnut: "hạt dẻ"
	# 	rainbow: "cầu vồng"
	# 	fiery: "lửa"
	# 	plain: "trơn"
	# 	spot: "đốm"
	# 	spotted: "đốm"
	# 	speckled: "lốm đốm"
	# 	stripe: "sọc"
	# 	banded: "vằn"
	# 	starred: "sao"
	# 	wood: "gỗ"
	# 	marbled: "cẩm thạch"
	# 	velvet: "nhung"
	# 	broad: "rộng"
	# 	hook: "quăm"
	# 	giant: "khổng lồ"
	# 	large: "lớn"
	# 	little: "nhỏ"
	# 	lesser: "nhỏ"
	# 	long: "dài"
	# 	short: "ngắn"
	# 	pygmy: "lùn"
	# 	northern: "phương bắc"
	# 	southern: "phương nam"
	# 	common: "thông thường"
	# 	domestic: "nhà"
	# 	wild: "hoang"
	# 	mountain: "núi"
	# 	desert: "sa mạc"
	# 	bay: "vịnh"
	# 	cave: "hang"
	# 	hyena: "linh cẩu"
	# 	hummingbird: "chim ruồi"
	# 	potoo: "chim potoo"
	# 	flamingo: "hồng hạc"
	# 	duck: "vịt"
	# 	teal: "mòng két"
	# 	shrimp: "tôm"
	# 	crab: "cua"
	# 	cricket: "dế"
	# 	grasshopper: "châu chấu"
	# 	mosquito: "muỗi"
	# 	African: "châu Phi"
	# 	Pacific: "Thái Bình Dương"
	# 	Vietnam: "Việt Nam"
	# 	Vietnamese: "Việt Nam"
	# 	American: "Mỹ"
	# 	Chinese: "Trung Quốc"
	# 	Taiwan: "Đài Loan"
	# 	Philippine: "Philippine"
	# 	Australian: "Úc"
	# 	Australasian: "Úc"
	# 	Egyptian: "Ai Cập"
	# 	Madagascan: "Madagascar"
	# 	Mexican: "Mexico"
	# 	Chilean: "Chile"
	# 	Hainan: "Hải Nam"
	# 	California: "California"
	# 	Andean: "Andes"
	# 	Baikal: "Baikal"
	# 	Javan: "Java"
	# 	Laysan: "Laysan"
	# 	"James's": "James"
	# 	"Hartlaub's": "Hartlaub"
	for , info of infos
		info.count = 0
	for line in data
		imgs = void
		textEn = void
		textVi = void
		[head, text, tail] = line.split " # "
		[, lv, name, ex, disam, icon] = headRegex.exec head
		lv = lv.length + 1
		name = " " if name is \_
		if disam
			disam = disam.split disamSplitRegex .map (val) ~>
				if val is \\ => void else val
		if text
			if tailRegex.test text
				tail = text
				text = void
			if text
				[textEn, textVi] = text.split /\ ?\| /
			# if textEn and not textVi and lv > 38
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
								src = "https://live.staticflickr.com/#{src}_e.jpg"
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
							| \=
								src = "https://cdn.jsdelivr.net/gh/tiencoffee/taimg/#src.webp"
							else
								src .= replace /^ttps?:/ ""
							[src, captn]
		node = [lv, name]
		node.2 = yes if ex
		node.3 = disam if disam
		node.5 = textEn if textEn
		node.6 = textVi if textVi
		node.7 = imgs if imgs
		node.8 = icon if icon
		if refs.some (.0 >= lv)
			refs .= filter (.0 < lv)
		ref = refs[* - 1]
		ref[]4.push node
		refs.push node
	addNode = (node, parent, parentLv, parentName, extinct, chrs, first, last, nextSiblExtinct) !~>
		[lv, name, ex, disam, childs, textEn, textVi, imgs, icon] = node
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
			if lv >= 39
				if lv is 41
					fullName = "#parentName var. #name"
				else
					fullName = "#parentName #name"
				if lv is 39
					infos.species.count++
				infos.speciesSubspHasViName.count++ if textEn
				unless childs
					infos.speciesSubsp.count++
					infos.speciesSubspHasImg.count++ if imgs
					infos.speciesSubspExtinct.count++ if extinct
			else if lv is 32
				infos.genus.count++
			else if lv is 27
				infos.family.count++
			line =
				index: ++index
				lv: lv
				name: name
				chrs: chrs2
			line.textEn = textEn if textEn
			line.textVi = textVi if textVi
			if maxLv < 39 and childs and childs.0.0 > maxLv
				line.textVi = childs.length
			if imgs
				line.imgs = imgs
				infos.img.count += imgs.length
			line.extinct = extinct if extinct
			line.disam = disam if disam
			line.fullName = fullName if fullName
			line.icon = icon if icon
			line.parent = parent if parent
			lines.push line
			if childs
				line.childs = childs.length
				chrs += "  "repeat(lvRange) + (last and "  " or (if extinct or nextSiblExtinct => " ╏" else " ┃"))
				if lv < 34 or lv > 38
					if name not in [\? " "]
						if lv is 33
							parentName = "#parentName (#name)"
						else
							parentName = fullName or name
					else if lv is 32
						parentName = \" + parentName + \"
				lastIndex = childs.length - 1
				for child, i in childs
					addNode child, line, lv, parentName, extinct, chrs, not i, i is lastIndex, childs[i + 1]?2
	addNode tree,, -1, "" no "" yes yes
	chars := Object.keys chars
	for char, i in chars
		chrs = []
		len = char.length / 2
		for chrsRank in chrsRanks
			if len > chrsRank.1
				chr = char
					.substring chrsRank.1 * 2 chrsRank.2 * 2
					.replace /\  /g \\t
					.replace /\ /g \\t
				chrs.push chr
			else break
		chars[i] = chrs
	infos.taxon.count = lines.length
	infos.speciesSubspExists.count = infos.speciesSubsp.count - infos.speciesSubspExtinct.count

await parse!

modfTime = new Date!setHours 0 0 0 0
try
	modfCounts = JSON.parse localStorage.taxonModfCounts
catch
	modfCounts = {}
	for k, info of infos
		modfCounts[k] = info.count
for k, info of infos
	info.modfCount = info.count - modfCounts[k]
if modfTime isnt +localStorage.taxonModfTime
	localStorage.taxonModfTime = modfTime
	localStorage.taxonModfCounts = JSON.stringify modfCounts

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
		@findTimo = void
		@code = void
		@isKeyDown = yes
		@popper = void
		@abortCtrler = void
		@rightClickAction = localStorage.taxonRightClickAction
		@popupLang = localStorage.taxonPopupLang

	oncreate: !->
		heightEl.style.height = lines.length * lineH + \px
		addEventListener \keydown @onkeydown
		addEventListener \keyup @onkeyup
		addEventListener \mousedown @onmousedown
		addEventListener \blur @onblur
		addEventListener \resize @onresize
		scrollEl.scrollTop = +localStorage.taxonTop or 0
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
		chrsRanks.find (.2 > lv) .0

	find: (val) !->
		if val?
			@findVal = val
		else
			val = @findVal
		unless @finding
			@finding = yes
			m.redraw.sync!
			findInputEl.select!
		findInputEl.focus!
		if @findTimo
			clearTimeout @findTimo
		@findTimo = setTimeout !~>
			@findTimo = void
			val .= trim!
			if val.length > 1
				unless @findCase
					val .= toLowerCase!
				@findLines = lines.filter (line) ~>
					{textVi = ""} = line
					fullName = @getFullNameNoSubgenus line
					if Number.isFinite textVi
						textVi = ""
					unless @findCase
						fullName .= toLowerCase!
						textVi .= toLowerCase!
					if @findExact
						val is fullName or val is textVi
					else
						fullName.includes val or textVi.includes val
				if @findIndex >= @findLines.length
					@findIndex = @findLines.length - 1
			else
				@findLines = []
			if @findLines.length
				@findGo!
			m.redraw!
		, 100
		m.redraw!

	findGo: (num = 0) !->
		if @findLines.length
			@findIndex = (@findIndex + num) %% @findLines.length
			scrollEl.scrollTop = (@findLines[@findIndex]index - 4) * lineH
			@scroll!

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
			@fetchTextEnCopyLines!
			m.redraw!

	mousedownImg: (img, event) !->
		{target} = event
		[src] = img
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
				src .= replace \_e. \_b.
			# | src.includes \biolib.cz
			# 	src .= replace \/GAL/ \/GAL/BIG/
			| src.includes \cdn.download.ams.birds.cornell.edu
				src .= replace /\d+$/ \1800
			| src.includes \i.imgur.com
				if @code is \Delete
					src -= /(?<=:\/\/)i\.|m\.\w+$/g
					src += \?_taxonDelete=1
				else
					src .= replace /m(?=\.\w+$)/ \r
			| src.includes \cdn.jsdelivr.net/gh/tiencoffee/taimg
				name = src.split \/ .[* - 1]
				act = @code is \Delete and \delete or \blob
				src = "https://github.com/tiencoffee/taimg/#act/main/#name"
			window.open src, \_blank

	mousedownName: (line, event) !->
		unless line.name in ["" \?]
			switch event.which
			| 1
				if isDev
					lang = event.altKey and \vi or \en
					q = @getWikiPageName line, lang
					window.open "https://#lang.wikipedia.org/wiki/#q" \_blank
				else
					q = @getWikiPageName line, \vi
					window.open "https://vi.wikipedia.org/wiki/#q" \_blank
			| 2
				event.preventDefault!
				if event.altKey
					text = line.name
				else
					text = @getFullNameNoSubgenus line
				try
					navigator.clipboard.writeText text
				catch
					alert e.message

	contextmenuName: (line, event) !->
		event.preventDefault!
		if isDev
			unless line.name in ["" \?]
				name = @getFullNameNoSubgenus line
				action =
					| event.altKey => \g
					| @code is \KeyB => \b
					| @code is \KeyL => \l
					| @code is \KeyH => \h
					| @code is \KeyE => \e
					| @code is \KeyS => \s
					| @code is \KeyN => \n
					| @code is \KeyK => \k
					else @rightClickAction
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
					window.open "https://www.flickr.com/search/?text=#name"
				else
					window.open "https://inaturalist.org/taxa/search?view=list&q=#name"
		else
			q = @getWikiPageName line, \en
			window.open "https://en.wikipedia.org/wiki/#q" \_blank

	mouseenterName: (line, event) !->
		unless line.name in [\? " "]
			{imgs} = line
			width = 328
			isTwoImage = imgs and imgs.0 and imgs.1
			name = @getFullNameNoSubgenus line
			icon = @getIcon line
			summary = ""
			updateHeight = !~>
				if popupEl.offsetHeight > innerHeight - 4
					words = summary.split " "
					if words.length > 2
						summary := words.slice 0 -1 .join " " .concat \...
						summaryEl.innerHTML = summary
						updateHeight!
					else
						@popper.update!
				else
					@popper.update!
			updateWidth = (step = 0) !~>
				unless isTwoImage
					maxWidth = icon and 239 or 309
					if nameEl.offsetWidth > maxWidth
						vals = name.split " "
						switch vals.length
						| 3
							switch step
							| 0
								name := "#{vals.0} #{vals.1.0}. #{vals.2}"
								nameEl.textContent = name
								updateWidth 1
							| 1
								name := "#{vals.0.0}. #{vals.1} #{vals.2}"
								nameEl.textContent = name
						| 2
							name := "#{vals.0.0}. #{vals.1}"
							nameEl.textContent = name
			popup =
				view: (vnode) ~>
					m \.popupBody,
						class: @class do
							"popupIsTrinomial": line.lv > 39
							"popupIsTwoImage": isTwoImage
						style:
							minWidth: width + \px
						m \.popupName,
							if icon
								m \img.popupIcon,
									src: "https://img.icons8.com/plumpy/1x/#icon.png"
							m \#nameEl name
						if line.textEn
							m \.popupTextEn line.textEn
						if line.textVi and isNaN line.textVi
							m \.popupTextVi line.textVi
						if imgs
							m \.popupGenders,
								class: @class do
									"popupGendersTwoImg": isTwoImage
								imgs.map (img, i) ~>
									if img
										m \.popupGender,
											m \.popupPicture,
												m \img.popupBgImg,
													src: img.0
												m \img.popupImg,
													src: img.0
													onload: (event) !~>
														{target} = event
														{width, height} = target
														if (width < 320 and height < 240) or (not isTwoImage and 1.233 < width / height < 1.333)
															target.classList.add \popupImg--cover
														if @popper
															updateHeight!
													onerror: !~>
														if @popper
															@popper.update!
											if imgs.length is 2 or imgs.some (?1)
												m \.popupGenderCaptn,
													if imgs.length is 2
														i and \Cái or \Đực
													if img.1
														if imgs.length is 2
															" \u2013 #{img.1}"
														else
															img.1
						m \.popupSummary#summaryEl,
							translate: yes
			m.mount popupEl, popup
			@popper = Popper.createPopper event.target, popupEl,
				placement: \left
				modifiers:
					* name: \offset
						options:
							offset: [0 21]
					* name: \preventOverflow
						options:
							padding: 2
			updateWidth!
			{summary} = await @fetchWiki line
			if @popper
				if summary
					summary = summary
						.replace /<br \/>/g ""
						.replace /(?<!\.)\.\.(?!\.)/g \.
				else
					summary = "Không có dữ liệu"
				summaryEl.innerHTML = summary
				updateHeight!

	mouseleaveName: !->
		if @popper
			if @abortCtrler
				@abortCtrler.abort!
				@abortCtrler = void
			@popper.destroy!
			@popper = void
			m.mount popupEl

	onclickTextEnCopy: (line, text, event) !->
		line.textEnCopy = text
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

	getFullNameNoSubgenus: (line) ->
		(line.fullName or line.name)replace /\ \(.+?\)/ ""

	getIcon: (line) ->
		if line
			if line.icon
				line.icon
			else
				@getIcon line.parent

	getWikiPageName: (line, lang) ->
		{disam} = line
		if disam
			index = +(lang is \vi)
			if disamLang = disam[index]
				chr = disamLang.0
				disamLang .= substring 1
		name = @getFullNameNoSubgenus line
		name .= replace /\ /g \_
		switch chr
		| \/ => disamLang or \_
		| \\ => "#{name}_(#disamLang)"
		else name

	fetchWiki: (line, cb) !->
		try
			lang = cb and \en or @popupLang
			q = @getWikiPageName line, lang
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
				if rs = extract_html.match /<b>.+?<\/b>/g
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
			if (data.type is \standard or isDev) and extract_html
				summary = /<p>(.+?)<\/p>/su
					.exec extract_html .0
					.replace /\n+/g " "
					.replace /^<p><b>(.+?)<\/b><\/p>$/u "<p>$1</p>"
			else throw
		catch
			summary = ""
		res = {summary, titles}
		if cb => cb line, res else return res

	fetchTextEnCopyLines: !->
		for line in @lines
			# if line.lv > 38 and line.textEn is void and line.textEnCopy is void
			if (line.lv > 38 or line.childs > 1) and line.textEn is void and line.textEnCopy is void
				line.textEnCopy = \...
				@fetchWiki line, (line, {titles}) !~>
					line.textEnCopy = titles or no
					m.redraw!

	scroll: !->
		top = Math.round scrollEl.scrollTop
		mod = top % lineH
		transY = top - mod
		presEl.style.transform = "translateY(#{transY}px)"
		localStorage.taxonTop = top
		start = Math.floor top / lineH
		unless start is @start and @lines.length is @len
			@start = start
			@lines = lines.slice start, start + @len
			if isDev
				unless @finding
					@fetchTextEnCopyLines!
			m.redraw!
		@mouseleaveName!

	onscroll: (event) !->
		event.redraw = no
		@scroll!

	onkeydown: (event) !->
		unless event.repeat
			unless event.location in [1 2]
				noFocus = document.activeElement is document.body
				@isKeyDown = yes
				@code = event.code
				switch @code
				| \KeyF
					if event.ctrlKey
						event.preventDefault!

	onkeyup: (event) !->
		if @isKeyDown
			noFocus = document.activeElement is document.body
			{ctrlKey: ctrl, shiftKey: shift, altKey: alt} = event
			switch @code
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
				if noFocus
					unless ctrl
						if isDev
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
			| \KeyT
				if noFocus
					unless ctrl
						if isDev
							lv = +prompt """
								Rank tối đa được hiển thị:
								1) vực                  2) giới               3) phân giới         4) thứ giới
								5) liên ngành       6) ngành          7) phân ngành     8) thứ ngành
								9) tiểu ngành      10) liên lớp       11) lớp                 12) phân lớp
								13) thứ lớp          14) tiểu lớp      15) đoàn              16) liên đội
								17) đội                18) tổng bộ      19) liên bộ            20) bộ
								21) phân bộ         22) thứ bộ       23) tiểu bộ           24) đoạn
								25) phân đoạn     26) liên họ       27) họ                  28) phân họ
								29) liên tông        30) tông          31) phân tông      32) chi
								33) phân chi        34) mục           35) phân mục       36) loạt
								37) phân loạt       38) liên loài     39) loài                 40) phân loài
								41) thứ                 42) dạng
							"""
							if lv
								maxLv := lv
								@lines = []
								{scrollTop} = scrollEl
								await parse!
								heightEl.style.height = lines.length * lineH + \px
								@scroll!
								m.redraw.sync!
								maxScrollTop = lines.length * lineH - scrollEl.offsetHeight
								if scrollTop > maxScrollTop
									scrollTop = maxScrollTop
								scrollEl.scrollTop = scrollTop
			| \KeyV
				if noFocus
					unless ctrl
						@popupLang = @popupLang is \vi and \en or \vi
						localStorage.taxonPopupLang = @popupLang
			| \KeyE
				if isDev
					try
						await navigator.clipboard.writeText ""
					catch
						alert e.message
			| \Digit1
				if noFocus
					unless ctrl
						if isDev
							window.open \diff
			| \Escape
				if @finding
					@closeFind!
			@code = void
			@isKeyDown = no
			m.redraw!

	onmousedown: (event) !->
		@isKeyDown = no

	onblur: (event) !->
		@code = void
		@isKeyDown = no

	onresize: !->
		@len = Math.ceil(innerHeight / lineH) + 1
		@scroll!
		m.redraw!

	view: ->
		m.fragment do
			m \#scrollEl,
				onscroll: @onscroll
				m \#presEl,
					@lines.map (line) ~>
						m \.line,
							key: line.index
							class: @class do
								"lineFind": @finding and line is @findLines[@findIndex]
							chars[line.chrs]map (char, i) ~>
								m \span,
									class: chrsRanks[i]0
									char
							m \.node,
								m \span.name,
									class: @getRankName line.lv
									onmouseenter: @mouseenterName.bind void line
									onmouseleave: @mouseleaveName
									onmousedown: @mousedownName.bind void line
									oncontextmenu: @contextmenuName.bind void line
									line.name
								if line.textEn or line.textVi or (line.textEnCopy and line.textEnCopy isnt \...)
									m \span.dash \\u2014
								if line.textEn
									m \span.textEn line.textEn
								if line.textEnCopy
									if Array.isArray line.textEnCopy
										m \.textEn,
											line.textEnCopy.map (text) ~>
												m \.textEnCopy,
													onclick: @onclickTextEnCopy.bind void line, text
													text
									else
										m \span.textEn line.textEnCopy
								if line.textVi
									m \span.textVi "(#{line.textVi})"
								line.imgs?map (img) ~>
									if img
										m \img.img,
											src: img.0
											onmousedown: @mousedownImg.bind void img
				m \#heightEl
			if infoLv
				m \#infosEl,
					for , info of infos
						if infoLv >= info.lv
							m.fragment do
								m \.info info.label
								m \.info numFmt.format info.count
								m \.info,
									if info.modfCount
										m \.modfCount,
											class: info.modfCount > 0 and \modfCountIncr or \modfCountDecr
											"(#{info.modfCount > 0 and \+ or ""}#{numFmt.format info.modfCount})"
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
