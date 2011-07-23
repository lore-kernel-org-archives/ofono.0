Content-Type: multipart/mixed; boundary="===============5537429834477338526=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] cdmamodem: create vendor.h file.
Date: Sat, 23 Jul 2011 17:05:39 +0200
Message-ID: <1311433540.21109.350.camel@aeonflux>
In-Reply-To: <1311419040-4213-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5537429834477338526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

>  Makefile.am                |    3 ++-
>  drivers/cdmamodem/vendor.h |   25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/cdmamodem/vendor.h
> =

> diff --git a/Makefile.am b/Makefile.am
> index e00f73b..f1ef96c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -270,7 +270,8 @@ builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
>  			drivers/cdmamodem/voicecall.c \
>  			drivers/cdmamodem/devinfo.c \
>  			drivers/cdmamodem/connman.c \
> -			drivers/cdmamodem/network-registration.c
> +			drivers/cdmamodem/network-registration.c \
> +			drivers/cdmamodem/vendor.h
>  endif
>  =

>  builtin_modules +=3D g1
> diff --git a/drivers/cdmamodem/vendor.h b/drivers/cdmamodem/vendor.h
> new file mode 100644
> index 0000000..3b00bbf
> --- /dev/null
> +++ b/drivers/cdmamodem/vendor.h
> @@ -0,0 +1,25 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +enum ofono_vendor {
> +	OFONO_VENDOR_GENERIC =3D 0,
> +	OFONO_VENDOR_SPEEDUP,
> +};

do not bother with this until it is really needed. Vendor quirks are the
last resort to avoid massive code duplication. In a lot of cases a
vendor specific atom driver is the better choice.

And you can just share the atmodem ones in this case anyway.

Regards

Marcel



--===============5537429834477338526==--

