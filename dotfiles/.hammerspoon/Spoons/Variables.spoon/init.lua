local obj = {}
obj.__index = obj

apps = {}
atom = 'com.github.atom'
chrome = 'com.google.Chrome'
discord = 'com.hnc.Discord'
finder = 'com.apple.finder'
iterm = 'com.googlecode.iterm2'
notion = 'notion.id'
postman = 'com.postmanlabs.mac'
preview = 'com.apple.Preview'
spotify = 'com.spotify.client'
sublime = 'com.sublimetext.4'
sublimeMerge = 'com.sublimemerge'
tableplus = 'com.tinyapp.TablePlus'
teams = 'com.microsoft.teams'
transmit = 'com.panic.Transmit'
invoker = 'de.beyondco.invoker'
slack = 'com.tinyspeck.slackmacgap'
vscode = 'com.microsoft.VSCode'
apps['atom'] = atom
apps['chrome'] = chrome
apps['finder'] = finder
apps['sublime'] = sublime
apps['iterm'] = iterm
apps['slack'] = slack
apps['discord'] = discord
apps['tableplus'] = tableplus
apps['sublimeMerge'] = sublimeMerge
apps['vscode'] = vscode

ultrawide = 'LG ULTRAWIDE'
macbookScreen = 'Color LCD'

log = hs.logger.new('ftw-log', 'debug')

return obj
