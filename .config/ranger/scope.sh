#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | Display stdout as preview
# 1    | no preview | Display no preview at all
# 2    | plain text | Display the plain content of the file
# 3    | fix width  | Don't reload when width changes
# 4    | fix height | Don't reload when height changes
# 5    | fix both   | Don't ever reload
# 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
# 7    | image      | Display the file directly as an image

FILE_PATH="${1}"         # Full path of the highlighted file
PV_WIDTH="${2}"          # Width of the preview pane (number of fitting characters)
PV_HEIGHT="${3}"         # Height of the preview pane (number of fitting characters)
IMAGE_CACHE_PATH="${4}"  # Full path that should be used to cache image preview
PV_IMAGE_ENABLED="${5}"  # 'True' if image previews are enabled, 'False' otherwise.

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER=$(echo "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')

# Settings
HIGHLIGHT_SIZE_MAX=262143  # 256KiB
HIGHLIGHT_TABWIDTH=8
HIGHLIGHT_STYLE='pablo'

handle_extension() {
  case "${FILE_EXTENSION_LOWER}" in
    pdf)
      pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | fmt -w "${PV_WIDTH}" && exit 5
      mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | fmt -w "${PV_WIDTH}" && exit 5
      exiftool "${FILE_PATH}" && exit 5
      exit 1;;

    odt|ods|odp|sxw)
      odt2txt "${FILE_PATH}" && exit 5
      exit 1;;

    htm|html|xhtml)
      w3m -dump "${FILE_PATH}" && exit 5
      lynx -dump -- "${FILE_PATH}" && exit 5
      elinks -dump "${FILE_PATH}" && exit 5
      ;;
  esac
}

handle_image() {
  local mimetype="${1}"
  case "${mimetype}" in
    image/svg | image/svg+xml)
      convert "${FILE_PATH}" "${IMAGE_CACHE_PATH}" && exit 6
      exit 1;;

    image/*)
      local orientation
      orientation="$(identify -format '%[EXIF:Orientation]\n' -- "${FILE_PATH}")"

      if [[ -n "$orientation" && "$orientation" != 1 ]]; then
        convert -- "${FILE_PATH}" -auto-orient "${IMAGE_CACHE_PATH}" && exit 6
      fi

      exit 7;;

    video/*)
      # youtube-dl embedded thumbnail
      ffmpeg -i "${FILE_PATH}" -map 0:v -map -0:V -c copy "${IMAGE_CACHE_PATH}"

      if [ ! -f "${IMAGE_CACHE_PATH}" ]; then
        ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && exit 6
      else
        exit 6
      fi

      exit 1;;

    application/pdf)
      pdftoppm -f 1 -l 1 \
        -scale-to-x 1920 \
        -scale-to-y -1 \
        -singlefile \
        -jpeg -tiffcompression jpeg \
        -- "${FILE_PATH}" "${IMAGE_CACHE_PATH%.*}" && exit 6

      exit 1;;
  esac
}

handle_mime() {
  local mimetype="${1}"
  case "${mimetype}" in
    text/* | */xml)
      if [[ "$(stat --printf='%s' -- "${FILE_PATH}")" -gt "${HIGHLIGHT_SIZE_MAX}" ]]; then
        exit 2
      fi

      if [[ "$( tput colors )" -ge 256 ]]; then
        local highlight_format='xterm256'
      else
        local highlight_format='ansi'
      fi

      highlight --replace-tabs="${HIGHLIGHT_TABWIDTH}" \
                --out-format="${highlight_format}" \
                --style="${HIGHLIGHT_STYLE}" \
                --force \
                -- "${FILE_PATH}" && exit 5

      exit 2;;

    image/*)
      exiftool "${FILE_PATH}" && exit 5
      exit 1;;

    video/* | audio/*)
      mediainfo "${FILE_PATH}" && exit 5
      exiftool "${FILE_PATH}" && exit 5
      exit 1;;
  esac
}

handle_fallback() {
  exit 1
}

MIMETYPE="$(file --dereference --brief --mime-type -- "${FILE_PATH}")"

if [[ "${PV_IMAGE_ENABLED}" == 'True' ]]; then
  handle_image "${MIMETYPE}"
fi

handle_extension
handle_mime "${MIMETYPE}"
handle_fallback

exit 1
