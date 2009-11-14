Content-Type: multipart/mixed; boundary="===============7249993307100981503=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: Telit 864
Date: Sat, 14 Nov 2009 17:44:57 +0100
Message-ID: <4AFEDE89.1030401@gmail.com>
In-Reply-To: <470459.12873.qm@web63407.mail.re1.yahoo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7249993307100981503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Looks like it would work. Compile source, plugin usb cable, run export =

OFONO_AT_DEBUG=3D1 && ofonod -d -n, run enable-modem script and see if runs.

The data modem part isn't quite finished yet. Meaning you can't use pppd =

or setup a network device for the rest of the sytem to use (using GPRS, =

etc.). The rest works quite nicely.

Cheers,
Ryan

Fundu wrote:
> Hi,
> =

> this is my first post, so please excuse me if it doesn't follow some set =
rules.
> =

> Is the TELIT 864 module supported by ofono ? =

> =

> what i'm looking at is the ability to be able to communicate with the tel=
it module over serial or usb and also use it as a data modem.
> =

> any insights would be appreciated.
> =

> thanks !
> =

> fundu
> =

> =

> =

>       =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============7249993307100981503==--

