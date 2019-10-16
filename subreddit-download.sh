#!/usr/bin/env bash

###############################################################################
# Config
###############################################################################

# default subreddit=catpictures :)
subreddit=${1-catpictures} && json=${subreddit}

# default dir=<subreddit name>
dir=`realpath ${2-${subreddit}}` && mkdir -p ${dir}

# default page=1
pages=${3-1} 

###############################################################################
# Downloading images
###############################################################################

printf "Download all subreddit \e[1;31m/r/${subreddit}\e[m images to \e[1;31m${dir}\e[m\n"

for i in $(seq ${pages});
do

	# download subreddit json file
	curl -sS "https://www.reddit.com/r/${subreddit}.json?limit=100&after=${after}" -A 'random' | json_pp -json_opt utf8,pretty > ${dir}/${json}.json

	printf "\e[1;35mProcessing data from ${dir}/${json}.json\e[m\n"

	images=$(cat ${dir}/${json}.json | jq -r ".data.children[].data.preview.images[0].source.url" | egrep '\.jpg|\.png|\.gif' )

	# download all images from file
	for img in ${images}
	do
		# getting filename from URL
		file=${img##*/} && file=${file%\?*}

		# Download only new images
		if [[ ! -f "${dir}/${file}" ]]; then
			printf "\e[1;90m- ${file}\e[m\n"
			curl -sS -A 'random' "${img//&amp;/&}" -o ${dir}/${file} &
		fi
	done;

	# go to next page
	after=$(cat ${dir}/${json}.json | jq -r ".data.after") && json=${after}

	if [[ ${after} == "" ]]; then
		break # not have any after pages
	fi

done;

###############################################################################
# Cleanup
###############################################################################

rm ${dir}/*.json

wait #wait for all background jobs to terminate