Content-Type: multipart/mixed; boundary="===============6234104431085677204=="
MIME-Version: 1.0
From: Fundu <fundu_1999@yahoo.com>
Subject: Re: Telit 864
Date: Mon, 16 Nov 2009 15:53:03 -0800
Message-ID: <212294.47471.qm@web63406.mail.re1.yahoo.com>
In-Reply-To: <4AFEDE89.1030401@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6234104431085677204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks Ryan !

so let me ask this then what's involved in getting data modem part working ?

I can help a on that. Don't know what would be involved in that.

My area of comfort.
1) C =

2) linux drivers
3) fair understanding of the telit AT command set.

not familiar with pppd and wonder how that would play into the picture ?

-fundu =



----- Original Message ----
From: Ryan Raasch <ryan.raasch@gmail.com>
To: ofono(a)ofono.org
Sent: Sat, November 14, 2009 8:44:57 AM
Subject: Re: Telit 864

Looks like it would work. Compile source, plugin usb cable, run export OFON=
O_AT_DEBUG=3D1 && ofonod -d -n, run enable-modem script and see if runs.

The data modem part isn't quite finished yet. Meaning you can't use pppd or=
 setup a network device for the rest of the sytem to use (using GPRS, etc.)=
. The rest works quite nicely.

Cheers,
Ryan

Fundu wrote:
> Hi,
> =

> this is my first post, so please excuse me if it doesn't follow some set =
rules.
> =

> Is the TELIT 864 module supported by ofono ? =

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

>       _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono



     =20

--===============6234104431085677204==--

