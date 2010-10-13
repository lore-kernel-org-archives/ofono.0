Content-Type: multipart/mixed; boundary="===============2630367956029283396=="
MIME-Version: 1.0
From: Alexander A Khryukin <alexander@mezon.ru>
Subject: Re: huawei e1550
Date: Wed, 13 Oct 2010 15:50:09 +0400
Message-ID: <1286970609.10204.3.camel@mezon.ru>
In-Reply-To: <87iq1cmtie.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2630367956029283396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

=D0=92 =D0=9F=D1=82=D0=BD, 08/10/2010 =D0=B2 21:25 +0300, Kalle Valo =D0=BF=
=D0=B8=D1=88=D0=B5=D1=82:
> Hi Alexander,
> =

> Alexander A Khryukin <alexander@mezon.ru> writes:
> =

> > =D0=92 =D0=9F=D1=82=D0=BD, 08/10/2010 =D0=B2 16:20 +0400, Alexander A K=
hryukin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> Hi all.
> >> I have a huawei 1550 GSM-modem.
> >> When i plug it to usb =

> >> =

> >> =

> =

> [...]
> =

> > Hm, now network visible but when i press "Connect" =

> > ofonod put in log that modem was removed
> > and then process still loopback
> >
> > http://pastie.org/1207567
> =

> Sorry, I wasn't able to immeadiately say from the logs what went wrong.
> Can you get a log which includes AT commands? It would help a lot.
> =

> Just run this command to get the logs:
> =

> OFONO_AT_DEBUG=3D1 /usr/sbin/ofonod -n
> =

> What's the exact version of ofono you are using? Huawei has had some
> changes lately. =

> =

> Also is the SIM configured to ask for PIN or not? I'm guessing no from
> the log, but can't be sure.
> =




Ok.I connect modem to usb-port, and log it

OFONO_AT_DEBUG=3D1 /usr/sbin/ofonod -n

http://pastie.org/1212535






--===============2630367956029283396==--

