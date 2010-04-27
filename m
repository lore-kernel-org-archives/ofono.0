Content-Type: multipart/mixed; boundary="===============4313663407127151497=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0] Read EF_ICCID property of SIM
Date: Tue, 27 Apr 2010 10:53:34 -0500
Message-ID: <201004271053.34881.denkenz@gmail.com>
In-Reply-To: <20100427154644.GB18877@pc0043.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4313663407127151497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> > It's a Option iCON 451. I didn't check what "\r\r\n+CRSM:
> > 144,0,"03"\r\n\r\nOK\r\n" exaclty means. I guess I have to check the
> > standard.
> =

> (of course I did copy the wrong line)
> =

> ofonod[18879]: Control:< \r\r\n+CRSM: 111,0\r\n\r\nOK\r\n
> =


Yes the Option Modems always return +CRSM: 111 -> Unspecified Error wheneve=
r we =

use 'GET RESPONSE'.  It seems that this function is simply not implemented =
in =

their firmware, even though reading files directly from the SIM (in the cas=
e of =

EFphase or EFiccid) seems to work.

Unfortunately, with a few exceptions, we actually need to call 'GET RESPONS=
E' =

first to find the record size / file size before we can attempt to read the=
 file.  =

One way to do this might be to use +CSIM to walk the EF tree, but that is =

quite nasty.

This needs to be fixed for the Option driver.  Perhaps someone here knows a =

way...

Regards,
-Denis

--===============4313663407127151497==--

