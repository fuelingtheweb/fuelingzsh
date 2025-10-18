AlfredCommands
    :add('toggle-hidden-files', 'Toggle Hidden Files', 'files.png', function()
        if is.finder() then
            ks.shiftCmd('.')
        else
            local output = fn.misc.executeFromAnvil('toggle-hidden-files.sh')

            hs.notify
                .new({title = 'Hidden Files Toggled', informativeText = output}):send()
        end
    end)
    :add('units', 'Convert Units', 'units.png',
         function() fn.Alfred.run('units', 'thijsdejong.alfred.units.1.1') end)
    :add('lorem-ipsum', 'Lorem Ipsum', 'lorem-ipsum.png', function()
        fn.Alfred.run('lorem-ipsum', 'com.tillkruss.loremipsum')
    end)
