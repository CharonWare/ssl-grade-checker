echo "\nRunning docker container."
echo "This may take a while..."
# /tmp/sites is mounted to /tmp in the container, sites.txt file handed in via the -hostfile flag
# Container output is sanitised and put into a location (TBD) in a file called results.txt
# This can be used as a pipeline artifact to pass the results into something more presentable
# The default ssllabs output is very verbose, so the text manipulation grabs what it needs and cuts it down into key : value pairs, site : grade
docker run -v /tmp/sites:/tmp:ro --read-only --cap-drop all --rm -it jumanjiman/ssllabs-scan:latest -hostfile /tmp/sites.txt -grade -usecache \
| grep -A1 "HostName:" \
| awk -F ":" '/HostName/{print $2;getline;print $NF}' \
| sed 's/"//g' \
| awk 'ORS=NR%2?" : ":RS' \
| tr -d '\r' \
| tee $HOME/code/ssl-grade-checker/results.txt
echo "\nContainer finished."
