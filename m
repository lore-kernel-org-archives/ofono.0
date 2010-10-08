Content-Type: multipart/mixed; boundary="===============1755019879294759456=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: huawei e1550
Date: Fri, 08 Oct 2010 21:25:29 +0300
Message-ID: <87iq1cmtie.fsf@potku.valot.fi>
In-Reply-To: <1286541821.22751.27.camel@mezon.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1755019879294759456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

Alexander A Khryukin <alexander@mezon.ru> writes:

> =D0=92 =D0=9F=D1=82=D0=BD, 08/10/2010 =D0=B2 16:20 +0400, Alexander A Khr=
yukin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Hi all.
>> I have a huawei 1550 GSM-modem.
>> When i plug it to usb =

>> =

>> =


[...]

> Hm, now network visible but when i press "Connect" =

> ofonod put in log that modem was removed
> and then process still loopback
>
> http://pastie.org/1207567

Sorry, I wasn't able to immeadiately say from the logs what went wrong.
Can you get a log which includes AT commands? It would help a lot.

Just run this command to get the logs:

OFONO_AT_DEBUG=3D1 /usr/sbin/ofonod -n

What's the exact version of ofono you are using? Huawei has had some
changes lately. =


Also is the SIM configured to ask for PIN or not? I'm guessing no from
the log, but can't be sure.

-- =

Kalle Valo

--===============1755019879294759456==--

