Content-Type: multipart/mixed; boundary="===============6253089627563195264=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH 1/3] gemalto: add radio-settings driver
Date: Thu, 15 Jul 2021 22:01:52 +0300
Message-ID: <YPCGIIuYLM2Loc7W@curiosity>
In-Reply-To: <2a42248f-7c99-5f24-a450-651645ec366c@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6253089627563195264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

> > Add support for Gemalto specific radio settings.
> > =

> > ---
> >   Makefile.am                           |   1 +
> >   drivers/gemaltomodem/gemaltomodem.c   |   2 +
> >   drivers/gemaltomodem/gemaltomodem.h   |   3 +
> >   drivers/gemaltomodem/radio-settings.c | 267 ++++++++++++++++++++++++++
> >   4 files changed, 273 insertions(+)
> >   create mode 100644 drivers/gemaltomodem/radio-settings.c
> > =

> =

> I went ahead and applied this with a 2 lines amended: changing 'enum
> ofono_access_mode' to 'unsigned int'.  I recently updated all the drivers=
 in
> commit 1d86dbc6 ("radio-settings: Do not use enum ofono_access_mode").  S=
o I
> did a similar amend here for consistency.

Ok, thanks. After enum ofono_access_mode has been removed, it is possible
to convert all the 'ifs' into 'switch' branches in the function
gemalto_set_rat_mode. I will test and send a cleanup patch.

Regards,
Sergey
--===============6253089627563195264==--

