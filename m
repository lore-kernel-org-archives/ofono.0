Content-Type: multipart/mixed; boundary="===============5280458434828145131=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv6] plugin: Add ste modem initd integration
Date: Tue, 11 Jan 2011 14:35:36 -0800
Message-ID: <1294785336.3873.40.camel@aeonflux>
In-Reply-To: <1294784698-2272-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5280458434828145131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> This patch introduces auto discovery of ST-Ericsson modems.
> ST-Ericsson modems (M57XX, M7XX, M74XX) are managed by a
> Modem Init Daemon responsible for start, power cycles,
> flashing etc. This STE plugin monitors the modem state exposed
> from the Modem Init Damon's Dbus API. When the modem is in state
> "on" the STE modem is created and registered. Muliple modem
> instances, and reset handling is supported.
> ---
>  Makefile.am      |    3 +
>  plugins/stemgr.c |  390 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 393 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/stemgr.c

you are out of luck today ;)

Applying: plugin: Add ste modem initd integration
error: Makefile.am: does not match index
Patch failed at 0001 plugin: Add ste modem initd integration

Regards

Marcel



--===============5280458434828145131==--

