Content-Type: multipart/mixed; boundary="===============3572236222216504793=="
MIME-Version: 1.0
From: morphis@gravedo.de
Subject: Re: Palm Pre modem plugin
Date: Sun, 22 Nov 2009 21:47:44 +0100
Message-ID: <20091122204744.GA4141@nirvana>
In-Reply-To: <1258899687.8454.19.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3572236222216504793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2009 at 03:21:27PM +0100, Marcel Holtmann wrote:
> Hi Andrzej,
> =

> > > I am currently working on the implementation of
> > > the basics I found out about the protocol. I split the whole code into
> > > two projects: msmcommd and libmsmcomm. msmcommd is a daemon which does
> > > all the link layer protocol handling which is required to speak proba=
bly
> > > with the modem. The library libmsmcomm is an easy utilitiy to format
> > > the different messages type and decode them on receive.
> > >
> > > The link layer part is nearly done. Establishment of a link should wo=
rk
> > > and on the handling of sending and receiving data I am currently
> > > working.
> > >
> > > When libmsmcomm and msmcommd are done I have the plan to open from
> > > fsogsmd a network channel to msmcommd and send all my telephony comma=
nds
> > > to msmcommd whichs put them into link layer frames and sends them to =
the
> > > modem.
> > =

> > I like the idea of libmsmcomm as a library, this means it may be easy
> > in the future to make an oFono plugin linked against the library.  I
> > don't think having a separate daemon and another communication channel
> > between what is eventually a dialer or sms app, and the modem is such
> > a good idea (with the D-Bus socket, D-Bus daemon, FSO and serial
> > driver already there)
> =

> I do think that a native integration directly into the oFono source code
> as msmmodem might be better. However the second daemon solution is
> stupid and causes too much overhead.
> =

> Also I did look into the QMI stuff a little bit and I think we might
> have to actually create a QMI subsystem in the Linux kernel like we have
> for Phonet since with USB the network interface and the management
> interface do share endpoints as far as I can tell so far.

Whats QMI? Never heard about it.

--===============3572236222216504793==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWtzSm8zQUFDZ2tRcWxpNGFTWGl3TStHdkFDZlQwSlVoaDI3
ak5WNUtVOTZwQ2RzdnkrSwpCME1Bb0o2eEJ5enJrWVVNcWMybi9yb0ZqaU13NWh4bAo9dENONQot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============3572236222216504793==--

