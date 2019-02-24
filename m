Content-Type: multipart/mixed; boundary="===============1542151752722552293=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Test clients for ofono: rfone, Unicsy Demo
Date: Sun, 24 Feb 2019 23:46:26 +0100
Message-ID: <20190224224626.GA16589@amd>
In-Reply-To: <20190219150638.GL5717@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1542151752722552293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> > >SMS messages should be handled in similar way e-mails currently are --
> > >stored in maildir or mailbox formats, and accessible by common email
> > >clients. Access by two or more clients at the same time should be
> > >possible. Of course, special GUI client should be provided to work
> > >with SMS (using same maildir backend).
> =

> That works nice based on my experiments over past few months :)
> The issues I've noticed so far are:
> =

> 1. There's no subject line for sms, so getting threading to
>    work needs some work with headers and some invented subject
>    line

I agree it is quite good fit, but there are more issues. It would be
nice to be able to handle calls in similar way, for example... and
delivery reports. I believe it is best solution, but it is not _too_
great fit.

> 2. Starting any scripting language (other than perl?) can be
>    super slow for sending sms for example.. Just starting ruby
>    to run a script to send sms with droid4-sms-tools takes
>    several seconds :) So yeah, sounds like rust should work
>    well here assuming it does not have start-up time and memory
>    bloatedness issues

Rust produces rather big binaries, but should be fast enough.

But... other scripting languages should not be too slow, either. Yes,
python is slow on N900 (but that's because I'm using gtk etc...) but
it is much better on Droid4. Maybe it is Ruby that is slow, or maybe
the pdu tools pull in a lot of code or something?

user(a)devuan:~$ time echo "3*3" | python
0.07user 0.03system 0.18 (0m0.183s) elapsed 57.43%CPU
user(a)devuan:~$ time echo "3*3" | python
0.07user 0.01system 0.08 (0m0.084s) elapsed 101.01%CPU
user(a)devuan:~$ time echo "3*3" | python3
0.14user 0.01system 0.17 (0m0.174s) elapsed 93.15%CPU

Ugh. Ok. Something is definitely wrong there. _Without_ background
load, python is actually slower:

user(a)devuan:~$ time echo "3*3" | python3
0.19user 0.02system 0.28 (0m0.280s) elapsed 77.84%CPU

yes > /dev/null gets it fast again:

user(a)devuan:~$ time echo "3*3" | python3
0.16user 0.00system 0.19 (0m0.193s) elapsed 84.19%CPU

Something wrong with power management?

Aha. But ruby is worse...:

user(a)devuan:~$ time echo "3*3" | ruby
0.46user 0.08system 1.09 (0m1.092s) elapsed 50.25%CPU
user(a)devuan:~$ time echo "3*3" | ruby
0.45user 0.06system 0.73 (0m0.731s) elapsed 70.22%CPU

> > >Simple text format should be supported for contacts -- probably as
> > >simple as number '\t' name. Many users will want something a bit more
> > >advanced, I'd prefer hierarchical structure offered by emacs "org"
> > >mode, allowing me to group contacts together. We should call external
> > >program to list contacts for us, allowing easy merging of contacts
> > >from multiple sources. "ph book" should provide the merged list.
> =

> I've been using just using ~/aliases file with the following
> format with ".phone" in the alias:
> =

> alias foo.phone Foo Bar <+1234567890>

So I already store my contacts in emacs org file... it looks like
this:

*** free Telecom
:PROPERTIES:
:VERSION: 3.0
:N: Telecom;free;;;
:PHONE: +420800123456
:END:

Advantage of org is that it is hierarchical. Anyway, I guess this
should be consumer of whatever phonebook format we give to it, as
different users may have different preferences there.

> > >There should be "ph primary" component responsible for calls and
> > >incoming SMSes -- mostly for actions not initiated by local user. On
> > >incoming events, it should play a melody. For calls, it should set up
> > >mixers, and display a window allowing user to manipulate volume,
> > >answer, reject and terminate the call. For incoming message,
> > >notification window should be displayed.
> =

> Yeah I wonder if something like this already exists.. And I wonder
> if this component should also take care of setting up clock
> alarms as at jobs or something?

While I would like to have solution for alarms and calendar, I believe
that's separate project. I do have working alarm clock in tui/10f,
but...

> For reference, here's what I'm currently using for notifications
> (droid 4 specific):
> =

> #!/bin/sh
> =

> cat /dev/motmdm1 | while read -r line; do
>         echo "${line}"
> =

>         if echo "${line}" | grep WAKEUP; then
> 		sudo rumble-test /dev/input/by-path/platform-vibrator-event 0xb000
>         fi
> done
> =

> Where rumble-test is Sebastian's tool for thw pwm-vibrator.

Hehe, quite clever :-).

> Or maybe any GUI you care to use :)

Yep, different people are starting to write more GUIs now. Hopefully
some of them survive, and hopefully we get some not needing 3d
acceleration.

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============1542151752722552293==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFseHpIc0lBQ2drUU1PZndhcFhiK3ZJMGJRQ2dyL29nTUw0dnFWNWtBUThaOXFkOGpkdTgK
WXY4QW5BekJlUTRnS3JSa0h2MWh2N2ZnSFJ5dzhZL0oKPS9pK00KLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============1542151752722552293==--

