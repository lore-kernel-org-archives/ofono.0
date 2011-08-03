Content-Type: multipart/mixed; boundary="===============2835517541957528061=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] dunmodem: Add stub for gprs.
Date: Wed, 03 Aug 2011 22:35:26 +0200
Message-ID: <1312403727.3373.31.camel@aeonflux>
In-Reply-To: <1312376660-4785-1-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2835517541957528061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mario,

>  Makefile.am                 |    3 +-
>  drivers/dunmodem/dunmodem.c |    2 +
>  drivers/dunmodem/dunmodem.h |    3 +
>  drivers/dunmodem/gprs.c     |   99 +++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 106 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/dunmodem/gprs.c

patch has been applied, but ...

> +#define _GNU_SOURCE
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +

... I trimmed this include list a little bit since you are not using any
of it.

Regards

Marcel



--===============2835517541957528061==--

