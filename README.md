<img src="http://www.zerocracy.com/logo.svg" width="64px" height="64px"/>

[![Managed by Zerocracy](http://www.zerocracy.com/badge.svg)](http://www.zerocracy.com)
[![DevOps By Rultor.com](http://www.rultor.com/b/zerocracy/datum)](http://www.rultor.com/p/zerocracy/datum)

[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.svg)](https://gitter.im/zerocracy/Lobby)

[![Stability of Webhook](http://www.rehttp.net/b?u=http%3A%2F%2Fwww.0crat.com%2Fghook)](http://www.rehttp.net/i?u=http%3A%2F%2Fwww.0crat.com%2Fghook)
[![Availability at SixNines](http://www.sixnines.io/b/2b3a)](http://www.sixnines.io/h/2b3a)
[![Build Status](https://travis-ci.org/zerocracy/datum.svg?branch=master)](https://travis-ci.org/zerocracy/datum)

Zerocracy is management without managers.

Information about current project status is kept in XML and text
files. This repository contains full list of XSD Schemas for them
and rules of usage.

Read [our policy](http://datum.zerocracy.com/pages/policy.html),
it covers all processes in these XML files.

Any problems you have with [Zerocracy](http://www.zerocracy.com)
please report [here](https://github.com/zerocracy/datum/issues).
We promise to do our best to resolve them as soon as possible.

## How it works

Product Owner (`PO`) is a representative of a project sponsor.
As a PO you can:

  - [x] [Invite](http://www.0crat.com/invite) `@0crat` to your Slack
  - [x] [Create](https://get.slack.help/hc/en-us/articles/201402297-Create-a-channel) a new Slack channel for a project
  - [x] [Invite](#invite-only) a friend: `invite`
  - [x] Start talking to the bot: `hello`
  - [x] Bootstrap a project: `bootstrap`
  - [ ] Fund the project using a credit card: `fund`
  - [ ] Transfer funds from project to project: `transfer`
  - [x] Link the project with GitHub repositor(ies): `links`
  - [x] Register `ARC` and `DEV` roles: `roles`
  - [x] Add tickets to the scope in GitHub: `in`
  - [x] Remote tickets from the scope: `out`
  - [x] See the WBS: `wbs`
  - [ ] See the budget: `budget`
  - [ ] See the schedule: `schedule`

An Architect (`ARC`) is the key technical decision maker
in the project. As an ARC or a PO you can:

  - [x] Assign a performer to a job: `assign`
  - [x] Resign a performer: `resign`
  - [ ] Increase/decrease job budget: `boost`
  - [ ] Attach a job to a milestone: `milestone`

As a Developer (`DEV`) you can:

  - [x] Join one of Slack teams
  - [x] Start talking to the bot in a private channel: `hello`
  - [x] Modify your hourly rate: `rate`
  - [x] Modify your payment details: `wallet`
  - [ ] Quit a project: `quit`
  - [ ] Set/reset "away" mode: `away`
  - [x] Reject a job: `resign`
  - [ ] Announce an impediment: `hold`
  - [ ] Check the status of a job: `status`
  - [ ] Request your profile metrics: `metrics`

As a Quality Assurance (`QA`) you can:

  - [ ] Confirm the quality of a task: `quality`

The bot can:

  - [x] Assign a job to a performer
  - [ ] Announce job budget
  - [ ] Announce job deadline
  - [ ] Resign a performer
  - [ ] Request quality control
  - [ ] Update performer's metrics
  - [ ] Pay for bugs reported
  - [ ] Pay performer for task completion

## Invite Only

You can use the system only if someone invites you. That person has to
know your GitHub login and say this to `@0crat` bot (provided your name
is `yegor256`):

```
@0crat invite yegor256
```

That's enough. From that moment you have a "mentor."

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

After all changes are made, don't forget to run
[`rake`](https://github.com/ruby/rake).
You will need Ruby 2.2+ installed.
