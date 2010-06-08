Content-Type: multipart/mixed; boundary="===============3202658053964873814=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Huawei E1552 broken
Date: Tue, 08 Jun 2010 13:34:56 -0700
Message-ID: <1276029296.2182.51.camel@localhost.localdomain>
In-Reply-To: <87mxv5zte0.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3202658053964873814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> >> I mentioned this briefly on irc, but I'll inform it here as well. This
> >> patch broke ofono support for my Huawei E1552:
> >> =

> >> commit 6ab0b6f29acc8f6b2a5f3b94c02c405ee7318244
> >> Author: Marcel Holtmann <marcel@holtmann.org>
> >> Date:   Sun Jun 6 15:51:36 2010 -0700
> >> =

> >>    Fix detection of Huawei E220 and E270 modems
> >> =

> >> Huawei plugin uses /dev/ttyUSB1 for the event channel but for my modem
> >> it should be /dev/ttyUSB2. We need to solve this problem somehow, even
> >> if we need to add usb ids to ofono.rules.
> >
> > Denis has already updated udev.c by commit 71ea72adf and now it
> > detects interface number by ofono.rules.
> =

> Oh damn, I forgot to do git update this morning and missed this
> altogether. Thank you for pointing out this.
> =

> > So I think you should add one more E1552 specific item in ofono.rules
> > with your product id and interface number, etc.
> =

> Actually Denis already added them. Excellent, thank you Denis! My modem
> works again :)
> =

> But now connman doesn't show the operator name "Saunalahti" anymore, the
> name property in connman Service is just empty:
> =

> ./cmcc show cellular_244053111242822_huawei0_primarycontext1
> AutoConnect: true
> Name: =

> Nameservers: { 193.229.0.40 193.229.0.42 }
> Proxy: { Method=3Ddirect }

this might be a bug in the oFono plugin in ConnMan. I have encountered
this as well. I think ConnMan forgets to listen to name changes and to
update the name. Some times you get the name other times you don't.

Regards

Marcel




--===============3202658053964873814==--

