const vscode = require('vscode');

module.exports = {
  activate(context) {
    const taxonFillEnNames = vscode.commands.registerTextEditorCommand(
      'extension.taxonFillEnNames',
      async (editor, edit) => {
        const SEPARATOR = '|DA84.&D-+7eDL2qr|';

        let texts = await vscode.env.clipboard.readText();

        if (texts) {
          await vscode.env.clipboard.writeText('');

          texts = texts.split(/\r?\n/);

          let line, col, name, pos;

          for (const text of texts) {
            await editor.edit((edit) => {
              if (text.includes(SEPARATOR)) {
                [line, name] = text.split(SEPARATOR);
                line--;
                let lineText = editor.document.lineAt(line).text;
                col = lineText.indexOf(' #');
                col = col >= 0 ? col + 2 : lineText.length;

                pos = new vscode.Position(line, col);
                edit.insert(pos, name);
              }
            });
          }

          if (name) {
            pos = pos.translate(0, name.length);
            const sel = new vscode.Selection(pos, pos);
            editor.selection = sel;

            const range = new vscode.Range(pos, pos);
            editor.revealRange(range, vscode.TextEditorRevealType.InCenter);
          }
        }
      }
    );

    const taxonPaste = vscode.commands.registerTextEditorCommand(
      'extension.taxonPaste',
      async (editor, edit) => {
        const text = await vscode.env.clipboard.readText();

        if (text) {
          await vscode.env.clipboard.writeText('');

          await editor.edit((edit) => {
            let pos = editor.selection.active;

            const newLine = pos.line + 1;
            const newCol = editor.document.lineAt(pos.line + 1).text.length + 1;
            const newPos = pos.with(newLine, newCol);

            edit.insert(pos, text);

            const sel = new vscode.Selection(newPos, newPos);
            editor.selection = sel;

            setTimeout(() => {
              const range = new vscode.Range(newPos, newPos);
              editor.revealRange(range, vscode.TextEditorRevealType.InCenterIfOutsideViewport);
            });
          });
        }
      }
    );

    context.subscriptions.push(taxonFillEnNames, taxonPaste);
  }
};
