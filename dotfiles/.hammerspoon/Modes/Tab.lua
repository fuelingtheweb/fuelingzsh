local Tab = {}
Tab.__index = Tab

Tab.lookup = {
    y = nil,
    u = nil,
    i = cm.Tab.first,
    o = cm.Tab.last,
    p = cm.Tab.pin,
    open_bracket = cm.Tab.closeAllToLeft,
    close_bracket = cm.Tab.closeAllToRight,
    h = cm.Tab.moveLeft,
    j = cm.Tab.previous,
    k = cm.Tab.next,
    l = cm.Tab.moveRight,
    semicolon = cm.Tab.moveToNextWindow,
    quote = cm.Tab.moveToNewWindow,
    return_or_enter = cm.Tab.restore,
    n = cm.Tab.new,
    m = cm.Tab.closeCurrent,
    comma = cm.Tab.closePrevious,
    period = cm.Tab.closeNext,
    slash = cm.Tab.closeAllOthers,
    right_shift = cm.Tab.closeAll,
    spacebar = cm.Tab.manage,
}

return Tab
