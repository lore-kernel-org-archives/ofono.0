Content-Type: multipart/mixed; boundary="===============7591071450117898554=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: Trouble using Huwei E160G
Date: Wed, 06 Apr 2011 08:36:42 +0000
Message-ID: <0E7E5CACD8E9F248AA009C292CC772A048E3ED@ALA-MBA.corp.ad.wrs.com>
In-Reply-To: <4D9C1388.6070903@zirak.it>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7591071450117898554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Claudio,

> I have made the test proposed, I still recive the same error :)

ofonod[2329]: drivers/atmodem/gprs-context.c:at_gprs_context_probe() =

ofonod[2329]: Missing support for TUN/TAP devices

It seems you device doesn't support TUN/TAP. at_gprs_context_probe return -=
ENODEV,
So it cause the gprs context driver is not set (ofono_gprs_context->driver =
is NULL).

> Any suggestion ?

Remove TUN checking code, in drivers/atmodem/gprs-context.c:at_gprs_context=
_probe()

Hope it help.

Caiwen

--===============7591071450117898554==--

