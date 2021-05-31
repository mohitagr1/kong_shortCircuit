local typedefs = require "kong.db.schema.typedefs"

-- Grab pluginname from module name
local plugin_name = ({...})[1]:match("^kong%.plugins%.([^%.]+)")


local string_array_record = {
  type = "array",
  default = {},
  elements = {
    type = "string",
  }
}

local integer_http_status_code = {
  type = "integer",
  default = 200,
  between = {
    100,
    599
  }
}


local schema = {
  name = plugin_name,
  fields = {
    -- the 'fields' array is the top-level entry with fields defined by Kong
    { consumer = typedefs.no_consumer },  -- this plugin cannot be configured on a consumer (typical for auth plugins)
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { api_exceptions = string_array_record },
          { http_status_code = integer_http_status_code },
        },
        entity_checks = {
        },
      },
    },
  },
}

return schema
