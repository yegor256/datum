<img src="https://www.zerocracy.com/logo.svg" width="64px" height="64px"/>

[![EO principles respected here](https://www.elegantobjects.org/badge.svg)](https://www.elegantobjects.org)
[![DevOps By Rultor.com](http://www.rultor.com/b/zerocracy/datum)](http://www.rultor.com/p/zerocracy/datum)
[![We recommend RubyMine](https://www.elegantobjects.org/rubymine.svg)](https://www.jetbrains.com/ruby/)

[![Hits-of-Code](https://hitsofcode.com/github/zerocracy/datum)](https://hitsofcode.com/view/github/zerocracy/datum)

Information about current project status is kept in XML and text
files. This repository contains full list of XSD Schemas for them
and rules of usage.

Read [our policy](http://www.zerocracy.com/policy.html),
it covers all processes in these XML files.

Any problems you have with [Zerocracy](http://www.zerocracy.com)
please report [here](https://github.com/zerocracy/farm/issues).
We promise to do our best to resolve them as soon as possible.

## Data model

A project has a list of members, with assigned roles to them. Each project
member, also known as **user** is identified by his GitHub name, for example
[yegor256](https://github.com/yegor256).

There is only one piece of work, which is called a **job**. A job
can either be in scope or not. If the job is in scope, it is listed
in the `wbs.xml`.

A job, which is in scope, may have an **order** assigned to it, as a record in `orders.xml`.
An order has a **performer**. An order may be finished (success) or terminated (failure).

A job, which is in scope, may have an **election** in `elections.xml`,
which is created by Zerocrat automatically. The election is used as a basis
for the decision making of an order assignment.

An order may have an **impediment**, which is listed in `impediments.xml`. While
the impediment exists, the order won't be terminated
[by delay](http://www.zerocracy.com/policy.html#8).

## Upgrades

When we modify XSD schemas here, production XML documents don't catch up
automatically. If we introduce a new XML element in, say, `wbs.xsd`, XML
documents `wbs.xml` in real production projects won't have it. Right after
we switch to a new version of Datum, they all will become invalid.

In order to solve this problem we have a collection of "upgrades,"
which are XSL transformations. When
[`Xocument`](https://github.com/zerocracy/farm/blob/0.21.1/src/main/java/com/zerocracy/Xocument.java)
opens an XML document, it checks the `version` attribute of its root element.
If the version is lower than [`Xocument.VERSION`](https://github.com/zerocracy/farm/blob/0.21.1/src/main/java/com/zerocracy/Xocument.java#L71),
it applies all necessary XSL transformations. Right at that moment
we have a chance to upgrade XML documents and add necessary elements or attributes
(or delete deprecated ones).

Every time you introduce something new to an XSD schema, don't forget to add
an upgrade XSL. The name of upgrade XSL file must start with a version,
where it has to be applied.

## How to contribute?

We keep XSD Schema files in the [`xsd`](https://github.com/zerocracy/datum/tree/master/xsd)
directory. You can modify them as you wish. However, keep in mind that you
need 1) to test them, 2) make sure existing XML files in the projects will
be upgraded to your changes, and 3) modify XSL views.

First, in order to test an `.xsd` file you should create `.xml` files
in the [`xml`](https://github.com/zerocracy/datum/tree/master/xml) directory.
You can make as many of them them there as you need. All of them will be
tested against the XSD Schema. If the name of the `.xml` file starts with
a dash, it is expected that the validation against the XSD Schema will fail.
If it won't fail, the build will break.

Second, every time you introduce some changes to the `.xsd` file, make sure
you add an XSL Transformation to the
[`upgrades`](https://github.com/zerocracy/datum/tree/master/upgrades) directory.
Each `.xsl` file must be named as `XXX-name.xsl`, where `XXX` is the version
number it upgrades an `.xml` file to. All versions are
[here](https://github.com/zerocracy/datum/releases) (we're using
[semantic versioninig](http://semver.org/)).

Third, don't forget to add or modify XSL views in
[`upgrades`](https://github.com/zerocracy/datum/tree/master/xsl) directory.

After all changes are made, don't forget to run:

```
$ bundle update
$ bundle exec rake
```

To make `rake` working you will need to install:
 - Ruby 2.6+
 - [rake](https://github.com/ruby/rake) (`gem install rake`)
 - [bundler](https://bundler.io/)  (`gem install bundler`)
 - [maven](https://maven.apache.org/)

To install all dependencies for `rake` run in project directory:

```sh
$ bundle install
$ mvn dependency:get -DgroupId=net.sf.saxon -DartifactId=Saxon-HE -Dversion=9.8.0-8
```
