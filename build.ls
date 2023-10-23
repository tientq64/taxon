require! {
   fs
   "livescript2": livescript
   "stylus2": stylus
   "jsdom": {JSDOM}
   minify
}

dom = await JSDOM.fromFile \dev.html
{document} = dom.window

for el in document.querySelectorAll "[data-dev]"
   el.remove!

css = fs.readFileSync \index.styl \utf8
css = stylus.render css,
   compress: yes
cssEl = document.querySelector "[data-css]"
cssEl.outerHTML = "<style>#css</style>"

js = fs.readFileSync \index.ls \utf8
js = livescript.compile js,
   header: no
jsEl = document.querySelector "[data-js]"
jsEl.outerHTML = "<script>#js</script>"

html = dom.serialize!
html = await minify.html html

fs.writeFileSync \index.html html
