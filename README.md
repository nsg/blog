# nsg.cc

1. Edit the files
2. Test it on localhost:8080 with

```
make dev
```

3. Problems? Get a shell and debug it with

```
make debug
```

(you need to start apache your self with `apache2ctl start`)

4. Tag a release in git
5. Upload a Docker image based on the tag

```
make push
```

6. Deploy the container!
