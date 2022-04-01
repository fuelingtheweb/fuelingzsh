hs.hotkey.alertDuration = 0

hs.loadSpoon('Functions')

fn = {
    app = require('Helpers.App'),
    is = require('Helpers.Is'),
    Alfred = require('Apps.Alfred'),
    Atom = require('Apps.Atom'),
    Chrome = require('Apps.Chrome'),
    Code = require('Apps.Code'),
    Discord = require('Apps.Discord'),
    iTerm = require('Apps.iTerm'),
    Notion = require('Apps.Notion'),
    Slack = require('Apps.Slack'),
    Sublime = require('Apps.Sublime'),
    TablePlus = require('Apps.TablePlus'),
}

is = fn.is

cm = {
    Media = require('Commands.Media'),
    Window = require('Commands.Window'),
}

fn.app.loadBundleVariables()

hs.loadSpoon('Watchers')

Ray = hs.loadSpoon('Ray')
Pending = hs.loadSpoon('Pending')
Modal = hs.loadSpoon('Modal')
TextManipulation = hs.loadSpoon('TextManipulation')
Artisan = hs.loadSpoon('Artisan')
Brackets = hs.loadSpoon('Brackets')

hs.loadSpoon('Keystroke')
hs.loadSpoon('Search')
hs.loadSpoon('Misc')
hs.loadSpoon('KarabinerHandler')

Modal.load('Cheatsheets')
