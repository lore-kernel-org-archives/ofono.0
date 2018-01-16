Content-Type: multipart/mixed; boundary="===============2921151568337320930=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] qmi: add USSD support for MO services
Date: Tue, 16 Jan 2018 11:32:24 -0600
Message-ID: <acd5e869-ea42-2e97-dbbd-4d0572f77077@gmail.com>
In-Reply-To: <20180116153325.20491-2-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2921151568337320930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 01/16/2018 09:33 AM, Alexander Couzens wrote:
> ---
>   drivers/qmimodem/ussd.c | 187 +++++++++++++++++++++++++++++++++++++++++=
+++++--
>   1 file changed, 183 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/qmimodem/ussd.c b/drivers/qmimodem/ussd.c
> index 90c32097c94d..c1cb7d3697d1 100644
> --- a/drivers/qmimodem/ussd.c
> +++ b/drivers/qmimodem/ussd.c
> @@ -3,6 +3,7 @@
>    *  oFono - Open Source Telephony
>    *
>    *  Copyright (C) 2011-2012  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2017 by sysmocom s.f.m.c. GmbH <info@sysmocom.de>
>    *
>    *  This program is free software; you can redistribute it and/or modify
>    *  it under the terms of the GNU General Public License version 2 as
> @@ -23,20 +24,103 @@
>   #include <config.h>
>   #endif
>   =

> +#define _GNU_SOURCE
> +#include <string.h>
> +
> +#include <glib.h>
> +
>   #include <ofono/log.h>
>   #include <ofono/modem.h>
>   #include <ofono/ussd.h>
> -
> +#include <smsutil.h>
>   #include "qmi.h"
>   =

>   #include "qmimodem.h"
>   =

> +#include "voice.h"
> +
>   struct ussd_data {
>   	struct qmi_service *voice;
>   	uint16_t major;
>   	uint16_t minor;
>   };
>   =

> +static int validate_ussd_data(const struct qmi_ussd_data *data, int size)

drivers/qmimodem/ussd.c: In function =E2=80=98validate_ussd_data=E2=80=99:
drivers/qmimodem/ussd.c:53:11: error: comparison between signed and =

unsigned integer expressions [-Werror=3Dsign-compare]
   if (size < sizeof(*data))
            ^
drivers/qmimodem/ussd.c:56:11: error: comparison between signed and =

unsigned integer expressions [-Werror=3Dsign-compare]
   if (size < sizeof(*data) + data->length)

I went ahead and changed the type of 'size' to a uint16_t.

> +{
> +	if (data =3D=3D NULL)
> +		return 1;
> +
> +	if (size < sizeof(*data))
> +		return 1;
> +
> +	if (size < sizeof(*data) + data->length)
> +		return 1;
> +
> +	if (data->dcs < QMI_USSD_DCS_ASCII || data->dcs > QMI_USSD_DCS_UCS2)
> +		return 1;
> +
> +	return 0;
> +}
> +

I also silently fixed up (git commit --amend) a couple of whitespace =

issues and applied this patch.

Regards,
-Denis

--===============2921151568337320930==--

