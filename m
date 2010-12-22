Content-Type: multipart/mixed; boundary="===============4313227700302725942=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2, 7/7] cdmaphonesim: Add CDMA SMS Support
Date: Wed, 22 Dec 2010 05:41:42 -0800
Message-ID: <1293025302.2658.74.camel@aeonflux>
In-Reply-To: <1292976149-15598-8-git-send-email-lei.2.yu@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4313227700302725942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lei,

>  Makefile.am               |   10 ++
>  plugins/cdmaphonesim.c    |  328 +++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/cdmaphonesim.conf |   14 ++
>  3 files changed, 352 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/cdmaphonesim.c
>  create mode 100644 plugins/cdmaphonesim.conf

do we really want to do it this way? I am not so sure that this is the
best way.

I would prefer to just have one /etc/ofono/phonesim.conf configuration
file. And maybe we need to start splitting phonesim plugin into a view
pieces and move it to its own directory. It then could also contain its
own atom driver implementations there.

So my main concern here is really that phonesim support is just for
engineering. It has nothing to do with real production hardware. And I
don't wanna clutter the source or its installation with it.

Regards

Marcel



--===============4313227700302725942==--

