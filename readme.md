# Subreddit Image Downloader

Subreddit downoader is a **bash script** which:

* download all images in full size
* download only new images
* support paging
* is MacOS/Linux/Windows compatible

## Requirements

- bash
- [jq](https://stedolan.github.io/jq/download/)
- [curl](https://curl.haxx.se/download.html)

## Download incrementally 

## Usage

```bash
./subreddit-download.sh <subreddit name> <directory> <pages>
```

Download all images from [catpictures](https://www.reddit.com/r/catpictures/) subreddit:

```bash
./subreddit-download.sh catpictures ./catpictures 5
```

You can also use cron to backup images hourly:

```bash
0 * * * * /home/pi/subreddit-download.sh catpictures ~/Downloads
```
