Content-Type: multipart/mixed; boundary="===============1550321599901930124=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH 1/3] atmodem: add signal strength support for huawei
Date: Mon, 26 Apr 2010 13:45:54 +0300
Message-ID: <87d3xmsd99.fsf@potku.valot.fi>
In-Reply-To: <201004231053.28533.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1550321599901930124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Kalle,

Hi Denis,

>> >> Huawei doesn't support CIND indications, so use CSQ instead. But
>> >> naturally the response from modem is not according to standard:
>> >
>> > is this true for all Huawei modems?
>> =

>
> CSQ is not unsolicited, so you'd need to poll it.  Not a good idea.

Agreed.

>> >> ofonod[6401]: < \r\n^BOOT:38645652,0,0,0,87\r\n
>> >> ofonod[6401]: < \r\n^RSSI:23\r\n
>
> I suggest you simply support this ^RSSI notification, it looks like it
> has the same 0-31 range as CSQ. Also, sometimes values from
> vendor-specific commands differ from CSQ, so if a query of ^RSSI is
> supported, use that.

I'll do that.

Thank you for the help.

-- =

Kalle Valo

--===============1550321599901930124==--

