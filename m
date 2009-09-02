Content-Type: multipart/mixed; boundary="===============3382756580150835769=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 14:18:50 -0700
Message-ID: <1251926330.1266.129.camel@localhost.localdomain>
In-Reply-To: <200909030010.59564.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3382756580150835769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > It's probably difficult if the PC client is allowed to redefine GPRS
> > > contexts, but otherwise oFono should at least be able to report the t=
otal
> > > tx/rx for the context's it has defined. The BT DUN / USB bridge could
> > > call into oFono and trigger a poll of all the stats to update them, e=
.g.
> > > when a BT DUN connection is disconnected.
> >
> > how should it do this if oFono is not in the mix. If you are using
> > Bluetooth DUN and point it to a virtual TTY, then you are out of look.
> > If using USB CDC ACM then same applies.
> >
> > The real solution here is Bluetooth PAN and USB CDC Ether which do
> > properly interact with the networking stack.
> =

> When we have patched all the Windows PC of the world, we can consider it.

my approach would be to try and see how far we get this pushing towards
PAN and CDC Ether :)

> In the mean time, AT+PPP emulation is required. Some modems do provide da=
ta =

> counters including that. I've seen it as a requirement that I would rathe=
r =

> have avoided but could not. It's ugly and arguably stupid, but required =

> anyway. In fact, if Ofono won't do it, ConnMan will have to, which is pro=
bably =

> by all means worse.

Actually it is worth for high-speed modems with a network interface and
no internal PPP emulation, we would have to do that emulation somewhere
in the host stack. And now my brain hurts :(

> You can argue that it should be a driver-specific feature, but it has to =
be =

> there. Hence, I would guess that more than one driver will support eventu=
ally, =

> at which point it should probably be in the common API.

We have to figure something out, but right I would prefer if we GPRS up
and running and after that tackle the statistics part. Since without
GPRS, we don't need the statistics ;)

Regards

Marcel



--===============3382756580150835769==--

