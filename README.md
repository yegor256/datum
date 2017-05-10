<img src="http://www.zerocracy.com/logo.svg" width="64px" height="64px"/>

[![Availability at SixNines](http://www.sixnines.io/b/2b3a)](http://www.sixnines.io/h/2b3a)
[![Build Status](https://travis-ci.org/zerocracy/datum.svg?branch=master)](https://travis-ci.org/zerocracy/datum)

Zerocracy is management without managers.

Information about current project status is kept in XML and text
files. This repository contains full list of XSD Schemas for them
and rules of usage.

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
  - [x] Modify your set of skills: `skills`
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
