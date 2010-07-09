Content-Type: multipart/mixed; boundary="===============7440697482021506056=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [SMS D-Bus 11/23] struct tx_queue_entry: add fields and destructor
Date: Fri, 09 Jul 2010 14:53:39 -0700
Message-ID: <1278712419.2327.170.camel@localhost.localdomain>
In-Reply-To: <4C375A29.6090004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7440697482021506056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-07-09 at 10:19 -0700, Denis Kenzior wrote: =

> On 07/09/2010 12:11 PM, Inaky Perez-Gonzalez wrote:
> > On Thu, 2010-07-08 at 17:22 -0700, Denis Kenzior wrote: =

> >> Inaky,
> >>
> >> ....
> >>>>
> >>>> No worries, take your time.  Just as a heads up, I pushed some chang=
es
> >>>> to src/sms.c today.
> >>>
> >>> Grrr -- found the bug and deal with it. However, when I tried to pull
> >>> your tree to rebase on top, I got weird conflicts on stkutil.c -- don=
't
> >>> have time to diagnose now, but just wanted to ask: did you do a rebas=
e? =

> >>
> >> Yep.
> > =

> > Rats. Don't. Rebase. A. Public. Tree. Please! :)
> > =

> > =

> =

> Maybe we're not talking about the same thing.  My workflow is
> =

> git commit / git am
> git fetch
> git rebase
> git push

gee, didn't see this -- well, if the rebase is changing the commit IDs,
which it probably does, then you are breaking the commit history. Would
depend on the details.

Anyway, I am not so sure that is the problem. Spent the whole day going
around it and I still couldn't figure the sucker out. Will keep trying.


--===============7440697482021506056==--

