return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 25,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 6,
  nextobjectid = 17,
  backgroundcolor = { 14, 0, 29 },
  properties = {
    ["music"] = "resonance_muffled",
    ["use_footstep_sounds"] = true
  },
  tilesets = {
    {
      name = "vapor",
      firstgid = 1,
      filename = "../../tilesets/vapor.tsx",
      exportfilename = "../../tilesets/vapor.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 25,
      id = 1,
      name = "Tile Layer 1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 4, 5, 5, 5, 5, 5, 5, 6, 0, 0, 0, 0,
        0, 0, 0, 4, 7, 12, 12, 12, 12, 12, 12, 8, 6, 0, 0, 0,
        0, 0, 0, 14, 12, 12, 12, 12, 12, 12, 12, 12, 16, 0, 0, 0,
        0, 0, 0, 14, 12, 12, 12, 12, 12, 12, 12, 12, 16, 0, 0, 0,
        0, 0, 0, 14, 12, 12, 12, 12, 12, 12, 12, 12, 16, 0, 0, 0,
        0, 0, 0, 14, 12, 12, 12, 12, 12, 12, 12, 12, 16, 0, 0, 0,
        0, 0, 0, 24, 17, 12, 12, 12, 12, 12, 12, 18, 26, 0, 0, 0,
        0, 0, 0, 44, 47, 17, 31, 31, 31, 31, 18, 48, 46, 0, 0, 0,
        0, 0, 0, 0, 44, 37, 31, 31, 31, 31, 38, 46, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 14, 31, 31, 31, 31, 16, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 14, 31, 31, 31, 31, 16, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 14, 31, 31, 31, 31, 16, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 14, 31, 31, 31, 31, 16, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 14, 31, 31, 31, 31, 16, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 14, 31, 31, 31, 31, 16, 0, 0, 0, 0, 0,
        0, 0, 4, 5, 5, 7, 31, 31, 31, 31, 8, 5, 5, 5, 5, 5,
        0, 0, 14, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
        0, 0, 14, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
        0, 0, 14, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22,
        0, 0, 24, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        0, 0, 34, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35,
        0, 0, 34, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "collision",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 160,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 160,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 120,
          width = 240,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 200,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 200,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 400,
          width = 120,
          height = 360,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 400,
          width = 240,
          height = 360,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 760,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 880,
          width = 520,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 13,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 760,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "intro/crossroads",
            ["marker"] = "left"
          }
        },
        {
          id = 15,
          name = "chest",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "synthsoda"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "markers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 14,
          name = "right",
          type = "",
          shape = "point",
          x = 600,
          y = 840,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "controllers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 16,
          name = "worldshader",
          type = "",
          shape = "point",
          x = 10,
          y = 20,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["shader"] = "ntsc"
          }
        }
      }
    }
  }
}
