Content-Type: multipart/mixed; boundary="===============5998650478190525840=="
MIME-Version: 1.0
From: Patrik Flykt <Patrik.Flykt@linux.intel.com>
Subject: Re: cellular reconnect
Date: Mon, 11 Jul 2016 10:13:19 +0300
Message-ID: <1468221199.2976.16.camel@linux.intel.com>
In-Reply-To: <5775366B.7020700@ilbers.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5998650478190525840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2016-06-30 at 18:10 +0300, Alexander Smirnov wrote:
> Dear all,
> =

> could you also please help me with another issue, I've observed.
> =

> What I did:
> =

> =C2=A0 - Connect cellular service in connmanctl (ppp0 appears in ifconfig)
> =C2=A0 - Disconnect physical GSM antenna (ppp0 disappears)
> =C2=A0 - Connect physical GSM antenna
> =

> After these steps I don't see cellular service (connmanctl services
> is empty) till I reset the modem.
> =

> How should I handle network strength events to automatically
> reconnect the cellular? Why I don't see cellular in connman services
> anymore?

This needs a bit more oFono debugging, as ConnMan will present all
networks provided by oFono as separate services. So if a cellular
connection does not show up in ConnMan, check what oFono is sending or
if oFono needs further setup in the case of a reconnected antenna. It
is also important to know which cellular driver is being used here.

Adding oFono mailing list to catch a wider audience.

Cheers,

	Patrik

--===============5998650478190525840==--

