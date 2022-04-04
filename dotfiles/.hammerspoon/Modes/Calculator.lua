local Calculator = {}
Calculator.__index = Calculator

Calculator.lookup = {
    y = '*',
    u = '1',
    i = '2',
    o = '3',
    p = '%',
    open_bracket = ks.delete,
    close_bracket = '100',
    h = '+',
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
    right_shift = nil,
    spacebar = '.',
}

function Calculator.fallback(value)
    ks.type(value)
end

return Calculator
