Content-Type: multipart/mixed; boundary="===============0708541355097738868=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Wed, 20 Jan 2016 16:25:12 +0100
Message-ID: <87oacgff3b.fsf@nemi.mork.no>
In-Reply-To: <CADnUhn1DZzkaO7wo2f7OpxA+F+mNF96XwGiS-O_Fh8svADxgwQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0708541355097738868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

matti kaasinen <matti.kaasinen@gmail.com> writes:

> Hi,
> I tried other modem with same type. It worked exactly the same, so this
> should not be related to broken modem or corrupted firmware. What else
> could I try?
>
> Bj=C3=B8rn, is there something missing in initialization?

I don't think so. It all looks OK to me.  It's just the AT^DHCP?
response which is a bit unexpected.  IIUC, the modem LEDs indicate a
connection?  What about "AT^NDISDUP?" ?

Did you try a DHCP client?  Maybe this firmware doesn't implement the
AT^DHCP command but has a DHCP server?

> Is there something wrong with firmware?

That would depend on the definition of "right" :)

Huawei can do pretty much what they want since the functions are vendor
specific.  They are probably happy as long as the firmware matches the
Windows driver+application.  But usually they are pretty good at making
consistent interfaces across different firmware code bases, so the
unusual AT^DHCP? response is unexpected and might be considered a bug.

> Is there any chance switching modem to HiLink mode (=3D using cdc_ether) =
like
> the older versions did?
> Would it be possible by downgrading firmware or by usb_modeswitch?

I am guessing the answers are "yes" to all those questions.  But I don't
know how...

> If all the answers are no, I suppose I need to switch to for instance to
> ModemManager or ppp without any managers.

If MM can connect, then oFono should be able to as well.  I see that you
didn't find any AT^NDISDUP command in the MM log.  Did it by any chance
use PPP?  Or was there something else going on?



Bj=C3=B8rn

--===============0708541355097738868==--

