!function(){var e;async function t(t,n){var i,a,o,r,s,c,d,l,v,w,x=n=>{var a,o,c,d;o=(a=l.split(i))[0]-1,r=a[1],d=(d=(c=t.document.lineAt(o).text).indexOf(" #"))>=0?d+2:c.length,s=new e.Position(o,d),n.insert(s,r)};if(i="|DA84.&D-+7eDL2qr|",a=await e.env.clipboard.readText()){for(await e.env.clipboard.writeText(""),o=a.split(/\r?\n/),r=void 0,s=void 0,c=0,d=o.length;c<d;++c)(l=o[c]).includes(i)&&await t.edit(x);r&&(s=s.translate(0,r.length),v=new e.Selection(s,s),t.selection=v,w=new e.Range(s,s),t.revealRange(w,e.TextEditorRevealType.InCenter),await t.document.save())}}async function n(t,n){var i;(i=await e.env.clipboard.readText())&&(await e.env.clipboard.writeText(""),await t.edit((n=>{var a,o,r,s,c;o=(a=t.selection.active).line+1,r=t.document.lineAt(o).text.length+1,s=a.with(o,r),n.insert(a,i),c=new e.Selection(s,s),t.selection=c,setTimeout((async()=>{var n;n=new e.Range(s,s),t.revealRange(n,e.TextEditorRevealType.InCenterIfOutsideViewport),await t.document.save()}))})))}e=require("vscode"),module.exports={activate:function(i){var a,o;a=e.commands.registerTextEditorCommand("extension.taxonPaste",n),o=e.commands.registerTextEditorCommand("extension.taxonFillEnNames",t),i.subscriptions.push(o,a)}}}();