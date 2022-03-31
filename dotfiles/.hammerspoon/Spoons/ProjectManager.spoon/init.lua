local ProjectManager = {}
ProjectManager.__index = ProjectManager
ProjectManager.sites = {}

local Site = {}

function Site:new()
    o = {attributes = {}}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Site:name(name, project)
    o = {
        attributes = {
            name = name,
            path = project.attributes.path .. '/' .. name
        }
    }
    setmetatable(o, self)
    self.__index = self

    table.insert(ProjectManager.sites, o)

    return o
end

function Site:path(path)
    self.attributes.path = 'Development/' .. path

    return self
end

function Site:log()
    log.d('Logging Site: ', self.attributes.path)

    return self
end

function Site:url(url)
    self.attributes.url = url

    return self
end

function Site:serve(serve)
    self.attributes.serve = serve

    return self
end

function Site:database(database)
    self.attributes.database = database

    return self
end

function Site:shortcut(key, mapping)
    Shortcuts:add(key, mapping)
    self.attributes.shortcutKey = key

    return self
end

local Project = {}

function Project:name(name, client)
    o = {}
    setmetatable(o, self)
    self.__index = self

    self.attributes = {
        name = name,
        path = client.attributes.path .. '/' .. name
    }

    return o
end

function Project:site(name)
    return Site:name(name, self)
end

function Project:addSite(name, callback)
    callback(self:site(name))

    return self
end

local Client = {}

function Client:name(name)
    o = {}
    setmetatable(o, self)
    self.__index = self

    self.attributes = {name = name, path = 'Development/' .. name}

    return o
end

function Client:shortcut(key, mapping)
    Shortcuts:add(key, mapping)

    return self
end

function Client:project(name)
    return Project:name(name, self)
end

function Client:addProject(name, callback)
    callback(self:project(name))

    return self
end

ProjectManager.Client = Client

function ProjectManager:setAlfredJson()
    local items = {}

    each(ProjectManager.sites, function(site)
        local fullPath = '~/' .. site.attributes.path
        table.insert(items, {
            uid = site.attributes.path:gsub('/', '.'),
            title = site.attributes.path:gsub('Development/', ''):gsub('/', ' > '):gsub('-', ' '),
            subtitle = fullPath,
            arg = site.attributes.path,
            autocomplete = site.attributes.path:gsub('/', ' > '),
            text = {copy = fullPath, largetype = fullPath},
            mods = {
                cmd = {
                    valid = true,
                    arg = site.attributes.path,
                    subtitle = site.attributes.url
                }
            },
        })
    end)

    hs.json.write({items = items}, '/Users/nathan/.fuelingzsh/custom/projects.json', false, true)
end

function ProjectManager.current()
    current = nil

    each(ProjectManager.sites, function(site)
        if titleContains(site.attributes.path) then
            current = site
        end
    end)

    if current then
        return current
    end

    return {attributes = {}}
end

function ProjectManager.openUrlForCurrent()
    site = ProjectManager.current()

    if site.attributes.url then
        return fn.Chrome.open(site.attributes.url)
    end
end

function ProjectManager.serveCurrent()
    site = ProjectManager.current()

    if site.attributes.serve then
        return ks.type(site.attributes.serve).enter()
    end
end

function ProjectManager.openDatabaseForCurrent()
    site = ProjectManager.current()

    if site.attributes.name then
        if site.attributes.database then
            if type(site.attributes.database) == 'table' then
                name = site.attributes.path:gsub('Development/', '')
                openInTablePlus('mysql://root@127.0.0.1/' .. site.attributes.database.name .. '?statusColor=686B6F&enviroment=local&name=' .. name)
            else
                openInTablePlus(site.attributes.database)
            end
        else
            database = site.attributes.path:gsub('Development/', ''):gsub('/', '_'):lower()
            name = site.attributes.path:gsub('Development/', '')
            openInTablePlus('mysql://root@127.0.0.1/' .. database .. '?statusColor=686B6F&enviroment=local&name=' .. name)
        end

        return true
    end
end

function ProjectManager.getByShortPath(path)
    site = ProjectManager.getByPath('Development/' .. path)

    return site.attributes.path and site or Site:new()
end

function ProjectManager.getByPath(path)
    site = nil
    each(ProjectManager.sites, function(s)
        if s.attributes.path == path then
            site = s
        end
    end)

    if site then
        return site
    end

    return {attributes = {}}
end

function ProjectManager.getByShortcutKey(key)
    site = nil
    each(ProjectManager.sites, function(s)
        if s.attributes.shortcutKey == key then
            site = s
        end
    end)

    if site then
        return site
    end

    return {attributes = {}}
end

function Site:open()
    if self.attributes.path then
        fn.Atom.open('~/' .. self.attributes.path)
        fn.Chrome.open(self.attributes.url)
        fn.iTerm.open('/Users/nathan/' .. self.attributes.path)
    end
end

function Site:openInAtom()
    if self.attributes.path then
        fn.Atom.open('~/' .. self.attributes.path)
    end
end

function Site:openInCode()
    if self.attributes.path then
        fn.Code.open('~/' .. self.attributes.path)
    end
end

function Site:openInChrome()
    if self.attributes.path then
        fn.Chrome.open(self.attributes.url)
    end
end

function ProjectManager:addFromConfig()
    require('config.custom.projects')
end

return ProjectManager
