Content-Type: multipart/mixed; boundary="===============0993970252191424761=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Wed, 09 May 2018 10:41:44 -0500
Message-ID: <590d180f-f7ab-abcc-2bd9-93cb22905381@gmail.com>
In-Reply-To: <20180509151103.GB28193@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0993970252191424761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

>>> If I attempt to do AT+CNMA=3D1, AT+CNMA=3D0 or just plain At=3DCNMA, it=
 does
>>> not like that, either, but with +CMS ERROR: 500.
>>
>> CNMA=3D1 is required to work in PDU mode according to 27.005 btw.  How a=
bout:
>>
>> window.open();
>> window.throw(modem);
> =

> Heh :-). Well, there are two phones with reasonable Linux support:
> N900 and Droid 4. N900 can't do voice calls of reasonable
> quality. That leaves Droid 4... so I'd really like it to work.

Is this actually an AT command modem or one of those modems where AT =

commands were only bolted on for carrier certification?  Does it support =

QMI or something maybe?

> =

> Afaict.. In PDU mode we need either +CNMA, which is broken, or CMTI,
> which reports '+CMTI: "ME",-1' which I assume is broken, too.
> =

> Is there chance that '+CMTI: "ME",-1' can be understood as '+CMTI:
> "ME",1' ?

ITU v.250, Section 5.3.1:
< number>
may be a string of one or more characters from "0" through "9" =

representing a decimal integer value. Commands that expect a < number>
are noted in the description of the command (see clause 6).

So strictly speaking negative numbers are not allowed.  But who reads =

specs anyway for something as unimportant as a communications device =

that lives might depend on.

Regards,
-Denis

--===============0993970252191424761==--

