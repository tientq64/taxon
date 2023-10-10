!(async function () {
   process.chdir(__dirname);

   const fs = require('fs-extra');
   const jsYaml = require('js-yaml');
   const terser = require('terser');

   fs.emptyDirSync('dist');

   const package = fs.readJsonSync('package.json');

   let syntax = fs.readFileSync('syntaxes/taxon.tmLanguage.yaml', 'utf8');
   syntax = jsYaml.load(syntax);
   fs.outputJsonSync('dist/syntaxes/taxon.tmLanguage.json', syntax);

   let extension = fs.readFileSync('extension.js', 'utf8');
   extension = (await terser.minify(extension)).code;
   fs.outputFileSync('dist/extension.js', extension);

   const config = fs.readJsonSync('language-configuration.json');
   fs.outputJsonSync('dist/language-configuration.json', config);

   fs.copySync('LICENSE', 'dist/LICENSE');

   fs.outputJsonSync('dist/package.json', package);
})();
