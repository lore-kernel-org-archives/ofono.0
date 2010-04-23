Content-Type: multipart/mixed; boundary="===============0736804234843432222=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH 1/3] atmodem: add signal strength support for huawei
Date: Fri, 23 Apr 2010 18:40:51 +0300
Message-ID: <87pr1qrxbw.fsf@potku.valot.fi>
In-Reply-To: <1272032579.22838.70.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0736804234843432222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Kalle,

Hi Marcel,

>> Huawei doesn't support CIND indications, so use CSQ instead. But natural=
ly
>> the response from modem is not according to standard:
>
> is this true for all Huawei modems?

I only have one modem, so I can't tell. I'll do some research and get
back on this.

>> ofonod[6401]: < \r\n^BOOT:38645652,0,0,0,87\r\n
>> ofonod[6401]: < \r\n^RSSI:23\r\n
>> =

>> Support for this format is not yet implemented.
>
> You see these on the same TTY? Normally they happen on the second TTY.

Actually I didn't check that. I'll investigate more.

-- =

Kalle Valo

--===============0736804234843432222==--

