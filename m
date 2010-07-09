Content-Type: multipart/mixed; boundary="===============2040523560291145304=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [SMS D-Bus 11/23] struct tx_queue_entry: add fields and destructor
Date: Thu, 08 Jul 2010 17:03:02 -0700
Message-ID: <1278633782.2327.157.camel@localhost.localdomain>
In-Reply-To: <4C366171.9010004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2040523560291145304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-07-08 at 16:38 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> On 07/08/2010 06:28 PM, Inaky Perez-Gonzalez wrote:
> > On Wed, 2010-07-07 at 16:39 -0700, Denis Kenzior wrote: =

> >> ...
> >>>> Good, can you resubmit this one separately soonish?  I'm touching th=
is
> >>>> area of the code because of Andrew's changes for STK Send SMS command
> >>>> handling.
> >>>
> >>> I'll resubmit the whole series of stuff you haven't merged yet with a=
ll
> >>> the feedback incorporated. Should be done tomorrow the latest.
> >>>
> >>
> >> The reason I'm asking is that I was about to do almost the exact same
> >> set of changes.  Tomorrow is fine though.
> > =

> > Dennis, I am running behind on this one. The commits have been
> > regenerated with the feedback you gave -- however, I picked up a bug
> > when hitting cancel when the message is in _QUEUED state and I still
> > haven't been able to tackle it. Quite hard to reproduce as the
> > transition out of _QUEUED happens quite fast; currently working on a
> > python script to automate the test.
> > =

> > If you want, I can submit with the buglet, but I'd rather *not* do that.
> > =

> =

> No worries, take your time.  Just as a heads up, I pushed some changes
> to src/sms.c today.

Grrr -- found the bug and deal with it. However, when I tried to pull
your tree to rebase on top, I got weird conflicts on stkutil.c -- don't
have time to diagnose now, but just wanted to ask: did you do a rebase?



--===============2040523560291145304==--

