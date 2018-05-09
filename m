Content-Type: multipart/mixed; boundary="===============1370282064711959193=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Wed, 09 May 2018 08:03:20 -0500
Message-ID: <04c1e128-9094-cdc0-97f3-abd7cacea1d9@gmail.com>
In-Reply-To: <20180509081820.GC10423@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1370282064711959193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

<snip>

> PDU Len 2, strlen 4
> PDU last char 48
> 0000^ZCNMA=3D1,2
> <PR
> 0000^ZCNMA=3D1,2
> < +CMS ERROR: 304
> ofonod[3057]: CNMA acknowledgement failed: Further SMS reception is
> not guaranteed
> < +CIEV: 1,4
> =

> Modem does not like our CNMA acknowledgement. AFAICT, we are sending
> =

> AT+CNMA=3D1,2
> 0000^Z

That looks correct.  In fact that logic has been working for something =

like 8-9 years, but it doesn't hurt to be paranoid and double check.

> =

> If I attempt to do AT+CNMA=3D1, AT+CNMA=3D0 or just plain At=3DCNMA, it d=
oes
> not like that, either, but with +CMS ERROR: 500.

CNMA=3D1 is required to work in PDU mode according to 27.005 btw.  How abou=
t:

window.open();
window.throw(modem);

Regards,
-Denis

--===============1370282064711959193==--

