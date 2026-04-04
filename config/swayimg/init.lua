-- Example config for Swayimg.
-- This file contains the default configuration used by the application.

-- The viewer searches for the config file in the following locations:
-- 1. $XDG_CONFIG_HOME/swayimg/init.lua
-- 2. $HOME/.config/swayimg/init.lua
-- 3. $XDG_CONFIG_DIRS/swayimg/init.lua
-- 4. /etc/xdg/swayimg/init.lua

-- General config
swayimg.set_mode("viewer")                -- mode at startup
swayimg.enable_antialiasing(false)         -- anti-aliasing
swayimg.enable_decoration(false)           -- window title/buttons/borders
swayimg.enable_overlay(false)             -- window overlay mode
swayimg.enable_exif_orientation(true)     -- image orientation by EXIF
swayimg.set_dnd_button("MouseRight")      -- drag-and-drop mouse button

-- Image list configuration
swayimg.imagelist.set_order("numeric")    -- list order
swayimg.imagelist.enable_reverse(false)   -- reverse order
swayimg.imagelist.enable_recursive(false) -- recursive directory reading
swayimg.imagelist.enable_adjacent(true)  -- add adjacent files from same dir
swayimg.imagelist.enable_fsmon(true)      -- enable file system monitoring

-- Text overlay configuration
swayimg.text.set_font("Departure Mono")        -- font name
swayimg.text.set_size(16)                 -- font size in pixels
swayimg.text.set_spacing(0)               -- line spacing
swayimg.text.set_padding(3)              -- padding from window edge
swayimg.text.set_foreground(0xffa7c080)   -- foreground text color
swayimg.text.set_background(0x00000000)   -- text background color
swayimg.text.set_shadow(0x0d000000)       -- text shadow color
swayimg.text.set_timeout(0)               -- layer hide timeout
swayimg.text.set_status_timeout(2)        -- status message hide timeout

-- Image viewer mode
swayimg.viewer.set_default_scale("fit")      -- default image scale
swayimg.viewer.set_default_position("center")    -- default image position
swayimg.viewer.set_drag_button("MouseLeft")      -- mouse button to drag image
swayimg.viewer.set_window_background(0x77000000) -- window background color
swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c) -- chessboard
swayimg.viewer.enable_centering(true)            -- enable automatic centering
swayimg.viewer.enable_loop(true)                 -- enable image list loop mode
swayimg.viewer.limit_preload(1)                  -- number of images to preload
swayimg.viewer.limit_history(1)                  -- number of the history cache
swayimg.viewer.set_mark_color(0xff808080)        -- mark icon color
swayimg.viewer.set_text("topleft", {             -- top left text block scheme
  "{name}"
})
swayimg.viewer.set_text("topright", {            -- top right text block scheme
    "{scale}",
    "{list.index} of {list.total}"
})
swayimg.viewer.set_text("bottomleft", {          -- bottom left text block scheme
})

-- Key and mouse bindings in viewer mode (example only, not all):

-- bind Escape key for exit
swayimg.viewer.on_key("Escape", function()
  swayimg.exit()
end)

-- bind mouse vertical scroll button with pressed Ctrl to zoom in the image at mouse pointer coordinates
swayimg.viewer.on_mouse("ScrollUp", function()
  local pos = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.get_scale()
  scale = scale + scale / 10
  swayimg.viewer.set_abs_scale(scale, pos.x, pos.y);
end)
swayimg.viewer.on_mouse("ScrollDown", function()
  local pos = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.get_scale()
  scale = scale - scale / 10
  swayimg.viewer.set_abs_scale(scale, pos.x, pos.y);
end)

swayimg.viewer.on_mouse("Ctrl-ScrollUp", function()
  local pos = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.get_scale()
  scale = scale + scale / 100
  swayimg.viewer.set_abs_scale(scale, pos.x, pos.y);
end)
swayimg.viewer.on_mouse("Ctrl-ScrollDown", function()
  local pos = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.get_scale()
  scale = scale - scale / 100
  swayimg.viewer.set_abs_scale(scale, pos.x, pos.y);
end)

swayimg.viewer.on_key("a", function()
    swayimg.viewer.switch_image("prev")
    swayimg.viewer.set_fix_scale("fit")
end)

swayimg.viewer.on_key("d", function()
    swayimg.viewer.switch_image("next")
    swayimg.viewer.set_fix_scale("fit")
end)

swayimg.viewer.on_key("s", function()
    swayimg.viewer.set_fix_scale("fit")
end)

swayimg.viewer.on_key("w", function()
    antialiasing_enabled = not antialiasing_enabled
    swayimg.enable_antialiasing(antialiasing_enabled)
    if antialiasing_enabled then -- IF ELSE IF ELSE IF ELSE IF ELSE IF ELSE IF ELSE IF ELSE IF ELSE 
        swayimg.text.set_status("aa: enabled")
    else
        swayimg.text.set_status("aa: disabled")
    end
end)

-- Slide show mode, same config as for viewer mode with the following defaults:
swayimg.slideshow.set_timeout(5)                    -- timeout to switch image
swayimg.slideshow.set_default_scale("fit")          -- default image scale
swayimg.slideshow.set_window_background("auto")     -- window background mode
swayimg.slideshow.limit_history(0)                  -- number of the history cache
swayimg.slideshow.set_text("topleft", { "{name}" }) -- top left text block scheme


-- Gallery mode
swayimg.gallery.set_aspect("fill")                  -- thumbnail aspect ratio
swayimg.gallery.set_thumb_size(200)                 -- thumbnail size in pixels
swayimg.gallery.set_padding_size(5)                 -- padding between thumbnails
swayimg.gallery.set_border_size(5)                  -- border size for selected thumbnail
swayimg.gallery.set_border_color(0xffaaaaaa)        -- border color for selected thumbnail
swayimg.gallery.set_selected_scale(1.15)            -- scale for selected thumbnail
swayimg.gallery.set_selected_color(0xff404040)      -- background color for selected thumbnail
swayimg.gallery.set_unselected_color(0xff202020)    -- background color for unselected thumbnail
swayimg.gallery.set_window_color(0xff000000)        -- window background color
swayimg.gallery.limit_cache(100)                    -- number of thumbnails stored in memory
swayimg.gallery.enable_preload(false)               -- preloading invisible thumbnails
swayimg.gallery.enable_pstore(false)                -- enable persistent storage for thumbnails
swayimg.gallery.set_text("topleft", {               -- top left text block scheme
  "File: {name}"
})
swayimg.gallery.set_text("topright", {              -- top right text block scheme
  "{list.index} of {list.total}"
})

-- Key and mouse bindings in gallery mode (example only, not all):

-- bind Enter key to open image in viewer
swayimg.gallery.on_key("Return", function()
  swayimg.set_mode("viewer")
end)
-- bind the left arrow key to select thumbnail on the left side
swayimg.gallery.on_key("Left", function()
  swayimg.gallery.switch_image("left")
end)

--
-- Other configuration examples
--

-- force set scale mode on window resize (useful for tiling compositors)
swayimg.on_window_resize(function()
  swayimg.viewer.set_fix_scale("optimal")
end)

-- bind the Delete key in slide show mode to delete the current file and display a status message
swayimg.slideshow.on_key("Delete", function()
  local image = swayimg.slideshow.get_image()
  os.remove(image.path)
  swayimg.text.set_status("File "..image.path.." removed")
end)

-- set a custom window title in gallery mode
swayimg.gallery.on_image_change(function()
  local image = swayimg.gallery.get_image()
  swayimg.set_title("Gallery: "..image.path)
end)

-- print paths to all marked files by pressing Ctrl-p in gallery mode
swayimg.gallery.on_key("Ctrl-p", function()
  local entries = swayimg.imagelist.get()
  for _, entry in ipairs(entries) do
    if entry.mark then
        print(entry.path)
    end
  end
end)
