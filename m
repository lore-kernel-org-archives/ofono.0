Content-Type: multipart/mixed; boundary="===============5340798919975372156=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Wed, 09 May 2018 10:48:38 +0200
Message-ID: <20180509084838.GA14533@amd>
In-Reply-To: <20180509010324.GA98604@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5340798919975372156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> > > AT+CNMI=3D1,2,2,1,0
> > < OK

> Well you can try to see what Android is doing for SMS with:
> =

> # echo 0x7fffffff > /sys/module/ts27010mux/parameters/debug_level
> # dmesg | grep ts27010 | grep AT
> =

> To send SMS, looks like Android RIL first does:
> =

> 2 AT+CMGS=3D327 where 327 seems to be the size of the whatever
> encoded message. Then the next packet to dlci 2 contains the
> encoded message that is of size 327.

Sending SMSes seems to work with ofono.

> When receiving, mdm6600 sends these on dlci 1:
> ~+WAKEUP
> ~+WAKEUP
> ~+WAKEUP
> =

> Then mdm6600 sends this on dlci 9:
> ~+CMT=3D372
> =

> And that's probably the incoming SMS size. But I don't see
> anything for what actually reads the incoming SMS.

That seems to be standard message
ftp://www.3gpp.org/tsg_t/TSG_T/TSGT_04/Docs/PDFs/TP-99129.pdf .

Do you see AT+CNMI during boot and AT+CNMA after message is received?

Thanks,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============5340798919975372156==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscnl0ZVlBQ2drUU1PZndhcFhiK3ZKeHhBQ2ZiM2ZqTXE4dnNPdWFtN3V2dlI1MFVkcC8K
MjBVQW4zRmdmTENXV1NZeTlnV09xZ0dLcmJLZFIxQUwKPWdEbVEKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============5340798919975372156==--

