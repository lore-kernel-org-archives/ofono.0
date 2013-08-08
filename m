Content-Type: multipart/mixed; boundary="===============3214881849176565195=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: PPP connection to a private APN
Date: Wed, 07 Aug 2013 18:03:59 -0700
Message-ID: <6F707C80-7C17-41B2-8B06-0CD95FB086F9@holtmann.org>
In-Reply-To: <5202D8A9.7070506@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3214881849176565195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> is your private APN really an X25 network? We would normally expect type=
s of IP, IPV6 or IPV4V6 and not plain X25. Are you asking for X25 network v=
ia AT+CGDCONT or does the network turn it into one?
>> =

> =

> The CGDCONT is quite clearly using an IP context type.  We don't even sup=
port X25 context type btw ;)
> =

> ofonod[1911]: Modem: > AT+CGDCONT=3D1,"IP","...."\r
> ofonod[1911]: Modem: < \r\nOK\r\n
> ofonod[1911]: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
> ofonod[1911]: Modem: > AT+CGDATA=3D"PPP",1\r
> ofonod[1911]: Modem: < \r\nCONNECT\r\n

maybe SIM Toolkit is turning this into an X25 connection ;)

Or the modem firmware is fully confused and not able to handle this. Time t=
o try this with a different modem. For example an Ericsson MBM or Qualcomm =
QMI.

Regards

Marcel


--===============3214881849176565195==--

