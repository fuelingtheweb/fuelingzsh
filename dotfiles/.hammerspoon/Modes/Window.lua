local Window = {}
Window.__index = Window

Modal.load('Window')
Modal.load('Amethyst')

Window.lookup = {
    tab = cm.Window.moveToCenter,
    q = cm.Window.quitApplication,
    w = cm.Window.toggleCodeFocus,
    e = cm.Window.scrollScreenWithCursorAtEnd,
    r = cm.Window.scrollScreenWithCursorAtCenter,
    t = cm.Window.scrollScreenWithCursorAtTop,
    caps_lock = cm.Window.missionControl,
    a = cm.Media.toggleAudio,
    s = cm.Media.toggleScreenShare,
    d = cm.Window.moveToNextDisplay,
    f = cm.Window.maximize,
    g = hs.grid.toggleShow,
    left_shift = cm.Window.focusSidebarTodo,
    z = cm.Media.toggleAudioAndVideo,
    x = cm.Window.focusSidebarFileExplorer,
    c = cm.Window.focusSidebarSourceControl,
    v = cm.Media.toggleVideo,
    b = cm.Window.toggleSidebar,

    y = cm.Window.focusSidebar,
    u = cm.Window.topLeft,
    i = cm.Window.moveToMiddle,
    o = cm.Window.topRight,
    p = cm.Window.settings,
    open_bracket = cm.Window.toggleFloat,
    close_bracket = cm.Window.moveTotopRightSmall,
    h = cm.Window.leftHalf,
    j = cm.Window.bottomHalf,
    k = cm.Window.topHalf,
    l = cm.Window.rightHalf,
    semicolon = cm.Window.moveMouseToOtherScreen,
    quote = cm.Window.windowModal,
    return_or_enter = cm.Window.reset,
    n = cm.Window.bottomLeft,
    m = cm.Window.focusActiveEditor,
    comma = cm.Window.bottomRight,
    period = cm.Window.amethystModal,
    slash = nil,
    right_shift = nil,
}

return Window
