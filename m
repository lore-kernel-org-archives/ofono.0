Content-Type: multipart/mixed; boundary="===============0713062902310444671=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Add Support for Sierra MC73xx
Date: Fri, 29 Apr 2016 10:44:16 -0500
Message-ID: <57238150.4050901@gmail.com>
In-Reply-To: <57237FE0.2050701@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0713062902310444671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

>>
>> If this is a QMI card, then setup_sierra isn't the right place for
>> this detection.  It should likely be setup_gobi.
>
> Yes, you're right. It came from Bj=C3=B8rn Mork's patches who did this pa=
tch :
>
> https://lists.ofono.org/pipermail/ofono/2013-February/014239.html
>
> The "gobi" driver is plugged "manually" by ofono_modem_set_driver function
>
> This card is mainly QMI but also have Diag, NMEA and AT interfaces
> (ttyUSB). I think that's why he did it in setup_sierra.
>

What is the AT interface capable of?  Can this modem be driven using AT =

commands instead?  Would certainly be easier to debug.

>>
>> Your modem doesn't seem to want to read anything from the SIM.  So
>> that is why your gprs isn't showing up.
>>
>> Do you have a SIM in there or a PIN set?
>
>
> OK, so I understand that Data feature is detected by scanning SIM
> capabilities + chip capabilities (UMTS, LTE, ...)
> Am I right ?

Sort of.  oFono is a full telephony stack, so we expect the basics to be =

provided.  IMSI availability tells us that the SIM has been initialized =

to the point that it is useable.  E.g. PIN has been unlocked/entered.

>
> My SIM doesn't have PIN and I can use Standard QMI tools (libqmi) to
> bring up a connection.
> I will so investigate around SIM QMI requests / replies.

Are sim operations supported / working on this modem with libqmi?

Regards,
-Denis

--===============0713062902310444671==--

