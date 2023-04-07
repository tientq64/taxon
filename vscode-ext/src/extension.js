const vscode = require('vscode')

module.exports = {
   activate(context) {
      const disposable = vscode.commands.registerTextEditorCommand('extension.taxonFillEnNames', async (editor, edit) => {
         let texts = await vscode.env.clipboard.readText()

         if (texts) {
            texts = texts.split(/\r?\n/)

            let line, col, name, pos

            for (let text of texts) {
               await editor.edit(edit => {
                  [line, name] = text.split('||')
                  line--
                  let lineText = editor.document.lineAt(line).text
                  col = lineText.indexOf(' #')
                  col = col >= 0 ? col + 2 : lineText.length

                  pos = new vscode.Position(line, col)
                  edit.insert(pos, name)
               })
            }

            pos = pos.translate(0, name.length)
            let sel = new vscode.Selection(pos, pos)
            editor.selection = sel

            let range = new vscode.Range(pos, pos)
            editor.revealRange(range, vscode.TextEditorRevealType.InCenter)

            await vscode.env.clipboard.writeText('')
         }
      })

      context.subscriptions.push(disposable)
   }
}
