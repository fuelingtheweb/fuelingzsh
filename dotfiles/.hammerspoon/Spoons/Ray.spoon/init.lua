local Ray = {}
Ray.__index = Ray

Ray.updatedPath = 'PATH=/usr/local/bin:$PATH;'
Ray.command = '/Users/nathan/.composer/vendor/bin/ray'

function ray(value)
    if not value then
        return Ray
    end

    Ray.run(Ray.quote(value))
end

function Ray.newScreen(name)
    Ray.run('-s ' .. Ray.quote(name or ''))
end

function Ray.green(value)
    Ray.run('--green ' .. Ray.quote(value))
end

function Ray.red(value)
    Ray.run('--red ' .. Ray.quote(value))
end

function Ray.bgGray(value)
    Ray.run('--bg-green ' .. Ray.quote(value))
end

function Ray.bgRed(value)
    Ray.run('--bg-red ' .. Ray.quote(value))
end

function Ray.execute(command)
    Ray.newScreen('Artisan')
    hs.execute("open -a 'Ray.app'")
    hs.execute(Ray.updatedPath .. ' ' .. command .. ' | ' .. Ray.command .. ' --stdin --bg-gray')
end

function Ray.run(args)
    hs.execute(
        table.concat({Ray.updatedPath, Ray.command, args}, ' ')
    )
end

function Ray.quote(value)
    return '"' .. value .. '"'
end

return Ray
