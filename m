Content-Type: multipart/mixed; boundary="===============0848219442638149284=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 04:03:05 -0700
Message-ID: <1251889385.1266.60.camel@localhost.localdomain>
In-Reply-To: <a32762a20909020343x2c90cdeege6185b6dd5c5b1b3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0848219442638149284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >> personally I don't care who finally sets the IP for the interface. It
> >> really just makes no difference. What problem do you see if oFono would
> >> set the IP address on that newly created interface that is up and
> >> running now?
> >
> > Then the application cannot influence the way it's done. That's the who=
le
> > point. Maybe I want to migrate the interface in a new namespace. For th=
at,
> > it must (1) create the interface, (2) migrate it, (3) configure it, in =
that
> > order. So Ofono cannot do (3) if it cannot do (2), and it certainly sho=
uld
> > not do (2) by itself. So it has to stick to (1).
> =

> And this generally applies to services that operators have decided to
> run behind a dedicated APN, such as WAP, MMS, Push over Cellular (PoC)
> and others. For example, Elisa in Finland seems to be running their
> MMSC behind an "mms" APN, with public IP address space, but firewalled
> from the rest of the Internet. oFono should isolate such an access
> from the rest of the system, since only the MMS client would know how
> to work with it properly.

if they are doing something nasty like that, then the only real solution
is network namespaces. This means we can just bring the interface up and
then have to give all networking details via D-Bus properties. Actually
we might should not even bring the network interface up, but it might be
tricky with PPP or the HSO point-to-point stuff.

Regards

Marcel



--===============0848219442638149284==--

