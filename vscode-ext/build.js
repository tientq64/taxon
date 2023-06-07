!(async function() {
   process.chdir(__dirname)

   const fs = require('fs-extra')
   const jsYaml = require('js-yaml')
   const terser = require('terser')

   const vscodeExtsPath = 'F:/apps/Microsoft VS Code/resources/app/extensions'

   if (fs.existsSync(vscodeExtsPath)) {
      const vscodeExtsTaxonPath = vscodeExtsPath + '/taxon'

      fs.emptyDirSync(vscodeExtsTaxonPath)

      let yamlText = fs.readFileSync('./syntaxes/taxon.tmLanguage.yaml', 'utf8')
      let json = jsYaml.load(yamlText)
      fs.outputJsonSync(`${vscodeExtsTaxonPath}/syntaxes/taxon.tmLanguage.json`, json)

      let code = fs.readFileSync('./src/extension.js', 'utf8')
      code = (await terser.minify(code)).code
      fs.outputFileSync(`${vscodeExtsTaxonPath}/dist/extension.js`, code)

      json = fs.readJsonSync('./package.json')
      fs.outputJsonSync(`${vscodeExtsTaxonPath}/package.json`, json)

      json = fs.readJsonSync('./language-configuration.json')
      fs.outputJsonSync(`${vscodeExtsTaxonPath}/language-configuration.json`, json)
   } else {
      throw Error(`Không tìm thấy path: ${vscodeExtsPath}`)
   }
})()
