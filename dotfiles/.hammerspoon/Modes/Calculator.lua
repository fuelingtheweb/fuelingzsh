local Calculator = {}
Calculator.__index = Calculator

Calculator.lookup = {
    b = ',',

    y = ks.build('shift', '8'), -- *
    u = '1',
    i = '2',
    o = '3',
    p = ks.build('shift', '5'), -- %
    open_bracket = ks.delete,
    close_bracket = ks.build('shift', ';'), -- :
    h = ks.build('shift', '='), -- +
    j = '4',
    k = '5',
    l = '6',
    semicolon = '0',
    quote = '=',
    return_or_enter = ks.enter,
    n = '-',
    m = '7',
    comma = '8',
    period = '9',
    slash = '/',
    right_shift = ks.tab,
    spacebar = '.',
}

function Calculator.fallback(value)
    ks.key(value)
end

return Calculator
