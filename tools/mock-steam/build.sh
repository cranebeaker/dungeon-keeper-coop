#!/bin/bash
# Build the mock 32 bit steam_api.dll inside the kfx-build image. Output: kfx-tools/mock-steam/mock_steam_api.dll
D=$(cygpath -w "$(dirname "$(readlink -f "$0")")")
MSYS_NO_PATHCONV=1 docker run --rm -v "$D:/m" kfx-build bash -c "i686-w64-mingw32-gcc -O2 -Wall -shared -o /m/mock_steam_api.dll /m/mock_steam_api.c -lws2_32 -Wl,--kill-at && i686-w64-mingw32-objdump -p /m/mock_steam_api.dll | grep -c ' SteamAPI_'"
