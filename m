Content-Type: multipart/mixed; boundary="===============3691934019780551222=="
MIME-Version: 1.0
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v0] Read EF_ICCID property of SIM
Date: Tue, 27 Apr 2010 18:06:50 +0200
Message-ID: <20100427160650.GC18877@pc0043.bmw-carit.intra>
In-Reply-To: <201004271053.34881.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3691934019780551222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > > It's a Option iCON 451. I didn't check what "\r\r\n+CRSM:
> > > 144,0,"03"\r\n\r\nOK\r\n" exaclty means. I guess I have to check the
> > > standard.
> > =

> > (of course I did copy the wrong line)
> > =

> > ofonod[18879]: Control:< \r\r\n+CRSM: 111,0\r\n\r\nOK\r\n
> > =

> =

> Yes the Option Modems always return +CRSM: 111 -> Unspecified Error whene=
ver we =

> use 'GET RESPONSE'.  It seems that this function is simply not implemente=
d in =

> their firmware, even though reading files directly from the SIM (in the c=
ase of =

> EFphase or EFiccid) seems to work.

Aside from the Option modem I have a Huawei E160 around for testing:

ofonod[19115]: > AT+CRSM=3D192,12258\r
ofonod[19115]: < AT+CRSM=3D192,12258\r
ofonod[19115]: < \r\n+CME ERROR: SIM PIN required\r\n

Looks like it doesn't like the 'GET RESPONSE' either.

> Unfortunately, with a few exceptions, we actually need to call 'GET RESPO=
NSE' =

> first to find the record size / file size before we can attempt to read t=
he file.  =

> One way to do this might be to use +CSIM to walk the EF tree, but that is =

> quite nasty.

To be honest I have not the slighest idea what you mean :) =


> This needs to be fixed for the Option driver.  Perhaps someone here knows=
 a =

> way...

Well, if some one tells me what to do I work on it. But I'm a bit lost
without help.

cheers,
daniel

--===============3691934019780551222==--

