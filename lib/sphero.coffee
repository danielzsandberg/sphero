{CompositeDisposable} = require 'atom'
apd = require 'atom-package-dependencies'


module.exports = Sphero =
  subscriptions: null

  activate: (state) ->
    apd.install()

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'sphero:uploadAndExecute': => @uploadAndExecute()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
    spheroViewState: @spheroView.serialize()

  uploadAndExecute: ->
    console.log 'Sphero was toggled!'
