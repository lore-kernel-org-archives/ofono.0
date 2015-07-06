Content-Type: multipart/mixed; boundary="===============3089130504552597418=="
MIME-Version: 1.0
From: Vidhya Govindan <vidhya.govindan@vvdntech.in>
Subject: Re: Support for Telt LE920 Modem in ofono
Date: Mon, 06 Jul 2015 18:20:10 +0000
Message-ID: <loom.20150706T201914-941@post.gmane.org>
In-Reply-To: <5599202D.90509@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3089130504552597418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > Hi Denis,
> >
> =

> There are two modem detection plugins at the moment.

Ours is USB based. We think that LE920 is taken care by gobi driver? Can you
please confirm?
If that is true, can we update the vendor id and product id of LE920 against
gobi driver structure?

> =

> If your modem is USB based, then plugins/udevng.c is what takes care of =

> it.  Adding a new modem subtype is generally a matter of tweaking a few =

> of the look up tables inside.  (e.g. vendor_list[], driver_list[], etc).
> =

> If you modem is using a Serial interface, then plugins/udev.c is used =

> along with a udev rule.  See doc/calypso-modem.txt for an example of this.
> =

> Regards,
> -Denis

Thanks for your quick reply. Appreciate your help in getting ofono working
with LE920.

Thanks,
Vidhya





--===============3089130504552597418==--

