# Obsidian Free Sync

Obsidian Free Sync is a simple script that enables synchronization between your local obsidian folder and a folder on your cloud mounted folder. It checks for modifications in files within the local Obsidian folder and the remote folder and copy them if changes are detected. The script also supports logging to keep track of the synchronization process.

## Usecase
It's a nische soluting where I have to sync my local Obsidian to a pCloud, but the pCloud is not syncing reliably enought (on Mac there are some mounting problems, some synching issues, etc) so I needed some script that will manually copy the changed files to my cloud mounted folder with keeping a log as well (optional). 

## How-to

The `obsidian-sync.sh` script is a simple solution for syncing files from a source directory to a destination directory. It compares files between the directories and copies over any modified files or those that do not exist in the destination directory.

### Prerequisites

The script is intended to be run using a zsh shell, because it's ment to run on MacOS. Can be ported to zsh for linux with chaning the parameters of `sync` command.
    
`Obsidian local` and `Obsidian cloud mount` directories: Ensure that both directories exist and have the necessary permissions set for reading and writing files.

### Usage

Run the script using the following command:

```
./obsidian-sync.sh
```

```
./obsidian-sync.sh [--log | -l logfile] | [--help|-h]

Options

    --log, -l: Enable logging and specify a logfile. Example: --log sync.log
    --help, -h: Display the help banner with usage instructions.
```

### To enable logging:

```
./obsidian-sync.sh --log sync.log
```

> Note that if on file is specified the default one is `obsidian-sync.log`
> If you want to execute it with enabled logging 

### Example Usage:

```
./obsidian-sync.sh -log
```

## Scheduled execution with crontab

To run the script on a scheduled manner you can use crontab. To define on what exact manner you want to execute it you can use
[crontab.guru](https://crontab.guru/). On the example I'll run the script on every 30 minutes.

```
crontab -e
```

```
*/30 * * * * /bin/zsh /where-the-script-is-placed/obsidian-free-sync/obsidian-sync.sh
```

## Performance implications
Since the meat of all operations from the script are minimal (`sync` to scan the file for chances and `cp` for copy the changed files) there are no any expected performance implications.

## Other usage
As you can see the `obsidian-free-sync` is just a simple tool that copy modified files from one folder to another. So you can modify it as you want and I see it mostly used on simple backup solutions for example.

This script is released under the MIT License.

Feel free to modify and expand this README file based on your preferences and additional details about the script's usage or functionality.