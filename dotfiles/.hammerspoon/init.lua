hs.hotkey.alertDuration = 0

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
    Chrome = require('Apps.Chrome'),
    Code = require('Apps.Code'),
    Discord = require('Apps.Discord'),
    iTerm = require('Apps.iTerm'),
    Slack = require('Apps.Slack'),
    TablePlus = require('Apps.TablePlus'),
}

fn.each = fn.table.each
is = fn.is
str = fn.str

cm = {
    Artisan = require('Commands.Artisan'),
    Code = require('Commands.Code'),
    Media = require('Commands.Media'),
    Search = require('Commands.Search'),
    Tab = require('Commands.Tab'),
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

Modal.load('MiscSnippets')

hs.loadSpoon('Keystroke')
hs.loadSpoon('Misc')
hs.loadSpoon('KarabinerHandler')

Modal.load('Cheatsheets')
