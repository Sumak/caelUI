local F = select(1, unpack(select(2, ...)))

local databases = {}

function F.initialize_databases ()
    if not cael_user.databases then
        cael_user.databases = {}
    or
        databases = cael_user.databases
    end
end

function F.new_database (name)
    local self
    if not databases[name] then
        self = {}
        databases[name] = self
    else
        self = databases[name]
    end

    local function save ()
        databases[name] = self
        cael_user.databases = databases
    end

    return {save = save}
end

