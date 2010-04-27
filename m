Content-Type: multipart/mixed; boundary="===============9193915724490410943=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0] Read EF_ICCID property of SIM
Date: Tue, 27 Apr 2010 11:19:28 -0500
Message-ID: <201004271119.28849.denkenz@gmail.com>
In-Reply-To: <20100427160650.GC18877@pc0043.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9193915724490410943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> Hi Denis,
> =

> > > > It's a Option iCON 451. I didn't check what "\r\r\n+CRSM:
> > > > 144,0,"03"\r\n\r\nOK\r\n" exaclty means. I guess I have to check the
> > > > standard.
> > >
> > > (of course I did copy the wrong line)
> > >
> > > ofonod[18879]: Control:< \r\r\n+CRSM: 111,0\r\n\r\nOK\r\n
> >
> > Yes the Option Modems always return +CRSM: 111 -> Unspecified Error
> > whenever we use 'GET RESPONSE'.  It seems that this function is simply
> > not implemented in their firmware, even though reading files directly
> > from the SIM (in the case of EFphase or EFiccid) seems to work.
> =

> Aside from the Option modem I have a Huawei E160 around for testing:
> =

> ofonod[19115]: > AT+CRSM=3D192,12258\r
> ofonod[19115]: < AT+CRSM=3D192,12258\r
> ofonod[19115]: < \r\n+CME ERROR: SIM PIN required\r\n
> =

> Looks like it doesn't like the 'GET RESPONSE' either.
> =

> =


There are two possibilities here:
	- The SIM is not per spec and actually requires PIN to be entered before =

reading the EFiccid
	- The Huawei firmware is not per spec and blocks the reading of EFiccid be=
fore =

the SIM PIN has been entered

Since you managed to read the EFiccid on the Option hardware, I assume that =

this is a Huawei firmware bug...

Not really oFono's fault, welcome to the wonderful world of GSM hardware.  =
Get =

yourself an MBM F3507/F3607, their firmware usually gets this right...

> > This needs to be fixed for the Option driver.  Perhaps someone here kno=
ws
> > a way...
> =

> Well, if some one tells me what to do I work on it. But I'm a bit lost
> without help.

Me too ;)

Regards,
-Denis

--===============9193915724490410943==--

