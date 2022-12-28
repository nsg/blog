+++
date = "2018-02-25T15:30:00+01:00"
title = "Fuzzy Bash completion"
[taxonomies]
tags = ["bash", "shell"]
+++

The `ssh` command has included bash completion in most systems, for example you can complete common host names and on some systems even hosts previously connected to from the `known_hosts` file, but this file do not contain useful hostnames since many years due to security reasons.

At work we I connect to hundred of hosts and I can't use the `known_hosts` for for tab completion. I use `^r` a lot to search for old entries and that works in a few cases. It that fails, there is a lot of typing.

First I thought, we have a full inventory of all our hosts so it should be really simple for me just to write a bash function and then call it with `complete -F` and I'm done. I then realized that our hosts follows a pattern of `nycprod-mariadb-master01.example.com`. A `ssh nyc<tab>` would still list hundreds of hosts and I had to write all the way down to `ssh nycprod-mariadb<tab>` to get a useful short list. To make it worse, we have a old and an new naming pattern so it not always easy to guess the name. Old legacy systems that we have not bothered to rename.

So I thought, what if I could find the host above by just typing `ssh mariadb<tab>`, would that be possible? It is!

## The code

The function maintains a cache of all hosts at `/tmp/__s__list_all_hosts__cache`. It will call a function called `__s__cache_all_hosts` that will update the cache file from our inventory if needed. All hosts are then printed.

```
__s__list_all_hosts() {

    local cache_path=/tmp/__s__list_all_hosts__cache
    local cache_age=86400

    if [ -f $cache_path ]; then
        local cache_age=$(( $(date +%s) - $(date -r $cache_path +%s) ))
    fi

    if [ $cache_age -gt 300 ]; then
        __s__cache_all_hosts $cache_path
    fi

    cat $cache_path
}
```

This small function wraps grep so it supports `*` as a glob.

```
__s__grep() {
    grep -E "${1//\*/.*}"
}
```

The actual magic, this lists all hosts, uses grep to filter out the matches and finally updates the `COMPREPLY` array with a little help from `mapfile`.

```
__s__complete() {
    local word="${COMP_WORDS[COMP_CWORD]}";
    mapfile -t COMPREPLY < <(__s__list_all_hosts | __s__grep $word)
}
```

A simple function that creates an "alias" called just "s", and finally the completion. I mapped this to "s" instead of "ssh" because it was easier, and I like to have the logic separated.

```
s() {
    /usr/bin/ssh $@
}

complete -F __s__complete s
```

It's now possible for me to type things like `s mariadb<tab>` or `s nyc*maria<tab>`.
