;(async function() {
   const {href, host, pathname, search} = location
   window.t = {
      wikipedia: /wikipedia\.org/.test(host),
      wikicommons: /commons\.wikimedia\.org/.test(host),
      wikispecies: /species\.wikimedia\.org/.test(host),
      wikiImg: /upload\.wikimedia\.org/.test(host),
      wikiLogin: href == "https://en.wikipedia.org/w/index.php?title=Special:UserLogin",
      google: /google\.com/.test(host),
      imgur: /imgur\.com/.test(host),
      inaturalist: /inaturalist\.(org|ca)/.test(host),
      biolib: /biolib\.cz/.test(host),
      bugguide: /bugguide\.net/.test(host),
      fishbase: /fishbase\.(us|se)/.test(host),
      ebird: /ebird\.org/.test(host),
      seriouslyfish: /seriouslyfish\.com/.test(host),
      flickr: /flickr\.com/.test(host)
   }
   t.wikiEdit = t.wikipedia && /\bveaction=edit\b/.test(search)
   t.wikiWiki = t.wikipedia && /^\/(w\/index\.php$|wiki\/.+)/.test(pathname) && !t.wikiEdit
   t.wikiPage = t.wikiWiki || t.wikicommons || t.wikispecies
   t.wiki = t.wikiPage || t.wikiImg || t.wikiLogin
   t.imgurEdit = t.imgur && pathname == "/edit"
   t.imgurView = t.imgur && /^\/[A-Za-z\d]{7}($|\?)/.exec(pathname)
   t.imgurAuth = href.startsWith("https://api.imgur.com/oauth2/authorize?")
   t.inaturalistSearch = t.inaturalist && pathname == "/taxa/search"
   t.flickrPhotos = t.flickr && pathname.startsWith("/photos/")
   let [styl, code, OCTOKEN] = await Promise.all([
      fetch(chrome.runtime.getURL("extension.styl")).then(res => res.text()),
      fetch(chrome.runtime.getURL("extension.ls")).then(res => res.text()),
      fetch(chrome.runtime.getURL("OCTOKEN")).then(res => res.text())
   ])
   styl = stylus.render(styl, {compress: true})
   code = livescript.compile(code)
   delete stylus
   delete livescript
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
   if (document.readyState == "complete") {
      load()
   } else {
      window.addEventListener("load", load)
   }
})()
