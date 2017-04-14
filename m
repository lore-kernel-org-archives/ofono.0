Content-Type: multipart/mixed; boundary="===============3728895371306016069=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/8] lte: activate default bearer on network registration
Date: Fri, 14 Apr 2017 18:18:57 -0500
Message-ID: <722bf53b-1a97-afcc-ff82-e0323102c0e7@gmail.com>
In-Reply-To: <3d6e046c-0b3b-5755-9d14-1755fe99338b@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3728895371306016069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>
> I originally implemented this as described above but have now posted a
> new series that works as you described.  It really hasn't been easy to
> understand how this all was supposed to work but what I've got now seems
> reasonable and functions well.

This is one of the most complex pieces of the stack.  It makes my brain =

hurt every time I look at it as well.

>
> One question:  ofono_gprs_notify_bearer()... why do we need this when
> netreg already provides the technology to the GPRS atom?

Many devices send out +CREG/CGREG which only reports status as 'umts'. =

It never elaborates whether the connection is utilizing  plain UMTS, =

HSUPA, HSDPA or combined HSUPA/HSDPA.  Since many carriers made a big =

deal (and special icons) for notifying the user that they're on a 'fast' =

network, we needed a convenient way of grabbing that info.

Manufacturers came up with a bunch of proprietary indications for this =

and eventually 3GPP standardized this inside 27.007 with +CPSB command. =

If you look at drivers/atmodem/gprs.c you can see some of the variants.

>
> Thanks for taking the time to help me work through all of this! Much
> appreciated.
>

Sure, thanks for doing all the work :)

Regards,
-Denis


--===============3728895371306016069==--

