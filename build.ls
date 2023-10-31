require! {
   "fs-extra": fs
   "js-yaml": jsyaml
   "livescript2": livescript
   "stylus2": stylus
   "jsdom": {JSDOM}
   terser
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
js = livescript.compile js
jsEl = document.querySelector "[data-js]"
jsEl.outerHTML = "<script>#js</script>"

html = dom.serialize!
html = await minify.html html

fs.writeFileSync \index.html html

fs.emptyDirSync \vscode-ext/dist

pack = fs.readJsonSync \vscode-ext/package.json

yaml = fs.readFileSync \vscode-ext/syntaxes/taxon.tmLanguage.yaml \utf8
json = jsyaml.load yaml
fs.outputJsonSync \vscode-ext/dist/syntaxes/taxon.tmLanguage.json json

code = fs.readFileSync \vscode-ext/extension.ls \utf8
code = livescript.compile code
{code} = await terser.minify code
fs.outputFileSync \vscode-ext/dist/extension.js code

json = fs.readJsonSync \vscode-ext/language-configuration.json
fs.outputJsonSync \vscode-ext/dist/language-configuration.json json

fs.copySync \vscode-ext/LICENSE \vscode-ext/dist/LICENSE
fs.outputJsonSync \vscode-ext/dist/package.json pack
