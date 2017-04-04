# lsd - list of directories in current one

## Problem
I like use console, but in some cases I became unhappy. For example, I enter in folder with many files/folders and traditional command _ls_ do not let me simple way to get list of directories only. I know about _ls -d */_, _du -sh */_ etc., but it's not suits for me.

## Decision
Make console app (for macOS in my case), for listing directories in more usefull form with follow options: list or vertical colomn, sort by name, creation date, modification date and size, ascending or descending sort direction, show date or size or not, show hidden directories or not.

## Setup
To make app work in any folder - place app in one of the folders availible through path environments. I prefer _/usr/local/bin_. Building process of XCode project copy executive file in _/usr/local/bin_ automaticaly.

## Usage
Open console (Terminal.app) and enter _lsd_. By default you get list of directories in one colomn with sort by directory name in descend direction, hidden (with leading dot) directories will not show.

To launch app in other mode use follow options:
* -l    // print directories in line (by default),
* -v    // print directories in vertical colomn,
* -?    // print help,
* -a    // ascending sort,
* -d    // descending sort (by default),
* -n    // sort by name (by default),
* -c    // sort by created date,
* -m    // sort by modified date,
* -s    // sort by size (attention! may spend a long time),
* -b    // basic show mode (by default, only directory name),
* -e    // extended show mode (more info about date or size),
* -h    // show hidden (with leading dot) directories.

Example:

lsd -vme   // list directories in vertical colomn with sort by modification date in descend direction, show in extended mode,
lsd -vsae   // list directories in vertical colomn with sort by size in ascend direction, show in extended mode.

## Config
You can edit default mode of app launching. Options stored in config xml file - _~/lsd.config.xml_.

## Performance
App is very small and quick, but if it work with sort by size - process of calc file sizes will may get long time.

## Notes
App calculate only file size, while size on disk may be different. There are different methods of calculation: several system functions to compute directory size, include or not empty directories, different "sizes" of packages. In that way total size output by app may differ from size shown in Finder. Differences is very small, but may be exists.

gl hf

April, 3 2017

Yan Gerasimuk
