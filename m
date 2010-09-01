Content-Type: multipart/mixed; boundary="===============2724737967989975375=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 2/2] Add: n900modem driver
Date: Wed, 01 Sep 2010 11:32:01 +0300
Message-ID: <AANLkTinaL6nA4nCiLx4Xtg-p7NJCh7=tTRu8-X1JpUoc@mail.gmail.com>
In-Reply-To: <6741e76801885a065863f2d50dee4c50@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2724737967989975375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

2010/8/31 R=C3=A9mi Denis-Courmont <remi@remlab.net>:
> I don't understand what this code is supposed to do in the first place.
> Autoconfiguration of the Phonet stack is the kernel's job (or phonet-util=
s'
> on older kernels). This really really does not belong in oFono. That is a
> complete denial of the reasons why Phonet is a socket API, i.e. that more
> than one user-space process can use it at a time. If you want oFono to ta=
ke
> care of everything, you really should just steal the USB interface via
> libusb and/or use the raw SSI character device. Not that I'd advise doing
> so.

It does what kernel or phonet-utils are supposed to do but which they do no=
t do.

> In any case, if you need to know whether you're on SSI or USB, you should
> check the link-layer address, not the name of the interface. I do hope
> that, if and when the SSI driver goes upstream, the interface will be
> called ssi0 or mcsaab0 rather than phonet0 by the way.

When the HSI driver goes to upstream, hopefully they do the
autoconfiguration as they should do. We can use another plugin with
the new kernels.

> Then there's the GPIO lines. Ideally, the hardware specifics should be
> taken care of by the kernel.

Ideally, there should be handles on women. Or the beer glasses should be bi=
gger.

-- =

Pekka.Pessi mail at nokia.com

--===============2724737967989975375==--

