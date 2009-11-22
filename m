Content-Type: multipart/mixed; boundary="===============4877016680344493006=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Palm Pre modem plugin
Date: Sun, 22 Nov 2009 15:21:27 +0100
Message-ID: <1258899687.8454.19.camel@localhost.localdomain>
In-Reply-To: <fb249edb0911211129gb616612q6b6b2a305de6744e@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4877016680344493006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrzej,

> > I am currently working on the implementation of
> > the basics I found out about the protocol. I split the whole code into
> > two projects: msmcommd and libmsmcomm. msmcommd is a daemon which does
> > all the link layer protocol handling which is required to speak probably
> > with the modem. The library libmsmcomm is an easy utilitiy to format
> > the different messages type and decode them on receive.
> >
> > The link layer part is nearly done. Establishment of a link should work
> > and on the handling of sending and receiving data I am currently
> > working.
> >
> > When libmsmcomm and msmcommd are done I have the plan to open from
> > fsogsmd a network channel to msmcommd and send all my telephony commands
> > to msmcommd whichs put them into link layer frames and sends them to the
> > modem.
> =

> I like the idea of libmsmcomm as a library, this means it may be easy
> in the future to make an oFono plugin linked against the library.  I
> don't think having a separate daemon and another communication channel
> between what is eventually a dialer or sms app, and the modem is such
> a good idea (with the D-Bus socket, D-Bus daemon, FSO and serial
> driver already there)

I do think that a native integration directly into the oFono source code
as msmmodem might be better. However the second daemon solution is
stupid and causes too much overhead.

Also I did look into the QMI stuff a little bit and I think we might
have to actually create a QMI subsystem in the Linux kernel like we have
for Phonet since with USB the network interface and the management
interface do share endpoints as far as I can tell so far.

Regards

Marcel



--===============4877016680344493006==--

