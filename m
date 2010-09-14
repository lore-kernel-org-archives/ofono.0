Content-Type: multipart/mixed; boundary="===============0122247977669418173=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [online-impl-v2 PATCH 00/10] implement Online property
Date: Wed, 15 Sep 2010 06:30:27 +0900
Message-ID: <1284499827.2405.67.camel@localhost.localdomain>
In-Reply-To: <AANLkTinNFDnPKe5dNniR7thus-6TtacO5EoJCBQT=FKo@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0122247977669418173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> > STE version needs testing by the STE guys, but I did run into some SIM
> > not ready issues with MBM when switching online/offline a few times. So
> > that needs to be looked into.
> =

> Please have a peek in your AT log and see if there are some spurious
> +GCAP: lines? My Dell 5530 branded MBM apparently sends internal
> AT+GCAP command. Command and its results gets echoed to the serial
> port which obviously confuses the AT parser. Perhaps most MBMs would
> benefit from registering dummy "+GCAP:".

that is clearly not with mine. I have the MBM original and the Lenovo
branded ones which are not branded at all actually. So these behave
properly and no +GCAP in between.

> > The Huawei has more and more issues with SIM not ready now. This needs
> > fixing anyway. I pushed the patch anymore to make these symptoms more
> > clear to everybody.
> =

> I'll try to remember to fish out my Huawei from the junk box and see
> what it has to offer now. ;)

I have like 5 different Huawei models now. I just didn't have the time
to dig into this to get it fixed. Basically the online mode support show
the same symptoms than plugging in the modem while ofonod is already
running. So the SIM ready support needs a bit of re-work I assume.

Regards

Marcel



--===============0122247977669418173==--

