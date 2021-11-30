# Plants VS Zombies: Haxe Edition

PVZ: Haxe Edition is a port of PVZ (PC Version) in the coding language HaxeFlixel\
Oh yeah if you make mods open-source them (as stated in the [Using Source Code](https://github.com/Cheese-Curd/PlantsVSZombiesHaxe#using-source-code) section) + this: [LICENSE](https://github.com/Cheese-Curd/PlantsVSZombiesHaxe/blob/main/LICENSE)

## Downloading

There are pre-compiled builds in the [releases](https://github.com/Cheese-Curd/PlantsVSZombiesHaxe/releases) tab. I will keep the old builds so you can experience the old builds lol\
***at this time there are no published builds currently***

## Fun stuff

Wanna mess with image textures or entity stats?\
GO AHEAD!\
I made the entity stats jsons for a reason, it's not modding but it's close enough.\
**Just don't say that you made this because if I find it I will ask for you to take it down.**\
**The least you have to do is post the link to the repo, not that hard.**\
Also if you make a mod of this by making a fork, **please keep them open-source.**\
If [FNF](https://github.com/ninjamuffin99/Funkin) can do it, so can I.

## Contributing
[Pull Requests](https://github.com/Cheese-Curd/PlantsVSZombiesHaxe/pulls) are welcome. For major changes, please open an [issues](https://github.com/Cheese-Curd/PlantsVSZombiesHaxe/issues) first to discuss what you would like to change.

## Using Source Code
All there is to know on compiling this game!
### Requirements

1. Install [Haxe 4.1.5](https://haxe.org/download/version/4.1.5/)
(Download 4.1.5 instead of 4.2.0 because 4.2.0 is broken and is not working with gits properly...) *not stolen from the FNF GitHub, I would do no such thing*
2. Install [HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/)
3. Run these commands in a Command Prompt Window ~~or PowerShell if you're weird~~:
```bash
haxelib install flixel
haxelib install flixel-addons
haxelib install flixel-ui
```
You also need Git, cause discord RPC and shit. Dumb, I know.
1. Install [git-scm](https://git-scm.com/downloads)
2. Run these commands in CMD:
```bash
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
```
Now, onto the fun part
### Compiling

Once you have all of those, it's actually *super* simple to compile.\
To compile to HTML5 (what web browsers use) in a CMD window (or VSCode if you are cool B) ), that is linked to the root directory of your project, put this:
```bash
lime test html5 -debug
```
Linux
```bash
lime test linux -debug
```
MacOS
```
No idea I will search more later, if I find anything I will update this with the command
```
But, if you want to compile for Windows, it's a lot different story.\
You need Visual ~~Stupid~~ Studio, not Visual Studio Code, [Visual Studio](https://visualstudio.microsoft.com/downloads/)\
###### I swear to god if it doesn't strikethrough that I will die

When installing don't click on any of the options to install workloads. Instead, go to the individual components tab and choose the following:
* MSVC v142 - VS 2019 C++ x64/x86 build tools
* Windows SDK (10.0.17763.0)

Then finally, when that's done do this:
```bash
lime test windows -debug
```
then again if you use VSCode just press your debug button (default `F5`)

###### Note: The ```-debug``` is optional, that is for compiling the game when debugging, it is faster but has more developer options.
# Legal stuff + Credits
**All image/sounds/music assets are *NOT* mine, they belong to their respected author.**

[**More Info**](https://github.com/Cheese-Curd/PlantsVSZombiesHaxe/blob/main/assets/SpecialThanks.txt)
### Plants VS Zombies Team:

[PopCap Games](https://www.ea.com/ea-studios/popcap) - *Developer*\
[EA Games](https://www.ea.com/) - *Publisher*\
[Laura Shigihara](https://www.laurashigihara.com/) - *Music Artist*\
[George Fan](https://twitter.com/thegeorgefan) - *Creator*

### Plants VS Zombies Haxe Edition Team:
Cheese Curd - *Lead Developer*\
[Angel Bot](https://github.com/AngelDTF) - *Extra Utilities*
###### *haha it's all me! Except for Angel-*\
