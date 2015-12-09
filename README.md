# Mini-Kickstarter
[![Build Status](https://travis-ci.org/funkymonkeymonk/minikick.svg)](https://travis-ci.org/funkymonkeymonk/minikick)


This project is to create a CLI-driven application that is emulates the most
basic functions of Kickstarter as per the Kickstarter code test found at
https://gist.github.com/ktheory/3c28ba04f4064fd9734f.

## Using the docker runtime environment
This application is designed to be run either locally or using docker.

### To run in docker environment
make run

### To run locally
```
bundle install
./bin/minikick
```

## Usage
### Create a new project on Minikick
`minikick project <project> <target amount>`

### Back a project on minikick
`minikick back <given name> <project> <credit card number> <backing amount>`

### Display a project and all backers
`minikick list <project>`

### Display all projects a backer has backed and amounts
`minikick backer <given name>`
