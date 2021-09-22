;(async function() {
	const {host, pathname} = location
	window.t = {
		wikipedia: /wikipedia\.org/.test(host),
		wikicommons: /commons\.wikimedia\.org/.test(host),
		wikispecies: /species\.wikimedia\.org/.test(host),
		wikiImg: /upload\.wikimedia\.org/.test(host),
		google: /google\.com/.test(host),
		imgur: /imgur\.com/.test(host),
		inaturalist: /inaturalist\.(org|ca)/.test(host),
		biolib: /biolib\.cz/.test(host),
		bugguide: /bugguide\.net/.test(host),
		fishbase: /fishbase\.(us|se)/.test(host),
		ebird: /ebird\.org/.test(host),
		seriouslyfish: /seriouslyfish\.com/.test(host)
	}
	t.wikiPage = t.wikipedia || t.wikicommons || t.wikispecies
	t.wiki = t.wikiPage || t.wikiImg
	t.imgurEdit = t.imgur && pathname == "/edit"
	t.imgurView = t.imgur && /^\/[A-Za-z\d]{7}($|\?)/.exec(pathname)
	t.inaturalistSearch = t.inaturalist && pathname == "/taxa/search"
	let [styl, code] = await Promise.all([
		(await fetch(chrome.runtime.getURL("extension.styl"))).text(),
		(await fetch(chrome.runtime.getURL("extension.ls"))).text()
	])
	styl = stylus.render(styl, {compress: true})
	code = livescript.compile(code)
	function load() {
		for (let k in t) {
			if (t[k]) {
				document.documentElement.classList.add("_" + k)
			}
		}
		let el = document.createElement("style")
		el.textContent = styl
		document.head.appendChild(el)
		eval(code)
		document.body.style.opacity = 1
		document.body.style.pointerEvents = "auto"
	}
	document.readyState === "complete"
		? load()
		: window.addEventListener("load", load)
})()
