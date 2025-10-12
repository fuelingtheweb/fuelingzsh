hs.hotkey.alertDuration = 0

home_path = os.getenv('HOME')

-- test
Modal = hs.loadSpoon('Modal')

fn = {
    app = require('Helpers.App'),
    clipboard = require('Helpers.Clipboard'),
    custom = require('config.custom.Helpers.Custom'),
    is = require('Helpers.Is'),
    misc = require('Helpers.Misc.Index'),
    str = require('Helpers.String'),
    table = require('Helpers.Table'),
    window = require('Helpers.Window'),
    Alfred = require('Apps.Alfred'),
    Arc = require('Apps.Arc'),
    Vivaldi = require('Apps.Vivaldi'),
    Brave = require('Apps.Brave'),
    Chrome = require('Apps.Chrome'),
    Code = require('Apps.Code'),
    Discord = require('Apps.Discord'),
    iTerm = require('Apps.iTerm'),
    Raycast = require('Apps.Raycast'),
    SideNotes = require('Apps.SideNotes'),
    Slack = require('Apps.Slack'),
    TablePlus = require('Apps.TablePlus'),
}

fn.each = fn.table.each
fn.open = fn.misc.open
is = fn.is
str = fn.str

cm = {
    Artisan = require('Commands.Artisan'),
    Media = require('Commands.Media'),
    Search = require('Commands.Search'),
    ViVisual = require('Commands.ViVisual'),
    Window = require('Commands.Window'),
}

fn.app.loadBundleVariables()

hs.loadSpoon('Watchers')

Ray = hs.loadSpoon('Ray')
Pending = hs.loadSpoon('Pending')
TextManipulation = hs.loadSpoon('TextManipulation')
Brackets = hs.loadSpoon('Brackets')

ToBracket = Modal.load('ToBracket')
ArcModal = Modal.load('Arc')

Modal.load('MiscSnippets')

hs.loadSpoon('Keystroke')
hs.loadSpoon('Misc')
hs.loadSpoon('KarabinerHandler')
