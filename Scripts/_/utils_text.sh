#!/usr/bin/env bash


#
# Variables of corlors
# -----------------------------------------

# Text styles

RESET=$'\e[0m'

TXT_BOLD=$'\e[1m'
TXT_DIM=$'\e[2m'
TXT_UNDERLINE=$'\e[4m'
TXT_BLINK=$'\e[5m'
TXT_REVERSE=$'\e[7m'
TXT_HIDDEN=$'\e[8m'

# Colors

TXT_UN_BOLD=$'\e[21m'
TXT_UN_DIM=$'\e[22m'
TXT_UN_UNDERLINE=$'\e[24m'
TXT_UN_BLINK=$'\e[25m'
TXT_UN_REVERSE=$'\e[27m'
TXT_UN_HIDDEN=$'\e[28m'

FG_DEFAULT=$'\e[39m'
FG_BLACK=$'\e[30m'
FG_RED=$'\e[31m'
FG_GREEN=$'\e[32m'
FG_YELLOW=$'\e[33m'
FG_BLUE=$'\e[34m'
FG_MAGENTA=$'\e[35m'
FG_CYAN=$'\e[36m'

FG_LGRAY=$'\e[37m'
FG_GRAY=$'\e[90m'
FG_LRED=$'\e[91m'
FG_LGREEN=$'\e[92m'
FG_LYELLOW=$'\e[93m'
FG_LBLUE=$'\e[94m'
FG_LMAGENTA=$'\e[95m'
FG_LCYAN=$'\e[96m'

FG_WHITE=$'\e[97m'



BG_DEFAULT=$'\e[49m'
BG_BLACK=$'\e[40m'
BG_RED=$'\e[41m'
BG_GREEN=$'\e[42m'
BG_YELLOW=$'\e[43m'
BG_BLUE=$'\e[44m'
BG_MAGENTA=$'\e[45m'
BG_CYAN=$'\e[46m'
BG_LGRAY=$'\e[47m'
BG_DARK_GRAY=$'\e[100m'
BG_LRED=$'\e[101m'
BG_LGREEN=$'\e[102m'
BG_LYELLOW=$'\e[103m'
BG_LBLUE=$'\e[104m'
BG_LMAGENTA=$'\e[105m'
BG_LCYAN=$'\e[106m'
BG_WHITE=$'\e[107m'

# Symbols

ICON_HEAVY_CHECK="\xE2\x9C\x94"
ICON_BEER_MUG="\xF0\x9F\x8D\xBA"
ICON_BEER_CLICKING="\xF0\x9F\x8D\xBB"
ICON_PARTY_POPPER="\xF0\x9F\x8E\x89"
ICON_THUMBS_UP="\xF0\x9F\x91\x8D"
ICON_THUMBS_DOWN="\xF0\x9F\x91\x8E"
ICON_EYES="\xF0\x9F\x91\x80"
ICON_SPARKLES="\xE2\x9C\xA8"
ICON_EMOJI_SCREAMING="\xf0\x9f\x98\xb1"
ICON_EMOJI_ROLLING="\xf0\x9f\xa4\xa3"
ICON_EMOJI_THINKING="\xf0\x9f\xa4\x94"
ICON_EMOJI_KISS="\xf0\x9f\x98\x98"
ICON_EMOJI_CRAZY_FACE="\xf0\x9f\xa4\xaa"
ICON_EMOJI_DISAPPOINTED_FACE="\xf0\x9f\x98\xa5"
