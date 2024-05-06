const fs = require('fs-extra')
const jsyaml = require('js-yaml')
const livescript = require('livescript2')
const stylus = require('stylus2')
const { JSDOM } = require('jsdom')
const terser = require('terser')
const minify = require('minify')

;(async () => {
	const dom = await JSDOM.fromFile('dev.html')
	const { document } = dom.window

	for (const el of document.querySelectorAll('[data-dev]')) {
		el.remove()
	}

	let css, js, html, code, json

	css = fs.readFileSync('index.styl', 'utf8')
	css = stylus.render(css, { compress: true })
	const cssEl = document.querySelector('[data-css]')
	cssEl.outerHTML = `<style>${css}</style>`

	js = fs.readFileSync('index.ls', 'utf8')
	js = livescript.compile(js)
	const jsEl = document.querySelector('[data-js]')
	jsEl.outerHTML = `<script>${js}</script>`

	html = dom.serialize()
	html = await minify.html(html)

	fs.writeFileSync('index.html', html)

	fs.ensureDirSync('vscode-ext/dist')
	fs.emptyDirSync('vscode-ext/dist')

	const pack = fs.readJsonSync('vscode-ext/package.json')
	fs.outputJsonSync('vscode-ext/dist/package.json', pack)

	const yaml = fs.readFileSync('vscode-ext/syntaxes/taxon.tmLanguage.yaml', 'utf8')
	json = jsyaml.load(yaml)
	fs.outputJsonSync('vscode-ext/dist/syntaxes/taxon.tmLanguage.json', json)

	code = fs.readFileSync('vscode-ext/extension.js', 'utf8')
	code = (await terser.minify(code)).code
	fs.outputFileSync('vscode-ext/dist/extension.js', code)

	json = fs.readJsonSync('vscode-ext/language-configuration.json')
	fs.outputJsonSync('vscode-ext/dist/language-configuration.json', json)

	fs.copyFileSync('icon.png', 'vscode-ext/dist/icon.png')
	fs.copyFileSync('vscode-ext/LICENSE', 'vscode-ext/dist/LICENSE')

	console.log('Built')
})()
