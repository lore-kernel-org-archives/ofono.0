Content-Type: multipart/mixed; boundary="===============2389260721328456868=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: Palm Pre modem plugin
Date: Sat, 21 Nov 2009 20:29:41 +0100
Message-ID: <fb249edb0911211129gb616612q6b6b2a305de6744e@mail.gmail.com>
In-Reply-To: <20091121101445.GA4375@nirvana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2389260721328456868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/11/21  <morphis@gravedo.de>:
> I am currently working on the implementation of
> the basics I found out about the protocol. I split the whole code into
> two projects: msmcommd and libmsmcomm. msmcommd is a daemon which does
> all the link layer protocol handling which is required to speak probably
> with the modem. The library libmsmcomm is an easy utilitiy to format
> the different messages type and decode them on receive.
>
> The link layer part is nearly done. Establishment of a link should work
> and on the handling of sending and receiving data I am currently
> working.
>
> When libmsmcomm and msmcommd are done I have the plan to open from
> fsogsmd a network channel to msmcommd and send all my telephony commands
> to msmcommd whichs put them into link layer frames and sends them to the
> modem.

I like the idea of libmsmcomm as a library, this means it may be easy
in the future to make an oFono plugin linked against the library.  I
don't think having a separate daemon and another communication channel
between what is eventually a dialer or sms app, and the modem is such
a good idea (with the D-Bus socket, D-Bus daemon, FSO and serial
driver already there)

Regards

--===============2389260721328456868==--

