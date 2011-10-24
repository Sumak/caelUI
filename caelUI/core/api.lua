local private, moedules, public = unpack(select(2, ...))

-- Allow external addons to have access to the media database.
public.media = private.database.get("media")

-- Allow exteranl addons to have access to the config database.
public.config = private.database.get("config")

-- Allow the usage of specific functions from our private API interface.
public.UTF8_substitution = private.UTF8_substitution
public.get_spell_name = private.get_spell_name

-- XXX: This will go away when slashCommands comes into caelUI.
public.is_guild_group = private.is_guild_group

-- XXX: This will change once we build an external Addon interface to the UI. It will pass
--      back a frame at creation doing everything that is in this function and more.
public.create_backdrop = private.database.get("panels").create_backdrop
