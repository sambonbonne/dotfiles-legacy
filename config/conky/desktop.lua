conky.config = {
  alignment = 'top_right',
  background = false,
  border_width = 0,
  cpu_avg_samples = 2,
  default_bar_height = 6,
  default_color = 'CFD8DC',
  default_outline_color = 'CFD8DC',
  default_shade_color = 'white',
  draw_borders = false,
  draw_graph_borders = true,
  draw_outline = false,
  draw_shades = false,
  use_xft = true,
  font = 'Gidole:size=14',
  gap_x = 5,
  gap_y = 60,
  minimum_height = 5,
  minimum_width = 400,
  net_avg_samples = 2,
  no_buffers = true,
  out_to_console = false,
  out_to_stderr = false,
  out_to_x = true,
  extra_newline = false,
  own_window = true,
  own_window_class = 'Conky',
  own_window_title = 'conky-desktop',
  own_window_type = 'desktop',
  own_window_transparent = true,
  stippled_borders = 0,
  update_interval = 1.0,
  uppercase = false,
  use_spacer = 'none',
  show_graph_scale = false,
  show_graph_range = false,
  color0 = '90A4AE', -- grey
  color1 = '82B1FF', -- blue
  color2 = 'B9F6CA', -- green
  color3 = 'FFFF8D', -- yellow
  color4 = 'FF8A80'  -- red
}

conky.text = [[
${voffset 5}$color0${font Gidole:size=42}${time %H}$color\
${font Gidole:size=8} \
${offset -6}${voffset -54}${font Gidole:size=58}${time %M}$font\
$alignr${voffset -30}${font Gidole:size=18}${time %A %d %B}$font
$alignr${font Gidole:size=16}${time %V %Y}$font

${voffset 10}$uptime_short$alignr\
${if_existing /sys/class/power_supply/ADP0/online 1}${color3}${endif}\
$battery_time$color
${if_match ${battery_percent} >= 85}${color2}${endif}\
${if_match ${battery_percent} <= 15}${color4}${endif}\
${battery_bar}$color${voffset 25}
${color0}CPU$alignr$color${font Hack:size=12}$loadavg$font
${cpubar}${voffset 5}
${color0}RAM$alignr$color${font Hack:size=12}$mem/$memmax$font
${membar}${voffset 5}
${color0}Swap$alignr$color${font Hack:size=12}$swap/$swapmax$font
${swapbar}${voffset 5}
${color0}/$alignr$color${font Hack:size=12}${fs_used /}/${fs_size /}$font
${fs_bar /}${voffset 5}
${color0}Net$alignr$color${font Hack:size=12}↑ $color${upspeed wlan0} $color0↓ $color${downspeed wlan0}
]]
