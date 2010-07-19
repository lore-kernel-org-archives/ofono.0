Content-Type: multipart/mixed; boundary="===============0450143959679199737=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] make bluetooth.{c,h} a static library
Date: Sun, 18 Jul 2010 20:39:18 -0500
Message-ID: <4C43ACC6.9030307@gmail.com>
In-Reply-To: <1279496050.4572.16.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0450143959679199737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>> Ok, so I'll wait to continue my implementation of the DUN client. I
>> don't know the oFono internal too much to help on that decision.
> =

> I was talking about the server and not the client. For the client we
> have to have a chat about it. I might have missed parts of the initial
> discussion.
>  =


As we discussed before, the client needs settings strings to send to the
modem.  E.g. AT+CGDCONT=3Dfoobar; ATD*99***1.  oFono atoms are not setup
to do this.

>>> Also there is no need to create a static library for doing this. That is
>>> just wrong. We can do the build magic with autofoo properly and without
>>> having to use a hack with a static library.
>>
>> I meant build statically here like gatchat, without any hack with static
>> library. ;)
> =

> Actually gatchat is not build statically. It is build as part of out AT
> modem driver. That it is in separate directory is purely cosmetic.
> =


GAtChat will end up used by the core for the ppp integration.  I argued
that bluetooth should follow the same semantic, since it will be used by
both dun client daemon and oFono hfp/sap plugins.

Regards,
-Denis

--===============0450143959679199737==--

