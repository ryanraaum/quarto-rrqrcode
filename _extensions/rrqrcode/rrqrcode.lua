
local function make_table(nbits, pixel_size)
  local mt = {}
  for i=1,nbits*pixel_size do
    mt[i] = {}
    for j=1,nbits*pixel_size do
      mt[i][j] = 0
    end
  end
  mt.nbits = nbits
  mt.pixel_size = pixel_size
  return mt
end

local function color_pixel(mt, x, y, value)
  local imin = (x-1)*mt.pixel_size+1
  local imax = x*mt.pixel_size
  local jmin = (y-1)*mt.pixel_size+1
  local jmax = y*mt.pixel_size
  for i=imin,imax do
    for j=jmin,jmax do     
        mt[i][j] = value
    end
  end
end

local function scale(original, pixel_size, rounded)
  local newtable = make_table(#original, pixel_size)
  for i=1,#original do
    for j=1,#original do
      if original[i][j] > 0 then
        color_pixel(newtable, i, j, original[i][j])
      end
    end
  end
  return newtable
end

local function qrimg(str)
  local pngencode = require "pngencoder"
  local qrencode = require "qrencode"
  local res, qrtab = qrencode.qrcode(str)
  qrtab = scale(qrtab, 5)
  local pngtab = pngencode(#qrtab, #qrtab, "rgba")
  local bgcolor = {255, 255, 255, 0}
  local fgcolor = {0, 0, 0, 255}
  local dotcolor = {0, 0, 0, 255}
  for x=1,#qrtab do
    for y=1,#qrtab do
        local pixel = bgcolor
        if qrtab[x][y] > 2 then pixel = dotcolor 
        elseif qrtab[x][y] > 0 then pixel = fgcolor end 
        pngtab:write(pixel)
    end
  end
  local pngdata = pngtab.output
  local img_data = table.concat(pngdata)
  local img_name = "testpng.png"
  pandoc.mediabag.insert(img_name, "image/png", img_data)
  return true, img_name
end

return {
  ['rrqr'] = function(args, kwargs, meta) 
    local qrtext = pandoc.utils.stringify(args[1])
    local res, img_name = qrimg(qrtext)
    if res then
      local attr = pandoc.Attr("", {"qrcode"}, {{"width",200}})
      return pandoc.Image({}, img_name, "title", attr)  
    else
      quarto.log.error("Could not create qrcode")
      return pandoc.Null()
    end
  end
}
