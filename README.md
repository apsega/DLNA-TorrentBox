# DLNA-TorrentBox
Docker container for DLNA (minidlna) and TorrentBox (Deluge-WebUI) with RSS (flexget).

## Main Features

### Deluge Web UI
Deluge Web User Interface with awesome features:
* Password protection (default password is ``deluge`` and you'll be asked if you want to change it)
* Auto load torrents from any location
* Stop seeding torrents after [number] ratio is reached
* And many more!

### Flexget 
Flexget has advanced configuration and is capable of reading torrent site RSS and auto adding TV Shows to the queue as soon as new episode is being released. It can also scan RSS for released movies and compare them to IMDB for ratings, vote numbers, release year, genres to make a decision if it's worth being added to the download queue.

### Minidlna
Minidlna is a very lightweight and very fast DLNA server that servers content instantly when they arrive without any media scan.

# Docker run

Below are a few examples of how to get running this container.

To run this container with random exposed ports, use ``-P`` flag. Please note, that Web UI will be port assigned to container's 8112 port.

    docker run --net=host --name torrent-box -P -d edgaras/dlna-torrentbox:latest

You can mount data volume (container's /home/) to your filesystem location (i.e. /home/dlna/) try the following command:

    docker run --net=host --name torrent-box -P -v /home/dlna:/home -d edgaras/dlna-torrentbox:latest

Assign 80 port to Deluge Web UI with the following:

    docker run --net=host --name torrent-box -p 80:8112 -P -d edgaras/dlna-torrentbox:latest

# Configuration
To configure Flexget RSS, run the following command:

    docker exec -ti torrent-box vi /root/.flexget/config.yml

* ``rss:`` - change this to your RSS feed URL.
* ``series`` - change to your preferred TV Shows.
* ``imdb`` - change to your preferences what kind of movies will be automatically downloaded compared to these IMDB settings.
 
## RSS

As ``crontab`` is not working inside container, you have to setup on the host Operating System your cron schedule. This simply can be done by entering ``crontab -e`` command and adding the following line:

    @hourly docker exec torrent-box flexget execute


