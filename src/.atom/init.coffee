# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

atom.commands.add 'atom-text-editor.vim-mode-plus', 'custom:scroll-left-4', ->
  view = atom.views.getView atom.workspace.getActiveTextEditor()
  atom.commands.dispatch view, 'vim-mode-plus:set-count-4'
  atom.commands.dispatch view, 'vim-mode-plus:move-left'

atom.commands.add 'atom-text-editor.vim-mode-plus', 'custom:scroll-down-4', ->
  view = atom.views.getView atom.workspace.getActiveTextEditor()
  atom.commands.dispatch view, 'vim-mode-plus:set-count-4'
  atom.commands.dispatch view, 'vim-mode-plus:mini-scroll-down'
  atom.commands.dispatch view, 'vim-mode-plus:set-count-4'
  atom.commands.dispatch view, 'vim-mode-plus:move-down'

atom.commands.add 'atom-text-editor.vim-mode-plus', 'custom:scroll-up-4', ->
  view = atom.views.getView atom.workspace.getActiveTextEditor()
  atom.commands.dispatch view, 'vim-mode-plus:set-count-4'
  atom.commands.dispatch view, 'vim-mode-plus:mini-scroll-up'
  atom.commands.dispatch view, 'vim-mode-plus:set-count-4'
  atom.commands.dispatch view, 'vim-mode-plus:move-up'

atom.commands.add 'atom-text-editor.vim-mode-plus', 'custom:scroll-right-4', ->
  view = atom.views.getView atom.workspace.getActiveTextEditor()
  atom.commands.dispatch view, 'vim-mode-plus:set-count-4'
  atom.commands.dispatch view, 'vim-mode-plus:move-right'
