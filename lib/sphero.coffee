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
    activeEditor = atom.workspace.getActiveTextEditor()
    code = activeEditor.getText()
    code = code.replace "\n", "\r"

    sphero = require 'sphero'
    orb = sphero("/dev/tty.Sphero-WRP-AMP-SPP")
    console.log "Connecting to Sphero..."
    orb.connect(->
      console.log "Connected to Sphero!"
      orb.eraseOrbBasicStorage(0x00, (err, data) ->
        if err
          console.log "There was a problem erasing OrbBasic Storage. Error:\n#{err}";
        else
          if data.MRSP == 0x00
            console.log "Deleted local Orb Basic Storage"
          else
            console.log "There was a problem erasing OrbBasic Storage. Packet:\n#{data}"
        )
      )
