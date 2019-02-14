# Lighthouse Keeper

[![CircleCI](https://circleci.com/gh/ItinerisLtd/lighthouse-keeper.svg?style=svg)](https://circleci.com/gh/ItinerisLtd/lighthouse-keeper)

### SSH Key

```sh-session
$ openssl genrsa -out xxx 4096
$ sudo chmod 600 xxx
$ ssh-keygen -y -f xxx > xxx.pub
```

## Generate `.circleci/config.yml`

1. `$ wget https://raw.githubusercontent.com/ItinerisLtd/lighthouse-keeper/master/src/generate_config.rb`
1. Edit the `urls` array in `generate_config.rb`
1. `$ ruby generate_config.rb`
1. Edit `CHANGEME` in the newly generated yaml file

## Manual Trigger

```sh-session
$ curl -X POST --header "Content-Type: application/json" -d '{"branch":"staging"}' https://circleci.com/api/v1.1/project/:vcs-type/:username/:project/build?circle-token=:token

# Example
$ curl -X POST --header "Content-Type: application/json" -d '{"branch":"master"}' https://circleci.com/api/v1.1/project/github/itinerisltd/lighthouse-keeper-demo/build?circle-token=MY-CIRCLE-TOKEN

{
  "status" : 200,
  "body" : "Build created"
}
```

Note: You have to trigger the workflow instead of individual jobs.

See: https://circleci.com/docs/api/v1-reference/#new-project-build
