This policy explains basic work principles of
[0crat](http://www.0crat.com) ("Zerocrat"):
a project management AI bot developed
and hosted by [Zerocracy](http://www.zerocracy.com).

If you want to change something in this policy of simply
suggest an improvement, please submit a ticket
[here](https://github.com/zerocracy/datum/issues).
If you want to discuss the policy or your troubles with the bot,
please join our [Gitter chat](https://gitter.im/zerocracy/Lobby).

We recommend you to read these articles first,
they explain our management phylosophy
(based on [XDSD](http://www.xdsd.org))
and its basic principles:

  * [Stop Chatting, Start Coding](http://www.yegor256.com/2014/10/07/stop-chatting-start-coding.html)
  * [How Micro Is Your Tasking?](http://www.yegor256.com/2017/11/28/microtasking.html)
  * [How XDSD Is Different](http://www.yegor256.com/2014/04/17/how-xdsd-is-different.html)
  * [Definition of Done](http://www.yegor256.com/2014/04/15/definition-of-done.html)
  * [No Obligations](http://www.yegor256.com/2014/04/13/no-obligations-principle.html)
  * [Five Principles of Bug Tracking](http://www.yegor256.com/2014/11/24/principles-of-bug-tracking.html)
  * [Bugs Are Welcome](http://www.yegor256.com/2014/04/13/bugs-are-welcome.html)
  * [How to Cut Corners and Stay Cool](http://www.yegor256.com/2015/01/15/how-to-cut-corners.html)
  * [It's Not a School!](http://www.yegor256.com/2015/02/16/it-is-not-a-school.html)

## Developer

You can talk to `@crat` in:

  * Slack: [start](http://www.0crat.com/add_to_slack) a private conversation with `@0crat`
  * Telegram: [start](https://telegram.me/zerocrat_bot) a chat with [`@zerocrat_bot`](https://telegram.me/zerocrat_bot)
  * GitHub: prepend your message in any ticket with [`@0crat`](https://github.com/0crat)

<a name="1" href="#1">§1</a>.
"Invite."
To start working with us you have to be invited by someone we already know.
Ask that person to say `invite` with your GitHub login to Zerocrat.
The person will be your mentor and will be responsible for helping you
out in the system. Also, the mentor will receive financial bonuses from
us for the money you earn.

<a name="2" href="#2">§2</a>.
"Apply."
To join a project you have to find it on the [board](http://www.0crat.com/board)
and send `apply` request to Zerocrat. The architect of the project will
either invite you or ignore your request. You can apply multiple times.

<a name="3" href="#3">§3</a>.
"Election."
Zerocrat may assign a job to you according to its own election rules.
You will be notified in job's ticket.

<a name="4" href="#4">§4</a>.
"Fixed Budget."
Each job has a fixed budget in minutes,
which will be multiplied by your hourly rate and paid to you when the job is completed.
The actual amount of time you spend on the job doesn't affect the amount of money you receive.
You will also get as many positive [points](#18) as many minutes you are paid for.

<a name="18" href="#18">§18</a>.
"Points."
You may earn positive and negative points for doing good and bad things in
the projects. They do not affect your cash income, but do affect the impression Zerocrat
has about you&mdash;the more points you have the more disciplined developer you are.
Zerocrat takes into account only the points you earned over the last 90 days.

<a name="5" href="#5">§5</a>.
"Boost Factor."
A job may receive a boost factor, which will increase or decrease its budget.
Default boost factor is `2x`, which means 30 minutes.
Default boost factor for a code review is `1x`.
In exceptional situations, you should ask project architect to boost your job.

<a name="6" href="#6">§6</a>.
"Refusal."
You may refuse to complete any job by saying `refuse`.
You will get 15 negative [points](#18) for that.

<a name="7" href="#7">§7</a>.
"Definition of Done."
A job is completed when its ticket is [closed](http://www.yegor256.com/2014/04/15/definition-of-done.html).

<a name="8" href="#8">§8</a>.
"Ten Days."
If you don't complete a job in 10 days Zerocrat _may_ take it away from you.
You will get no money and 30 negative [points](#18) if this happens.

<a name="9" href="#9">§9</a>.
"Impediments."
You may declare impediments for a job by saying `waiting` to Zerocrat.
Until the job has impediments [Ten Days rule](#8)
is not applicable to it.

<a name="10" href="#10">§10</a>.
"Code Review Bonus."
For each code review you get a bonus as big in minutes as the amount of
comments you posted to the ticket during the review.

<a name="16" href="#16">§16</a>.
"Rate."
To make money in any project you must define your hourly rate.
To do that just say `rate` to Zerocrat.

<a name="20" href="#20">§20</a>.
"Wallet."
We can send you money either via PayPal or Bitcon.
To tell us how exactly you want to receive them just say `wallet` to Zerocrat.

## Product Owner

<a name="11" href="#11">§11</a>.
"Add to Slack."
To start working with us, you have to [invite](http://www.0crat.com/add_to_slack)
Zerocrat to your Slack.

<a name="12" href="#12">§12</a>.
"Bootstrap."
To let Zerocrat manage your project you have to create a new Slack
channel and add `@0crat` to it.

<a name="13" href="#13">§13</a>.
"Assign/Resign."
Everybody who will be managed by Zerocrat must have roles in the project.
To assign a role you say `assign`. To remove a role you say `resign`.
By default, all new people you assign are supposed to work for free. If you
want to pay them for the tasks they complete, add hourly rate to the `assign`
command, for example: `assign DEV yegor256 $50`. To change the hourly
rate of a person just assign the same role with a different rate.

<a name="17" href="#17">§17</a>.
"Connect GitHub."
To connect your GitHub repository to the project you should
1) add a new Webhook: `http://p.rehttp.net/http://www.0crat.com/ghook`
(with "send me everything" option),
and
2) link the project in Slack: `links add github yegor256/cactoos`, where
instead of `yegor256/cactoos` you should put the coordinates of your GitHub repository.

## Architect

<a name="14" href="#14">§14</a>.
"Scope In/Out."
You should add jobs to the scope, by saying `in` to Zerocrat (or assigning the ticket to him).
You can remove a job from the scope by saying `out`.

<a name="15" href="#15">§15</a>.
"Boosting."
You can increase a budget of the job by setting its boost factor.
Just say `boost 2x` (or `3x`, `5x`, etc.) to Zerocrat.
This operation is against our principles of [micro-tasking](http://www.yegor256.com/2017/11/28/microtasking.html),
that's why you get -10 [points](#18) every time you do this.

<a name="19" href="#19">§19</a>.
"Assign."
You can manually assign any job to a user, just say `assign @yegor256`
(where instead of `@yegor256` you put the GitHub login of the user) or
assign the ticket to that user in your ticket tracking system.
This operation is against our principles of automated task management,
that's why you will get -5 [points](#18) every time you do this.

