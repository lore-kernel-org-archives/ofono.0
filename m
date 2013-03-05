Content-Type: multipart/mixed; boundary="===============2091520660108301233=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] sierra: Support CDMA modems
Date: Tue, 05 Mar 2013 14:52:09 -0600
Message-ID: <51365AF9.6040600@gmail.com>
In-Reply-To: <20130305193619.GK11149@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2091520660108301233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Forest,

>>> I'm looking to pick this series back up now.  I understand the implemen=
tation is
>>> not ideal, but it at least provides for basic connectivity until we hav=
e support
>>> for the CnS protocol.  Will you accept the full series if I address the=
 other
>>> issues with the code that you mentioned?
>>
>> If we accept something upstream we assume full responsibility for
>> the code, and everything that entails, including future maintenance.
>> Thus we do not have a habit of accepting functionality that is
>> inherently broken.  So unless you can convince me otherwise, my
>> answer is: "I'd rather not" ;)
>
> Well I think the argument to make is that we ought to be able to graceful=
ly
> degrade to handle a device that we have limited support for.  We know how=
 to
> bring up a connection on this device.  I think users would prefer to have=
 a
> device that works with a limited feature set than one that doesn't work a=
t all.

Don't get me wrong, we do want to enable as many devices as possible... =

The problem is that the oFono clients do not know when the device is in =

'degraded' mode.  Our assumption was that we always have multiple AT =

ports available or we are using high-speed interfaces.  If the AT chat =

is blocked by PPP, then we can't even get basic things like signal =

strength notifications while on a data connection.  To me that is =

unacceptable, especially since we know that any AT command based =

implementation is a long-term dead end.

>
> Anyway, I notice that one of the ports appears to be QCDM.  It appears th=
at QCDM
> support is partially implemented in oFono?  But I don't know QCDM at all.=
  Can
> we use it to do netreg?

oFono QCDM support is quite bare, not much beyond a test tool. =

Contributions are always welcome!

>
> If not, I could probably implement (partial) CnS support at some point.  =
I'm
> just not sure I will have time to do it right away.
>

That would be great.

> I assume a proper netreg implementation on one of these other ports would
> address your primary concern?

Yep, correct.

>
> Thanks,
> Forest

Regards,
-Denis

--===============2091520660108301233==--

