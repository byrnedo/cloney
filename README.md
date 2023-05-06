# Cloney

Clone or pull git repos doing only a spares checkout of the specified directory

Requires a `hosts.txt` file with following format:


```
https://github.com/foo/onething.git ./ui/dist,./admin-ui/build
https://gitlab.com/bar/something.git ./public
...
```

The format is `REPO DIR1[,DIR2]...[,DIRn]`.

Sleeps for a minute after running, so just set it to `restart=always` and it'll update the repos every minute.

