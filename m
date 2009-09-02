Content-Type: multipart/mixed; boundary="===============8219488715599296448=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] G1: Add initial HTC G1 modem support
Date: Wed, 02 Sep 2009 16:08:47 -0700
Message-ID: <1251932927.1266.130.camel@localhost.localdomain>
In-Reply-To: <20090902190300.3dd38bf8@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8219488715599296448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

> G1 plugin is based on generic_at, with a bunch of stuff dropped
> and simplified.  We use AT+CFUN=3D1 for powering on rather than having
> a configurable init string.  We also manually set the default state
> during init (the G1 appears to start in mode V0 by default).  The
> device (/dev/smd0) is hardcoded.
> ---
>  Makefile.am  |    3 +
>  plugins/g1.c |  182 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 185 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/g1.c

patch has been applied. I did have a trailing whitespace mistake, but I
think git was just being paranoid.

Regards

Marcel



--===============8219488715599296448==--

