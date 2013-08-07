Content-Type: multipart/mixed; boundary="===============5484551758862716084=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PPP connection to a private APN
Date: Wed, 07 Aug 2013 18:30:49 -0500
Message-ID: <5202D8A9.7070506@gmail.com>
In-Reply-To: <C26D77B5-760B-46DF-AD1E-B598E35C7B2C@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5484551758862716084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
 >
> is your private APN really an X25 network? We would normally expect types=
 of IP, IPV6 or IPV4V6 and not plain X25. Are you asking for X25 network vi=
a AT+CGDCONT or does the network turn it into one?
>

The CGDCONT is quite clearly using an IP context type.  We don't even =

support X25 context type btw ;)

ofonod[1911]: Modem: > AT+CGDCONT=3D1,"IP","...."\r
ofonod[1911]: Modem: < \r\nOK\r\n
ofonod[1911]: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
ofonod[1911]: Modem: > AT+CGDATA=3D"PPP",1\r
ofonod[1911]: Modem: < \r\nCONNECT\r\n

Regards,
-Denis

--===============5484551758862716084==--

