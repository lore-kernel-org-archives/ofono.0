Content-Type: multipart/mixed; boundary="===============8803078945430449218=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Palm Pre modem plugin
Date: Sun, 22 Nov 2009 23:56:05 +0100
Message-ID: <1258930565.2993.3.camel@violet>
In-Reply-To: <20091122204744.GA4141@nirvana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8803078945430449218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Morphis,

> > > > I am currently working on the implementation of
> > > > the basics I found out about the protocol. I split the whole code i=
nto
> > > > two projects: msmcommd and libmsmcomm. msmcommd is a daemon which d=
oes
> > > > all the link layer protocol handling which is required to speak pro=
bably
> > > > with the modem. The library libmsmcomm is an easy utilitiy to format
> > > > the different messages type and decode them on receive.
> > > >
> > > > The link layer part is nearly done. Establishment of a link should =
work
> > > > and on the handling of sending and receiving data I am currently
> > > > working.
> > > >
> > > > When libmsmcomm and msmcommd are done I have the plan to open from
> > > > fsogsmd a network channel to msmcommd and send all my telephony com=
mands
> > > > to msmcommd whichs put them into link layer frames and sends them t=
o the
> > > > modem.
> > > =

> > > I like the idea of libmsmcomm as a library, this means it may be easy
> > > in the future to make an oFono plugin linked against the library.  I
> > > don't think having a separate daemon and another communication channel
> > > between what is eventually a dialer or sms app, and the modem is such
> > > a good idea (with the D-Bus socket, D-Bus daemon, FSO and serial
> > > driver already there)
> > =

> > I do think that a native integration directly into the oFono source code
> > as msmmodem might be better. However the second daemon solution is
> > stupid and causes too much overhead.
> > =

> > Also I did look into the QMI stuff a little bit and I think we might
> > have to actually create a QMI subsystem in the Linux kernel like we have
> > for Phonet since with USB the network interface and the management
> > interface do share endpoints as far as I can tell so far.
> =

> Whats QMI? Never heard about it.

if you look through the Windows drivers and some of the .inf files, you
find the QMI and most likely it means Qualcomm Management Interface. And
there is also QMUX which is kind of a multiplexer similar to what Phonet
does for the Nokia protocol. The QMI is similar to ISI from Nokia.

Look through the MSM stuff from the Android kernel tree since they are
also using some of these terms. And I guess all MSM modems are similar
one way or the other.

Regards

Marcel



--===============8803078945430449218==--

