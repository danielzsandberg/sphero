SpheroView = require './sphero-view'
{CompositeDisposable} = require 'atom'

module.exports = Sphero =
  spheroView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @spheroView = new SpheroView(state.spheroViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @spheroView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'sphero:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @spheroView.destroy()

  serialize: ->
    spheroViewState: @spheroView.serialize()

  toggle: ->
    console.log 'Sphero was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
