Content-Type: multipart/mixed; boundary="===============8124794947676308499=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Wed, 09 May 2018 15:38:21 +0200
Message-ID: <20180509133821.GA23230@amd>
In-Reply-To: <20180509133506.GX77069@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8124794947676308499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > AT+CNMI=3D1,2,2,1,0
> > > > < OK
> > =

> > > Well you can try to see what Android is doing for SMS with:
> > > =

> > > # echo 0x7fffffff > /sys/module/ts27010mux/parameters/debug_level
> > > # dmesg | grep ts27010 | grep AT
> > > =

> > > To send SMS, looks like Android RIL first does:
> > > =

> > > 2 AT+CMGS=3D327 where 327 seems to be the size of the whatever
> > > encoded message. Then the next packet to dlci 2 contains the
> > > encoded message that is of size 327.
> > =

> > Sending SMSes seems to work with ofono.
> =

> OK is this over ttyUSB or ngsm port?

ttyUSB. ngsm port behaves too strangely for me.

> > > When receiving, mdm6600 sends these on dlci 1:
> > > ~+WAKEUP
> > > ~+WAKEUP
> > > ~+WAKEUP
> > > =

> > > Then mdm6600 sends this on dlci 9:
> > > ~+CMT=3D372
> > > =

> > > And that's probably the incoming SMS size. But I don't see
> > > anything for what actually reads the incoming SMS.
> =

> Hmm it occured to me that maybe the incoming messages are read
> using QMI over USB.
> =

> > That seems to be standard message
> > ftp://www.3gpp.org/tsg_t/TSG_T/TSGT_04/Docs/PDFs/TP-99129.pdf .
> > =

> > Do you see AT+CNMI during boot and AT+CNMA after message is received?
> =

> I'm only seeing AT+CNMA=3D0,0 on dlci 9 after resume. I think that is
> used to query for new messages.
> =

> No CNMI in my logs it seems. But if QMI over USB is used to read
> the messages that would explain it only checks for new SMS.

Thanks for info. No real leads there :-(.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============8124794947676308499==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscnkrYzBBQ2drUU1PZndhcFhiK3ZJQnlnQ2dydzl5YldPd2Q0L0h0MUR1dEVObjdmRVAK
WE4wQW4xeUpLaEJLNWdjMXlxdDl6YzZsdTczRmsxOTIKPTh5OFMKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============8124794947676308499==--

