Content-Type: multipart/mixed; boundary="===============6379697511445797254=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [SMS D-Bus 02/19] sms: introduce message ID API
Date: Thu, 05 Aug 2010 11:37:51 -0700
Message-ID: <1281033471.19261.108.camel@localhost.localdomain>
In-Reply-To: <4C5B0127.8050703@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6379697511445797254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-08-05 at 13:21 -0500, Denis Kenzior wrote: =

> Hi Inaky,
> =

> On 08/05/2010 01:07 PM, Inaky Perez-Gonzalez wrote:
> > On Thu, 2010-08-05 at 13:02 -0500, Denis Kenzior wrote: =

> >> Hi Inaky,
> >>
> >>>> The current message id is 32 bits.  Why are we stopping at 16?  We c=
ould
> >>>> go all the way to 64 if needed...
> >>>
> >>> Well, at the end what gets sent to the network is 16 bits right?
> >>
> >> So I think we're all confused here.  This ID is not being sent to the
> >> network.  It is only used for uniquely identifying the message over
> >> D-Bus and to message history.  This number can be as small or as big as
> >> we want.
> > =

> > I was under the impression that you wanted to use this for the ref also,
> > and thus it is imprinted into the PDUs by set_ref_and_to(). Can you
> > confirm this?
> > =

> =

> No, you're totally confused ;)  Ref is only sent on messages that are
> multi-fragment.  It is not used for single-fragment messages.  The logic
> is currently implemented per spec and I never had the intention to do it
> any other way.

Okay, so then this means that all the current ref infrastructure
(monotonically increased) is left in place and the message ID stuff is
used only internally for D-Bus and whichever other needs there are. I'll
up it to 64-bits.

> > Ok, I see your concern. Proper seeding of the RNG should take care of
> > that case, but either way works. If you want hashing + time() seeding
> > that can be done easily.
> > =

> > I still could use clarification on which other fields of the 'struct
> > sms' union you want to have hashed other than the PDU payloads.
> > =

> =

> All of them.  Again, it might be much simpler to do this over the
> fragments when they are in true PDU form.  This can be done in
> sms_assembly and tx_queue_entry_new since they deal with fragments alread=
y.
> =

> Alternatively handling the individual structure fields can be done as wel=
l.

I'll look into it.




--===============6379697511445797254==--

