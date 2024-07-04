localStorage
	..taxonFindExact ?= ""
	..taxonFindCase ?= \1
	..taxonInfoLv ?= \0
	..taxonRightClickAction ?= \k
	..taxonPopupLang ?= \en

lineHeight = 18
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
textRanks =
	["" ""]
	["Domain" "Vực"]
	["Kingdom" "Giới"]
	["Subkingdom" "Phân giới"]
	["Infrakingdom" "Thứ giới"]
	["Superphylum" "Liên ngành"]
	["Phylum" "Ngành"]
	["Subphylum" "Phân ngành"]
	["Infraphylum" "Thứ ngành"]
	["Parvphylum" "Tiểu ngành"]
	["Superclass" "Liên lớp"]
	["Class" "Lớp"]
	["Subclass" "Phân lớp"]
	["Infraclass" "Thứ lớp"]
	["Parvclass" "Tiểu lớp"]
	["Legion" "Đoàn"]
	["Supercohort" "Liên đội"]
	["Cohort" "Đội"]
	["Megaorder" "Tổng bộ"]
	["Superorder" "Liên bộ"]
	["Order" "Bộ"]
	["Suborder" "Phân bộ"]
	["Infraorder" "Thứ bộ"]
	["Parvorder" "Tiểu bộ"]
	["Section" "Đoạn"]
	["Subsection" "Phân đoạn"]
	["Superfamily" "Liên họ"]
	["Family" "Họ"]
	["Subfamily" "Phân họ"]
	["Supertribe" "Liên tông"]
	["Tribe" "Tông"]
	["Subtribe" "Phân tông"]
	["Genus" "Chi"]
	["Subgenus" "Phân chi"]
	["Section" "Mục"]
	["Subsection" "Phân mục"]
	["Series" "Loạt"]
	["Subseries" "Phân loạt"]
	["Superspecies" "Liên loài"]
	["Species" "Loài"]
	[["Subspecies" "Subsp."] ["Phân loài" "Ph.loài"]]
	[["Variety" "Var."] "Thứ"]
	["Form" "Dạng"]
isDev = location.hostname in [\localhost \127.0.0.1]
numberFormat = new Intl.NumberFormat \en
maxLv = void
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
	speciesSubspHasEnName:
		label: "Phân loài và loài có tên tiếng Anh"
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
	headRegex = /^(\t*)(.+?)(\*)?(?: ([\\/].*?))?(?: \|([-a-z\d]+?))?(?: (!))?$/
	tailRegex = /^([-/:@%~^+$<>=!&*?]|https?:\/\/)/
	disamSplitRegex = /(?=[\\/])/
	inaturalistRegex = /^(:?)(\d+)([epJEPu]?)$/
	inaturalistExts = "": \jpg e: \jpeg p: \png J: \JPG E: \JPEG P: \PNG u: ""
	reeflifesurveyExts = j: \jpg J: \JPG
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
		[, lv, name, ex, disam, icon, isDuplicateTextEn] = headRegex.exec head
		lv = lv.length + 1
		name = " " if name == \_
		if disam
			disam = disam.split disamSplitRegex .map (val) ~>
				if val == \\ => void else val
		if text
			if tailRegex.test text
				tail = text
				text = void
			if text
				[textEn, textVi] = text.split /\ ?\| /
			# if textEn and !textVi and lv > 38
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
						unless src == \?
							captn = void if captn == \.
							key = src.0
							src .= substring 1
							switch key
							| \-
								src = "https://i.imgur.com/#{src}m.png"
							| \/
								if src.0 == \/
									src = "https:#src.jpg"
								else
									if src.0 == \~
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
							| \%
								src = "https://www.biolib.cz/IMG/GAL/#src.jpg"
							| \~
								[, src, type] = bugguideRegex.exec src
								type = bugguideTypes[type]
								src = "https://bugguide.net/images/#type/#{src.substring 0 3}/#{src.substring 3 6}/#src.jpg"
							| \^
								if src.0 == \^
									path = \tools/uploadphoto/uploads
									src .= substring 1
								else
									path = \images/species
								src = "https://d1iraxgbwuhpbw.cloudfront.net/#path/#src.jpg"
							| \+
								src = "https://cdn.download.ams.birds.cornell.edu/api/v1/asset/#{src}/320"
							| \$
								src = "https://reptile-database.reptarium.cz/content/photo_#src.jpg"
							| \<
								src = "https://www.fishwisepro.com/pics/JPG/#src.jpg"
							| \>
								[node, src] = src.split \/
								src = "https://biogeodb.stri.si.edu/#node/resources/img/images/species/#src.jpg"
							| \=
								src = "https://cdn.jsdelivr.net/gh/tientq64/taimg/#src.webp"
							| \!
								src = "https://i.pinimg.com/564x/#src.jpg"
							| \&
								src = "https://images.marinespecies.org/thumbs/#src.jpg?w=320"
							| \*
								ext = reeflifesurveyExts[src.at -1]
								src .= slice 0 -1
								src = "https://images.reeflifesurvey.com/0/species_#src.w400.h266.#ext"
							else
								src = "h#src"
							[src, captn]
		node = [lv, name]
		node.2 = yes if ex
		node.3 = disam if disam
		node.5 = textEn if textEn
		node.6 = textVi if textVi
		node.7 = imgs if imgs
		node.8 = icon if icon
		node.9 = yes if isDuplicateTextEn
		if refs.some (.0 >= lv)
			refs .= filter (.0 < lv)
		ref = refs[* - 1]
		ref[]4.push node
		refs.push node
	addNode = (node, parent, parentLv, parentName, extinct, chrs, isFirst, isLast, nextSiblExtinct) !~>
		[lv, name, ex, disam, childs, textEn, textVi, imgs, icon, isDuplicateTextEn] = node
		extinct = yes if ex
		if parentLv >= 0
			lvRange = lv - parentLv - 1
			if extinct
				chrs2 = (chrs + (isFirst and ("╍╍"repeat lvRange) + \╍┓ or ("  "repeat lvRange) + " ┋"))
					.replace /\ (?=[╍━┓])/ \╹
					.replace /┃(?=[━┓])/ \┣
			else
				chrs2 = (chrs + (isFirst and ("━━"repeat lvRange) + \━┓ or ("  "repeat lvRange) + " ┃"))
					.replace /\ (?=[╍━┓])/ \┗
					.replace /[┃┋](?=[━┓])/ \┣
		else
			chrs2 = " ┃"
		if chars[chrs2]?
			chrs2 = chars[chrs2]
		else
			chrs2 = chars[chrs2] = charsId++
		if lv >= 39
			if lv == 41
				fullName = "#parentName var. #name"
			else
				fullName = "#parentName #name"
			if lv == 39
				infos.species.count++
			infos.speciesSubspHasEnName.count++ if textEn
			infos.speciesSubspHasViName.count++ if textVi
			unless childs
				infos.speciesSubsp.count++
				infos.speciesSubspHasImg.count++ if imgs
				infos.speciesSubspExtinct.count++ if extinct
		else if lv == 32
			infos.genus.count++
		else if lv == 27
			infos.family.count++
		line =
			index: ++index
			lv: lv
			name: name
			chrs: chrs2
		line.textEn = textEn if textEn
		line.textVi = textVi if textVi
		if maxLv and maxLv < 39 and childs and childs.0.0 > maxLv
			line.isShowChildsCount = yes
		if imgs
			line.imgs = imgs
			infos.img.count += imgs.length
		line.extinct = extinct if extinct
		line.disam = disam if disam
		line.fullName = fullName if fullName
		line.icon = icon if icon
		line.isDuplicateTextEn = isDuplicateTextEn if isDuplicateTextEn
		line.parent = parent if parent
		lines.push line
		if childs
			line.childsCount = childs.length
			chrs += "  "repeat(lvRange) + (isLast and "  " or (if extinct or nextSiblExtinct => " ┋" else " ┃"))
			if lv < 34 or lv > 38
				if name !in [\? " "]
					if lv == 33
						parentName = "#parentName (#name)"
					else
						parentName = fullName or name
				else if lv == 32
					parentName = \" + parentName + \"
			lastIndex = childs.length - 1
			for child, i in childs
				addNode child, line, lv, parentName, extinct, chrs, !i, i == lastIndex, childs[i + 1]?2
	addNode tree,, -1 "" no "" yes yes
	chars := Object.keys chars
	for char, i in chars
		chrs = []
		len = char.length / 2
		chr = ""
		for chrsRank in chrsRanks
			if len > chrsRank.1
				chr2 = char.substring chrsRank.1 * 2, chrsRank.2 * 2
				chr += chr2
				if chr2.trimEnd!
					chr .= replace /\  /g \\t
					chrs.push chr
					chr = ""
				else
					chrs.push void
			else break
		chars[i] = chrs
	infos.taxon.count = lines.length
	infos.speciesSubspExists.count = infos.speciesSubsp.count - infos.speciesSubspExtinct.count
	if maxLv
		lines := lines.filter (.lv <= maxLv)

await parse!

modfTime = new Date!setHours 0 0 0 0
try
	modfCounts = JSON.parse localStorage.taxonModfCounts
catch
	modfCounts = {}
	for k, info of infos
		modfCounts[k] = info.count
if modfTime == +localStorage.taxonModfTime
	for k, info of infos
		info.modfCount = info.count - modfCounts[k]
else
	for k, info of infos
		modfCounts[k] = info.count
		info.modfCount = 0
	localStorage.taxonModfTime = modfTime
	localStorage.taxonModfCounts = JSON.stringify modfCounts

App =
	oninit: !->
		for k, prop of @
			@[k] = prop.bind @ if typeof prop == \function
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
		@hoveredLine = void
		@popper = void
		@abortCtrler = void
		@rightClickAction = localStorage.taxonRightClickAction
		@popupLang = localStorage.taxonPopupLang

	oncreate: !->
		heightEl.style.height = lines.length * lineHeight + \px
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

	getRankTexts: (lv, lang, isGetAbbr) ->
		texts = textRanks[lv]
		text = texts[Number lang == \vi]
		if Array.isArray text
			text[+isGetAbbr]
		else text

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
						val == fullName or val == textVi
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
			scrollEl.scrollTop = (@findLines[@findIndex]index - 4) * lineHeight
			@scroll!

	toggleFindExact: !->
		!= @findExact
		localStorage.taxonFindExact = @findExact and \1 or ""
		@find!

	toggleFindCase: !->
		!= @findCase
		localStorage.taxonFindCase = @findCase and \1 or ""
		@find!

	togglePopupLang: !->
		@popupLang = @popupLang == \vi and \en or \vi
		localStorage.taxonPopupLang = @popupLang

	closeFind: !->
		if @finding
			@finding = no
			@findLines = []
			@fetchTextEnCopyLines!
			m.redraw!

	openGoogleCommonName: (line) ->
		name = @getFullNameNoSubgenus line
		row = line.index
		copiedType =
			| line.textVi => 0
			| line.imgs => 1
			else 2
		window.open "https://google.com/search?q=#name+common+name&row=#row&copiedType=#copiedType" \_blank

	getSiblingLines: (startLine, maxChilds = 10, conditionFunc = ~> yes) ->
		childs = []
		index = lines.indexOf startLine
		loop
			child = lines[index]
			if !child or childs.length >= maxChilds or child.lv < startLine.lv
				break
			else if child.lv == startLine.lv and child.name !in ["" \?] and conditionFunc child
				childs.push child
			index++
		childs

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
			| src.includes \images.marinespecies.org
				src .= replace \?w=320 \?w=1200
			| src.includes \i.pinimg.com
				src .= replace \564x \originals
			| src.includes \reeflifesurvey.com
				src .= replace \.w400.h266 ""
			| src.includes \i.imgur.com
				if @code == \Delete
					src -= /(?<=:\/\/)i\.|m\.\w+$/g
					src += \?_taxonDelete=1
				else
					src .= replace /m(?=\.\w+$)/ \r
			| src.includes \cdn.jsdelivr.net/gh/tientq64/taimg
				name = src.split \/ .[* - 1]
				act = @code == \Delete and \delete or \blob
				src = "https://github.com/tientq64/taimg/#act/main/#name"
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
				name = @getFullNameNoSubgenus line
				if event.altKey
					if isDev
						copiedText = name
					else
						copiedText = line.name
				else if event.ctrlKey
					if isDev
						childs = @getSiblingLines line, 10 ~>
							!it.textEn and !it.isDuplicateTextEn
						for let child, i in childs
							setTimeout !~>
								@openGoogleCommonName child
							, i * 500
				else
					if isDev
						@openGoogleCommonName line
					else
						copiedText = name
				if copiedText
					try
						navigator.clipboard.writeText copiedText
					catch
						alert e.message

	contextmenuName: (line, event) !->
		event.preventDefault!
		if isDev
			unless line.name in ["" \?]
				if event.ctrlKey
					childs = @getSiblingLines line, 10
					for child in childs
						name = @getFullNameNoSubgenus child
						@windowOpenByAction \k name
				else
					name = @getFullNameNoSubgenus line
					action =
						| event.altKey => \g
						| @code == \KeyB => \b
						| @code == \KeyL => \l
						| @code == \KeyH => \h
						| @code == \KeyE => \e
						| @code == \KeyS => \s
						| @code == \KeyN => \n
						| @code == \KeyK => \k
						| @code == \KeyR => \r
						| @code == \KeyM => \m
						else @rightClickAction
					@windowOpenByAction action, name
		else
			q = @getWikiPageName line, \en
			window.open "https://en.wikipedia.org/wiki/#q" \_blank

	windowOpenByAction: (action, name) !->
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
			name .= toLowerCase!replace /\ /g \-
			window.open "https://www.seriouslyfish.com/species/#name"
		| \n
			window.open "https://inaturalist.org/taxa/search?view=list&q=#name"
		| \k
			window.open "https://www.flickr.com/search/?text=#name"
		| \r
			window.open "https://repfocus.dk/#name.html"
		| \m
			window.open "https://www.herpmapper.org/taxon/#name"

	getAbbrWordName: (word) ->
		chr = word.0
		if chr == \"
			"\"#{word.1}.\""
		else
			"#chr."

	mouseenterName: (line, isBcrum, event) !->
		unless line.name in [\? " "]
			@hoveredLine = line
			{imgs} = line
			imgs .= slice 0 2 if imgs
			width = 328
			isTwoImage = Boolean imgs && imgs.0 && imgs.1
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
					maxWidth = 224
					if nameEl.offsetWidth > maxWidth
						vals = name.split " "
						switch vals.length
						| 4
							switch step
							| 0
								name := "#{vals.0} #{@getAbbrWordName vals.1} #{vals.2} #{vals.3}"
								nameEl.textContent = name
								updateWidth 1
							| 1
								name := "#{@getAbbrWordName vals.0} #{vals.1} #{vals.2} #{vals.3}"
								nameEl.textContent = name
						| 3
							switch step
							| 0
								name := "#{vals.0} #{@getAbbrWordName vals.1} #{vals.2}"
								nameEl.textContent = name
								updateWidth 1
							| 1
								name := "#{@getAbbrWordName vals.0} #{vals.1} #{vals.2}"
								nameEl.textContent = name
						| 2
							name := "#{@getAbbrWordName vals.0} #{vals.1}"
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
								m \.popupIcon,
									style:
										backgroundImage: "url(https://cdn-icons-png.flaticon.com/24/#{icon.slice 0 -3}/#icon.png)"
							m \#nameEl name
							m \.popupRank,
								@getRankTexts line.lv, @popupLang, yes
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
														if (width < 320 and height < 240) or (!isTwoImage and 1.233 < width / height < 1.333)
															target.classList.add \popupImgCover
														if @popper
															updateHeight!
													onerror: !~>
														if @popper
															@popper.update!
											if imgs.length == 2 or imgs.some (?1)
												m \.popupGenderText,
													if imgs.length == 2
														i and \Cái or \Đực
													if img.1
														if imgs.length == 2
															" \u2013 #{img.1}"
														else
															img.1
						m \.popupSummary#summaryEl,
							translate: yes
			m.mount popupEl, popup
			if @popper
				@popper.update!
			else
				@popper = Popper.createPopper event.target, popupEl,
					placement: isBcrum and \bottom or \left
					modifiers:
						*	name: \offset
							options:
								offset: isBcrum and [0 0] or [0 21]
						*	name: \preventOverflow
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
		if @hoveredLine
			@hoveredLine = void
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
			copiedText = await navigator.clipboard.readText!
			copiedText and+= \\n
			copiedText += "#row|kDDVKETwoTIKUZ2RYmima|"
			copiedText += switch
				| line.textVi => " #text"
				| line.imgs => " #text #"
				else " # #text"
			await navigator.clipboard.writeText copiedText
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

	getParents: (line) ->
		parents = []
		loop
			line .= parent
			break if !line
			parents.push line
		parents

	getWikiPageName: (line, lang) ->
		{disam} = line
		if disam
			index = Number lang == \vi
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
				@abortCtrler?abort!
				@abortCtrler = new AbortController
				opts.signal = @abortCtrler.signal
			data = await (await fetch "https://#lang.wikipedia.org/api/rest_v1/page/summary/#q" opts)json!
			unless cb
				@abortCtrler = void
			{extract_html} = data
			if data.type == \standard
				title = data.title.replace /\ \(.+?\)/ ""
				name1 = line.fullName or line.name
				names = [name1]
				name2 = @getFullNameNoSubgenus line
				names.push name2 unless name2 == name1
				node = line
				while node .= parent
					names.push @getFullNameNoSubgenus node
				matches = [title]
				if mat = extract_html.match /<b>.+?<\/b>/g
					matches.push ...mat
				for title in matches
					if r = /<(\w+)[^>]*>(.+?)<\/\1>/exec title
						title = r.2
					title = title
						.replace /,/g ""
						.trim!
					if title and !names.includes title and !title.includes ". "
						title = title.0.toUpperCase! + title.substring 1
						titles ?= []
						unless titles.includes title
							titles.push title
			if (data.type == \standard or isDev) and extract_html
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
			# if line.lv > 38 and line.textEn == void and line.textEnCopy == void
			# if (line.lv > 38 or line.childsCount > 1) and line.textEn == void and line.textEnCopy == void
			if (line.lv >= 0 and line.childsCount != 1) and line.textEn == void and line.textEnCopy == void
				line.textEnCopy = \...
				@fetchWiki line, (line, {titles}) !~>
					if titles
						titles .= map (title) ~>
							title.replace /’/g \'
					line.textEnCopy = titles or no
					if line.isDuplicateTextEn
						line.textEnCopy or= [\""]
					m.redraw!

	scroll: !->
		top = Math.round scrollEl.scrollTop
		transY = top - top % lineHeight
		linesEl.style.transform = "translateY(#{transY}px)"
		localStorage.taxonTop = top
		start = Math.floor top / lineHeight
		unless start == @start and @lines.length == @len
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

	onwheel: (event) !->
		event.redraw = no
		return if !event.altKey
		event.preventDefault!
		scrollEl.scrollTop += event.deltaY * 5

	onkeydown: (event) !->
		unless event.repeat
			unless event.location in [1 2]
				noFocus = document.activeElement == document.body
				@isKeyDown = yes
				@code = event.code
				switch @code
				| \KeyF
					if event.ctrlKey
						event.preventDefault!

	onkeyup: (event) !->
		if @isKeyDown
			noFocus = document.activeElement == document.body
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
					infoLv := if infoLv and infoLv == val => 0 else val
					localStorage.taxonInfoLv = infoLv
					m.redraw!
			| \KeyA
				if noFocus
					unless ctrl
						if isDev
							action = prompt """
								Nhập hành động khi bấm chuột phải:
								g) google
								c) google (common name)
								b) bugguide
								l) biolib
								h) fishbase
								e) ebird
								s) seriouslyfish
								n) inaturalist
								k) flickr (mặc định)
								r) repfocus
								m) herpmapper
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
								heightEl.style.height = lines.length * lineHeight + \px
								@scroll!
								m.redraw.sync!
								maxScrollTop = lines.length * lineHeight - scrollEl.offsetHeight
								if scrollTop > maxScrollTop
									scrollTop = maxScrollTop
								scrollEl.scrollTop = scrollTop
			| \KeyV
				if noFocus
					unless ctrl
						@togglePopupLang!
						if @hoveredLine
							@mouseenterName @hoveredLine
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
		@len = Math.ceil(innerHeight / lineHeight) + 1
		@scroll!
		m.redraw!

	lineView: (line, isBcrum, bcrumZIndex, prevLine) ->
		m \.line,
			key: line.index
			class: @class do
				"lineFind": @finding and line == @findLines[@findIndex]
			chars[line.chrs]map (char, i) ~>
				m \.indent,
					class: chrsRanks[i]0
					char
			m \.node,
				style:
					width: (prevLine.lv - line.lv) * 18 + \px if prevLine
					background: \#0000 if line.name == " "
					overflow: \hidden if prevLine
					zIndex: bcrumZIndex
				m \.nodeName,
					class: @getRankName line.lv
					onmouseenter: @mouseenterName.bind void line, isBcrum
					onmouseleave: @mouseleaveName
					onmousedown: @mousedownName.bind void line
					oncontextmenu: @contextmenuName.bind void line
					line.name == " " and \-- or line.name
				if line.textEn or line.textVi or (line.textEnCopy and line.textEnCopy != \...)
					m \.nodeDash,
						\\u2014
				if line.textEn
					m \.nodeTextEn,
						line.textEn
				if line.textEnCopy
					if Array.isArray line.textEnCopy
						m \.nodeTextEn,
							line.textEnCopy.map (text) ~>
								m \.nodeTextEnCopy,
									class: "nodeTextEnCopyIsDuplicateTextEn" if line.isDuplicateTextEn
									onclick: @onclickTextEnCopy.bind void line, text
									text
					else
						m \.nodeTextEn,
							line.textEnCopy
				if line.textVi
					m \.nodeTextVi,
						line.textVi
				if line.isShowChildsCount
					m \.nodeTextVi,
						"(#{line.childsCount})"
				line.imgs?map (img, i) ~>
					if img and i < 2
						m \img.nodeImg,
							src: img.0
							onmousedown: @mousedownImg.bind void img

	view: ->
		m \.main,
			m \.scroll#scrollEl,
				onwheel: @onwheel
				onscroll: @onscroll
				m \.lines#linesEl,
					@lines.map (line) ~>
						@lineView line, no, void, void
				m \.height#heightEl
			if @lines.1 and !maxLv
				m \.bcrums,
					@getParents @lines.1 .map (line, i, items) ~>
						prevLine = items[i - 1]
						m \.bcrum,
							key: line.index
							@lineView line, yes, textRanks.length - i, prevLine
							@lineView lines[line.index + 1], yes, void, prevLine
			if infoLv
				m \.infos,
					for , info of infos
						if infoLv >= info.lv
							m.fragment do
								m \.info info.label
								m \.info numberFormat.format info.count
								m \.info,
									if info.modfCount
										m \.modfCount,
											class: info.modfCount > 0 and \modfCountIncr or \modfCountDecr
											"(#{info.modfCount > 0 and \+ or ""}#{numberFormat.format info.modfCount})"
					m \.info "Ngôn ngữ popup"
					m \.info @popupLang
			else
				m \.lang,
					class: "langIsVi" if @popupLang == \vi
					title: "Ngôn ngữ trong phần mô tả"
					onclick: !~>
						@togglePopupLang!
					@popupLang
			if @finding
				m \.find,
					m \input.findInput#findInputEl,
						placeholder: "Tìm kiếm"
						autocomplete: \off
						value: @findVal
						oninput: !~>
							@find it.target.value
						onkeydown: !~>
							if it.key == \Enter
								@findGo it.shiftKey && -1 || 1
					m \.findCount,
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
						"Aa"
					m \.findButton.findClose,
						title: "Đóng"
						onclick: @closeFind
						"\u2a09"
			m \.popup#popupEl

m.mount document.body, App
