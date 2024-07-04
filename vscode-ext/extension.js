const vscode = require('vscode')

async function taxonFillEnNames(editor, edit) {
	const SEPARATOR = '|kDDVKETwoTIKUZ2RYmima|'
	const text = await vscode.env.clipboard.readText()
	if (!text) return
	await vscode.env.clipboard.writeText('')
	const lines = text.split(/\r?\n/)
	let name, position
	for (const line of lines) {
		if (!line.includes(SEPARATOR)) continue
		await editor.edit((edit) => {
			const data = line.split(SEPARATOR)
			const row = data[0] - 1
			name = data[1]
			const lineText = editor.document.lineAt(row).text
			const index = lineText.indexOf(' #')
			const col = index >= 0 ? index + 2 : lineText.length
			position = new vscode.Position(row, col)
			edit.insert(position, name)
		})
	}
	if (!name) return
	position = position.translate(0, name.length)
	const selection = new vscode.Selection(position, position)
	editor.selection = selection
	const range = new vscode.Range(position, position)
	editor.revealRange(range, vscode.TextEditorRevealType.InCenter)
	await editor.document.save()
}

async function taxonPaste(editor, edit) {
	const text = await vscode.env.clipboard.readText()
	if (!text) return
	await vscode.env.clipboard.writeText('')
	await editor.edit((edit) => {
		const position = editor.selection.active
		const newRow = position.line + 1
		const newCol = editor.document.lineAt(newRow).text.length + 1
		const newPosition = position.with(newRow, newCol)
		edit.insert(position, text)
		const selection = new vscode.Selection(newPosition, newPosition)
		editor.selection = selection
		setTimeout(async () => {
			const range = new vscode.Range(newPosition, newPosition)
			editor.revealRange(range, vscode.TextEditorRevealType.InCenterIfOutsideViewport)
			// await editor.document.save()
		})
	})
}

function activate(context) {
	const taxonPasteCommand = vscode.commands.registerTextEditorCommand(
		'extension.taxonPaste',
		taxonPaste
	)
	const taxonFillEnNamesCommand = vscode.commands.registerTextEditorCommand(
		'extension.taxonFillEnNames',
		taxonFillEnNames
	)
	context.subscriptions.push(taxonFillEnNamesCommand, taxonPasteCommand)
}

module.exports = {
	activate
}
