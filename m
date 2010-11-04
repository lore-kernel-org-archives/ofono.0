Content-Type: multipart/mixed; boundary="===============1138004077455455470=="
MIME-Version: 1.0
From: Frederic Crozat <fcrozat@novell.com>
Subject: Re: Huawei EM 770 not working properly
Date: Thu, 04 Nov 2010 14:40:22 +0000
Message-ID: <4CD2C5D6020000B200056D4D@vpn.id2.novell.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1138004077455455470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le jeudi 04 novembre 2010 =C3=A0 09:16 -0500, Denis Kenzior a =C3=A9crit :
> Hi Frederic,
> =

> On 11/04/2010 06:15 AM, Frederic Crozat wrote:
> > Hi,
> > =

> > I'm trying to get ofono working properly with integrated 3G card on my
> > EEE PC.
> > =

> > Card is Huawei EM 770 (12d1:1001).
> > =

> > I'm testing with ofono 0.34.
> > =

> > so far, the modem is correctly detected :
> > =

> > list-modem returns :
> > [ /huawei0 ]
> >  Features =3D sim
> >  Powered =3D 1
> >  Interfaces =3D org.ofono.SimManager
> >  Online =3D 0
> >  Model =3D EM770
> >  Manufacturer =3D huawei
> >  Serial =3D ....
> >  Revision =3D 11.104.16.12.00
> >  [ org.ofono.SimManager ] =

> >   Present =3D 0
> =

> What is happening is that oFono thinks the sim is not inserted, and it
> does not proceed further with modem initialization.  oFono polls the
> SYSINFO command, with one of the fields being the status of the SIM.
> =

> Do you have a SIM PIN set?  The current huawei driver does not handle
> this case gracefully yet, mainly because the huawei firmware is quite
> 'peculiar'.

Since I'm using SIM card from my N900, I've disabled PIN code and ofono
worked properly and I was able to connect to my 3G operator (and see it
is locking me out, because I have a 3G phone subscription and it is
seeing a modem IMEI ...).

So, next part would be to get PIN code working ;)

From other collegues who bought the same netbook, it seems umtsmon is
able to get PIN unlocking for this card.

-- =

Frederic Crozat <fcrozat@novell.com>
Novell


--===============1138004077455455470==--

