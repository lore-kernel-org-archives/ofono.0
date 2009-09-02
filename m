Content-Type: multipart/mixed; boundary="===============7032010500051999106=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 13:53:47 -0700
Message-ID: <1251924827.1266.118.camel@localhost.localdomain>
In-Reply-To: <200909021838.29834.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7032010500051999106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > Actually this one is missing from the API proposal.  Marcel already wan=
ted
> > the context type (internet, mms, wap, etc) information.  I've updated t=
he
> > proposed API in git.
> =

> This is not going to work.
> =

> Depending on the operator, you may have more than one "type" for a single =

> context (e.g. WAP+MMS), or worse, multiple contexts of the same type (e.g=
. =

> Internet with only Web and Internet with full IP).

we might need some extra work here and define what we want. I am
confident that we can break this down to something useful. Worst case we
something free form.

> > As discussed previously, we want oFono to manage this data, since it ca=
n do
> > this by using the IMSI.  So if you insert a different operator SIM your=
 APN
> > settings are magically updated for that operator.
> =

> I have a feeling this does not work either. If I upgrade my subscription,=
 the =

> APN may change while not the IMSI, no?

We can update these details at any time. Storing them on a per ISMI
basis is a good idea and something new that oFono does (as far as what I
have seen). So if you switch SIM cards, then you don't have to worry
about anything when traveling. It does the right thing you configured.

Especially with the devices like the Nokia netbook and the iPhone where
you can easily switch SIM cards without power on/off this will come in
handy.

If an upgrade of the subscription needs manual interaction from the user
or an operator message to update the settings, then that is fine. Since
the user did something to begin with. So they are aware of that
something changed (hope the operator told them). While just switching a
SIM card and by accident using a wrong APN and causing expensive roaming
would be a worse thing. Especially since there is an expectation from
the user when switching SIM cards.

> > > In my proposal the "Status" variable was a three-state variable,
> > > having the states "attached", "detached" and "suspended". "Suspended"
> > > was specified to mean that the GPRS was attached, but temporarily not
> > > available (for instance because of a 2G phone call or temporary loss
> > > of cellular connectivity). In the IRC discussion someone said that
> > > this property would not be part of Denis's API because the tri-state
> > > variables were bad and the "suspended" status was not supported by
> >
> > So the general rule is that if a feature isn't explicitly allowed in
> > 27.007, we do not support it.  There are exceptions to this of course. =

> > 27.007 only supports two states for context: activated and deactivated.
> =

> Our general rule is that if we have a UI requirement, or better an actual=
 use =

> case for it, we support it. Suspended GPRS fits both.

Can you share these UI requirements with us.

> > > spec 27.007. However, the problem is that Maemo 5 already has UI
> > > support for indicating that the connection is suspended, and that
> > > makes it harder to drop the feature. Could the "suspended" status enum
> > > still be left there, and just have the modems that don't support the
> > > feature to never go to "suspended" mode?
> >
> > I'd rather not.
> >
> > If this feature is really required, then some sort of heuristic can be
> > applied.  (e.g. Powered on, Attached on, but context is deactivated most
> > likely means temporary unavailability of resources)
> =

> Is this some kind of joke? Don't you know the difference between pause an=
d =

> stop on your MP3 player and between suspend to memory and power off on yo=
ur =

> computer?
> =

> Second guessing does not fit in my definition of "easy to use self-
> documenting" for an API.
> =

> > This really belong in the kernel.  Only the kernel can reliably know wh=
en a
> > network interface has been brought down and notify the interested
> > applications with the statistics.
> =

> You're missing the point.
> =

> Yes, any body can extract the statistics for a running context. But data =

> counters are cumulating. To compute the sum properly, there are but two =

> options:
> # Either the GPRS middleware requests kernel per-interface statistics rig=
ht =

> before destroying the interface, and sums with the earlier total.
> # Or the modem does it internally.
> =

> There is no way some random userland interface application can do it just=
 by =

> requesting the kernel, since it cannot know when to request those statist=
ics.

So my 2 cents here are that whatever so modem does for statistics it
should match the details its exports via the networking interface.

And on the kernel part and destroyed interface, as I mentioned, we need
to discuss this with the kernel guys. I wanna get an answer what can be
done to help us. We have most kernel guys at netconf in Portland in
three weeks and I gonna check with them.

> > Nokia hardware supports this explicitly, but many others don't.
> =

> That's irrelevant. Hardware support helps in the sense that it can includ=
e =

> statistics for contexts external to Ofono. If the hardware does not suppo=
rt =

> it, then it needs to be done manually in the GPRS middleware.
> =

> That won't make the requirement go away.

What do you expect middleware to do exactly. Our problem is that we
loose the latest state of statistics when interface destroyed. If that
can be fixed inside the kernel, why work around in user space. In case
it can not be fixed and solved to what we need then we revisit this
proposal. Until then we should put this on hold.

Regards

Marcel



--===============7032010500051999106==--

