Content-Type: multipart/mixed; boundary="===============0296634075931837639=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] cdmamodem: create vendor.h file.
Date: Sat, 23 Jul 2011 12:08:00 +0100
Message-ID: <568DE01DA537804BA73470071BAC288938F4E12F@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1311419040-4213-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0296634075931837639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry I have just see that this patch require my previous patch on CDMA Net=
work Registration.

Please ignore it for now.

Regards,

Bertrand

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beh=
alf Of
> Bertrand Aygon
> Sent: Saturday, July 23, 2011 1:04 PM
> To: ofono(a)ofono.org
> Subject: [PATCH] cdmamodem: create vendor.h file.
> =

> ---
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
> =

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
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
> USA
> + *
> + */
> +
> +enum ofono_vendor {
> +	OFONO_VENDOR_GENERIC =3D 0,
> +	OFONO_VENDOR_SPEEDUP,
> +};
> --
> 1.7.4.1
> =

> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
> =

> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============0296634075931837639==--

