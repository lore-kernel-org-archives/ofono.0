Content-Type: multipart/mixed; boundary="===============3569372364853118727=="
MIME-Version: 1.0
From: Max <Max.Suraev@fairwaves.ru>
Subject: Re: scan problem
Date: Fri, 20 Apr 2012 20:50:08 +0800
Message-ID: <4F915B80.1000105@fairwaves.ru>
In-Reply-To: <ED4DEEB78293B34A9D0EAC02A474A46E18AA2B78@IRSMSX102.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3569372364853118727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

20.04.2012 20:00, Aygon, Bertrand =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BB:

> So your modem doesn't reply to the first AT command sent.
> =

> Can you try to open one of the many /dev/ttyUSB1 to /dev/ttyUSB16 using m=
inicom and send some AT command to see if you got an answer?

Doh! You're right - the minicom just hangs. I'll try to contact vendor with=
 my
sincere wtf :)
In a mean time - should I file FR for more descriptive error handling in of=
ono? It
would be way more convenient if absence of AT-command response from modem w=
ill be
reported as such and not as some cryptic python message.

thanks for help anyway,
Max.


--===============3569372364853118727==--

