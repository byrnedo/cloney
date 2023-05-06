# Cloney

Clone or pull git repos doing only a spares checkout of the specified directory

Requires a `hosts.txt` file with following format:

```
# format is REPO DIR1[,DIR2]...[,DIRn]
https://github.com/foo/onething.git ./ui/dist,./admin-ui/build
https://gitlab.com/bar/something.git ./public
...
```

