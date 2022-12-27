+++
date = "2016-10-08T17:59:00+01:00"
title = "Syncevolution"
tags = ["Ubuntu Touch", "Syncevolution"]
+++

Time to integrate Nextcloud with my Ubuntu Phone, the calendar was easy because there are an option under accounts that is called "Owncloud", I just added my Nextcloud account and my calendar was synced. Unfortunately I see no way to sync nether contacts or tasks with this method. I guess, the option will be there in a future OTA, I hope.

The good thing is that it's only the UI that's missing, you can do plenty of things with the command `syncevolution`. I triggered a sync from command line I got this:

```sh
$ syncevolution --print-configs
Configured servers:
   owncloud-3 = /home/phablet/.config/syncevolution/default/peers/owncloud-3
   target-config@owncloud-3 = /home/phablet/.config/syncevolution/owncloud-3/peers/target-config

$ syncevolution --sync two-way owncloud-3
[INFO] @default/3personal: inactive
[INFO] @default/memo: inactive
[INFO] @default/todo: inactive
[INFO @owncloud-3] target side of local sync ready
[INFO @owncloud-3] @owncloud-3/3personal: inactive
[INFO @owncloud-3] @owncloud-3/addressbook: using configured database=https://nextcloud.example.com:443/remote.php/dav/addressbooks/users/nsg/contacts/
[INFO @owncloud-3] @owncloud-3/calendar: using configured database=https://nextcloud.example.com:443/remote.php/dav/calendars/nsg/personal/
[INFO @owncloud-3] @owncloud-3/addressbook: starting normal sync, two-way (peer is server)
[INFO @owncloud-3] @owncloud-3/calendar: starting normal sync, two-way (peer is server)
[INFO] @default/addressbook: starting normal sync, two-way (peer is client)
[INFO] @default/calendar: starting normal sync, two-way (peer is client)
[INFO] @default/addressbook: started
[INFO] @default/calendar: started
[INFO @owncloud-3] @owncloud-3/addressbook: started
[INFO @owncloud-3] @owncloud-3/calendar: started
[INFO] @default/addressbook: normal sync done successfully
[INFO] @default/calendar: normal sync done successfully
[INFO @owncloud-3] @owncloud-3/addressbook: normal sync done successfully
[INFO @owncloud-3] @owncloud-3/calendar: normal sync done successfully
```

Both Calendar and Contacts was synced, no need to change any configuration.

```sh
$ syncevolution --print-databases | grep =
Evolution Address Book = Evolution Contacts = evolution-contacts:
Evolution Calendar = evolution-calendar:
Evolution Task List = Evolution Tasks = evolution-tasks:
Evolution Memos = evolution-memos:
```

Both `evolution-contacts` and `evolution-calendar` contains the expected data (you can view it with `syncevolution --print-items backend=evolution-calendar`), but tasks and memos are empty, and I have data in the built-in provided applications.

... maybe "Notes" and "Tasks" just stores the data in the apps own internal storage, that's quite useless. Need to investigate this closer but that's for another day, calendar and contacts was the important one.

Make a cronjob and a script:

```
$ crontab -l | tail -2
# Sync calendar and contact twice a day
30 8,17 * * * /home/phablet/bin/sync-nextcloud.sh
```

```
$ cat /home/phablet/bin/sync-nextcloud.sh
#!/bin/bash

syncevolution --sync two-way owncloud-3 >/home/phablet/.cache/upstart/sync-nextcloud.log 2>&1
```

And finally, make the initial sync:

```
$ syncevolution --sync slow owncloud-3
```