Content-Type: multipart/mixed; boundary="===============8112689692115509201=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Problem configuring Longsung U6300
Date: Mon, 24 Jan 2011 16:14:08 +0100
Message-ID: <1295882048.2676.36.camel@aeonflux>
In-Reply-To: <4D3D912D.1080404@intes.od.ua>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8112689692115509201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > I have a little question - which driver should I use for modem Longsung
> > U6300 based on Qualcomm MSM6290? I know that Huawei uses qualcomm chips,
> > so I tried to add udev rule like for huawei modem, but it did not work.
> > list-modes shows modem (online=3D0, powered=3D0, lockdown=3D0), but
> > enable-modem fails  with timeout exception. vendorId - 1c9e, productId -
> > 9603.
> > Could you help me, please?
> >   =

> On irc channel ZTE driver was proposed and it works quite good.

we can either re-use ZTE driver or write a new one for these. However
until I have access to these devices it becomes pretty hard.

I tried to buy some of these while being in Japan last time, but they
always try to tie you into contracts. We do have a proper collection for
North America and European specific models, but I do like to get a set
of Asian examples. So if anybody wants to donate some of these, please
let us know.

Adding support for these dongles is pretty simple once you figured out
their quirks since all Qualcomm ones are broken one way or another. They
all use outdated firmware. At least that is my experience.

Regards

Marcel



--===============8112689692115509201==--

