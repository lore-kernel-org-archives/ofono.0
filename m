Content-Type: multipart/mixed; boundary="===============3741584284668150352=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] atmodem: add signal strength support for huawei
Date: Fri, 23 Apr 2010 10:53:28 -0500
Message-ID: <201004231053.28533.denkenz@gmail.com>
In-Reply-To: <87pr1qrxbw.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3741584284668150352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> >> Huawei doesn't support CIND indications, so use CSQ instead. But
> >> naturally the response from modem is not according to standard:
> >
> > is this true for all Huawei modems?
> =


CSQ is not unsolicited, so you'd need to poll it.  Not a good idea.

> >> ofonod[6401]: < \r\n^BOOT:38645652,0,0,0,87\r\n
> >> ofonod[6401]: < \r\n^RSSI:23\r\n

I suggest you simply support this ^RSSI notification, it looks like it has =
the =

same 0-31 range as CSQ.  Also, sometimes values from vendor-specific comman=
ds =

differ from CSQ, so if a query of ^RSSI is supported, use that.

> Actually I didn't check that. I'll investigate more.
> =


ModemManager has done more work integrating ppp devices, poking around ther=
e =

can get you some hints.

Regards,
-Denis

--===============3741584284668150352==--

