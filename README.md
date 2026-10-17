# Dungeon Keeper Co-op

Play the Dungeon Keeper campaign together: 2 to 4 players share ONE keeper, one dungeon, one pile of gold and one army.

[![Support me on Ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/cranebeaker)

Built on [KeeperFX](https://github.com/dkfans/keeperfx), the open source remake of Dungeon Keeper, in the spirit of [dk2-coop](https://github.com/ciphercom/dk2-coop) for Dungeon Keeper 2.

## Play in three steps

1. Own Dungeon Keeper (for example Dungeon Keeper Gold on GOG) and install KeeperFX 1.4.0 (on GOG, add the free "KeeperFX" game to your library and install it).
2. Download `DungeonKeeper-Coop.zip` from [Releases](../../releases) and copy everything in it into your KeeperFX folder (back up `keeperfx.exe` first). Every player needs the same build.
3. Host runs `Host Co-op (Steam).bat` and invites friends through Steam, or runs `Host Co-op.bat` for direct IP. Friends run the matching `Join` bat. The bat files ask for your nickname, hand colour and (host only) the number of players.

Full instructions are in `README-COOP.txt` inside the zip.

## What you get

- **One shared keeper.** Everyone digs, builds, casts spells, picks up and slaps at the same time, each with their own camera and cursor.
- **Possession for everyone.** Each player can possess a creature (one player per creature).
- **See your friends.** Their Hand of Evil is drawn on the map in the colour they picked, with their name, and a creature they possess gets a marker.
- **Shared campaign.** The campaign map, briefings, level start and the statistics screen are shared; the host picks the level and the host's progress is saved.
- **Steam play, no port forwarding.** Host a friends-only Steam lobby and friends join from an invite or "Join Game" in the friends list. Traffic goes through Steam's relay. Steam shows you as playing "Spacewar" while you play; that is how mods use Steam networking without their own app id.
- **Direct IP** still works for LAN or port-forwarded games.

## Status

Beta. The co-op mode is covered by an automated test bot built into the game that drives real game clients against each other: building, digging, hand pick up and drop, slapping, possession, camera moves, campaign level progression, wins and losses, 2 and 3 players, and over both direct IP and Steam networking. Every run checks that all machines stay in sync turn by turn.

## Known issues

- The torture screen after capturing a Lord of the Land is skipped.
- Very long movies (over 30 seconds) can drop the connection.
- Escape on the campaign map sends everyone back to the lobby.

Found a bug? Open an [issue](../../issues) and attach `keeperfx.log` from every player (start the game with `-mplog` for more detail).

## How it works

KeeperFX runs every player's game in lockstep: each machine simulates the same turns from the same inputs. Normally one network user controls one keeper. This mod lets several users drive the same keeper ("Archon" mode, an idea already being built upstream in KeeperFX) by giving every user their own camera, cursor, hand state, possession and room placement, while the dungeon itself stays shared. Partner hands and markers are drawn from data every machine already has, so they can never cause a desync.

Steam networking is a separate network backend that talks to `steam_api.dll` through Steam's flat C API, using lobbies for invites and Steam's relay for traffic.

## Source and building

All of the co-op code is in this repo:

- `patch/archon-coop.patch`: the complete change, as one patch against KeeperFX commit `9144deb` (the 1.4.0 alpha it was built on).
- `source/`: every file the patch adds or changes, so you can read the code here on GitHub. The Archon co-op design and the test bot are described in `source/docs/archon_coop.md`.
- `tools/mock-steam/`: a stand-in `steam_api.dll` used by the tests, so two game copies on one PC can talk through the Steam code path.

The same code as a ready-to-build tree is the `archon-coop` branch of [cranebeaker/keeperfx](https://github.com/cranebeaker/keeperfx/tree/archon-coop).

To build it yourself:

```
git clone https://github.com/dkfans/keeperfx.git
cd keeperfx
git checkout 9144deb
git apply ../dungeon-keeper-coop/patch/archon-coop.patch
```

Then build as described in KeeperFX's own README (CMake with the MinGW toolchain).

## Part of coop-anything

This project is part of [coop-anything](https://github.com/cranebeaker/coop-anything), a collection of co-op mods for single player games and the playbook used to make them.

## Credits

- The [KeeperFX team](https://github.com/dkfans/keeperfx) for the open source Dungeon Keeper engine.
- nstbayless for the upstream Archon mode work in KeeperFX.
- [ciphercom/dk2-coop](https://github.com/ciphercom/dk2-coop) for the shared keeper idea in Dungeon Keeper 2.
- Bullfrog for Dungeon Keeper.
- Valve for the Steamworks API; `steam_api.dll` comes from the [Steamworks.NET](https://github.com/rlabrecque/Steamworks.NET) standalone release.

## License

GPL-2.0, the same as KeeperFX. You need your own copy of Dungeon Keeper; no game data is included.
