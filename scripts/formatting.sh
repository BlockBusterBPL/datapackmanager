#!/bin/bash
# Not Done Yet!
# Formatting Utilities By BlockBusterBPL
# Use these variables in place of complicated ANSI formatting codes.
# Usage: run this script from your .bash_profile to set these environment variables
# Echo commands must have '-e' argument for this to work. e.g. 'echo -e "${color_red}This Text Is Red!"'
# Remember Dialog Command from invisible island

#BEGIN FONT STYLE SECTION#
export font_bold
export font_dim
export font_under
export font_blink
export font_invert
export font_hide
#FONT STYLE RESET
export font_reset
export font_bold_end
export font_dim_end
export font_under_end
export font_blink_end
export font_invert_end
export font_hide_end
#END FONT STYLE SECTION

#BEGIN COLOR SECTION#
export color_default="\e[39m"
export color_black="\e[30m"
export color_red="\e[31m"
export color_green="\e[32m"
export color_yellow="\e[33m"
export color_blue="\e[33m"
export color_magenta
export color_cyan
export color_lightgray
export color_darkgray
export color_lightred
export color_lightgreen
export color_lightyellow
export color_lightblue
export color_lightmagenta
export color_lightcyan
export color_white
#END COLOR SECTION#
