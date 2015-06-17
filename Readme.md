boilerplate
===========

This is a starting point for my projects. Boilerplate code for different scenarios is in different branches.

This boilerplate is MIT-licensed, as well as the projects it’s used for. So feel free to use it if you want.


Usage
-----

1) Clone this repository:

```sh
$ git clone git@github.com:tomekwi/boilerplate <my project name>
```


2) Add your real remote:

```sh
$ cd <my project name>
$ git remote rename origin boilerplate
$ git remote add origin <my remote address>
```


3) Check out boilerplate files:

```sh
$ git checkout <boilerplate flavor – I normally go for `javascript`>
```


4) Squash the history into a single initial commit on a new `master` branch:

```sh
$ git branch -D master
$ git checkout --orphan master
$ git commit --message='Boom!'
```


5) Push your way through!

```sh
$ git push --set-upstream origin master
```
