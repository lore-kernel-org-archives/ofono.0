Content-Type: multipart/mixed; boundary="===============9157963663256586082=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: GPRS support for Ofono
Date: Thu, 03 Sep 2009 00:10:59 +0300
Message-ID: <200909030010.59564.remi@remlab.net>
In-Reply-To: <1251925263.1266.124.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9157963663256586082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le jeudi 3 septembre 2009 00:01:03 Marcel Holtmann, vous avez =C3=A9crit :
> > It's probably difficult if the PC client is allowed to redefine GPRS
> > contexts, but otherwise oFono should at least be able to report the tot=
al
> > tx/rx for the context's it has defined. The BT DUN / USB bridge could
> > call into oFono and trigger a poll of all the stats to update them, e.g.
> > when a BT DUN connection is disconnected.
>
> how should it do this if oFono is not in the mix. If you are using
> Bluetooth DUN and point it to a virtual TTY, then you are out of look.
> If using USB CDC ACM then same applies.
>
> The real solution here is Bluetooth PAN and USB CDC Ether which do
> properly interact with the networking stack.

When we have patched all the Windows PC of the world, we can consider it.

In the mean time, AT+PPP emulation is required. Some modems do provide data =

counters including that. I've seen it as a requirement that I would rather =

have avoided but could not. It's ugly and arguably stupid, but required =

anyway. In fact, if Ofono won't do it, ConnMan will have to, which is proba=
bly =

by all means worse.

You can argue that it should be a driver-specific feature, but it has to be =

there. Hence, I would guess that more than one driver will support eventual=
ly, =

at which point it should probably be in the common API.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/

--===============9157963663256586082==--

