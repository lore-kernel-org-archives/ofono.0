Content-Type: multipart/mixed; boundary="===============4410817210501653385=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/8] sierramodem: Report network registration status
Date: Sun, 30 Dec 2012 20:26:55 -0600
Message-ID: <50E0F7EF.4050604@gmail.com>
In-Reply-To: <20121228193520.GJ18339@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4410817210501653385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Forest,

On 12/28/2012 01:35 PM, Forest Bond wrote:
> From: Forest Bond<forest.bond@rapidrollout.com>
>
> The modem is polled every 5 seconds (unless inhibited by PPP)
> using AT!STATUS.

How is PPP entering the equation?  In Patch 5 you're using "swmodem" =

gprs-context driver, which is not PPP based AFAIK.

> ---
>   drivers/sierramodem/cdma-netreg.c |  300 ++++++++++++++++++++++++++++++=
+++++++
>   1 files changed, 300 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/sierramodem/cdma-netreg.c b/drivers/sierramodem/cdma=
-netreg.c
> index 109b245..4cca769 100644
> --- a/drivers/sierramodem/cdma-netreg.c
> +++ b/drivers/sierramodem/cdma-netreg.c
> @@ -3,6 +3,9 @@
>    *  oFono - Open Source Telephony
>    *
>    *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2008-2009  Novell, Inc.
> + *  Copyright (C) 2009-2012  Red Hat, Inc.
> + *  Copyright (C) 2012  Lanedo GmbH.
>    *  Copyright (C) 2012  Outpost Embedded, LLC. All rights reserved.
>    *
>    *  This program is free software; you can redistribute it and/or modify
> @@ -27,6 +30,8 @@
>   #define _GNU_SOURCE
>   #include<glib.h>
>   #include<errno.h>
> +#include<ctype.h>
> +#include<string.h>
>
>   #include<ofono/log.h>
>   #include<ofono/modem.h>
> @@ -35,11 +40,300 @@
>   #include "gatchat.h"
>
>   #include "sierramodem.h"
> +#include "eri.h"
>
>   struct sierra_netreg_data {
>   	GAtChat *chat;
> +	guint status_id;
> +	guint status_source;
>   };
>
> +/* NOTE: STATUS parsing functions originated in ModemManager. */
> +
> +typedef enum {
> +	SYS_MODE_UNKNOWN,
> +	SYS_MODE_NO_SERVICE,
> +	SYS_MODE_CDMA_1X,
> +	SYS_MODE_EVDO_REV0,
> +	SYS_MODE_EVDO_REVA
> +} SysMode;
> +

Again, no CamelCase or typedefs please.

Regards,
-Denis

--===============4410817210501653385==--

