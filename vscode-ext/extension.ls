require! vscode

!function taxonFillEnNames editor, edit
	SEPARATOR = \|DA84.&D-+7eDL2qr|
	text = await vscode.env.clipboard.readText!
	if text
		await vscode.env.clipboard.writeText ""
		lines = text.split /\r?\n/
		name = void
		pos = void
		for line in lines
			if line.includes SEPARATOR
				await editor.edit (edit) !~>
					data = line.split SEPARATOR
					row = data.0 - 1
					name := data.1
					lineText = editor.document.lineAt row .text
					col = lineText.indexOf " #"
					col = if col >= 0 => col + 2 else lineText.length
					pos := new vscode.Position row, col
					edit.insert pos, name
		if name
			pos .= translate 0, name.length
			sel = new vscode.Selection pos, pos
			editor.selection = sel
			range = new vscode.Range pos, pos
			editor.revealRange range, vscode.TextEditorRevealType.InCenter
			await editor.document.save!

!function taxonPaste editor, edit
	text = await vscode.env.clipboard.readText!
	if text
		await vscode.env.clipboard.writeText ""
		await editor.edit (edit) !~>
			pos = editor.selection.active
			newRow = pos.line + 1
			newCol = editor.document.lineAt newRow .text.length + 1
			newPos = pos.with newRow, newCol
			edit.insert pos, text
			sel = new vscode.Selection newPos, newPos
			editor.selection = sel
			setTimeout !~>
				range = new vscode.Range newPos, newPos
				editor.revealRange range, vscode.TextEditorRevealType.InCenterIfOutsideViewport
				await editor.document.save!

!function activate context
	taxonPasteCommand = vscode.commands.registerTextEditorCommand do
		\extension.taxonPaste
		taxonPaste
	taxonFillEnNamesCommand = vscode.commands.registerTextEditorCommand do
		\extension.taxonFillEnNames
		taxonFillEnNames
	context.subscriptions.push taxonFillEnNamesCommand, taxonPasteCommand

module.exports =
	activate: activate
