Content-Type: multipart/mixed; boundary="===============3654990594822186723=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH_v5 7/8] huaweicdmamodem: create a huawei cdma driver.
Date: Fri, 05 Aug 2011 10:49:04 +0200
Message-ID: <1312534145.3373.56.camel@aeonflux>
In-Reply-To: <1312379452-821-8-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3654990594822186723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

>  Makefile.am                                    |    6 +
>  drivers/huaweicdmamodem/huaweicdmamodem.c      |   45 +++++++
>  drivers/huaweicdmamodem/huaweicdmamodem.h      |   23 ++++
>  drivers/huaweicdmamodem/network-registration.c |  159 ++++++++++++++++++=
++++++
>  4 files changed, 233 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.c
>  create mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.h
>  create mode 100644 drivers/huaweicdmamodem/network-registration.c

these need to be split into two. First put the core plugin into place
and then add features to it.

> diff --git a/Makefile.am b/Makefile.am
> index 56c1d6a..afa5e6f 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -276,6 +276,12 @@ builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
>  			drivers/cdmamodem/voicecall.c \
>  			drivers/cdmamodem/devinfo.c \
>  			drivers/cdmamodem/connman.c
> +
> +builtin_modules +=3D huaweicdmamodem
> +builtin_sources +=3D drivers/huaweicdmamodem/huaweicdmamodem.h \
> +			drivers/huaweicdmamodem/huaweicdmamodem.c \
> +			drivers/huaweicdmamodem/network-registration.c
> +
>  endif
>  =

>  builtin_modules +=3D g1
> diff --git a/drivers/huaweicdmamodem/huaweicdmamodem.c b/drivers/huaweicd=
mamodem/huaweicdmamodem.c
> new file mode 100644
> index 0000000..4e9c400
> --- /dev/null
> +++ b/drivers/huaweicdmamodem/huaweicdmamodem.c
> @@ -0,0 +1,45 @@
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
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +
> +#include "huaweicdmamodem.h"
> +
> +static int huaweicdmamodem_init(void)
> +{
> +	huaweicdma_netreg_init();
> +
> +	return 0;
> +}
> +
> +static void huaweicdmamodem_exit(void)
> +{
> +	huaweicdma_netreg_exit();
> +}
> +
> +OFONO_PLUGIN_DEFINE(huaweicdmamodem, "Huawei CDMA modem driver", VERSION,
> +			OFONO_PLUGIN_PRIORITY_DEFAULT,
> +			huaweicdmamodem_init, huaweicdmamodem_exit)
> diff --git a/drivers/huaweicdmamodem/huaweicdmamodem.h b/drivers/huaweicd=
mamodem/huaweicdmamodem.h
> new file mode 100644
> index 0000000..799d3a8
> --- /dev/null
> +++ b/drivers/huaweicdmamodem/huaweicdmamodem.h
> @@ -0,0 +1,23 @@
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
> +extern void huaweicdma_netreg_init(void);
> +extern void huaweicdma_netreg_exit(void);
> diff --git a/drivers/huaweicdmamodem/network-registration.c b/drivers/hua=
weicdmamodem/network-registration.c
> new file mode 100644
> index 0000000..e4c5c41
> --- /dev/null
> +++ b/drivers/huaweicdmamodem/network-registration.c
> @@ -0,0 +1,159 @@
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
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/cdma-netreg.h>
> +
> +#include "gatchat.h"
> +
> +#include "huaweicdmamodem.h"
> +
> +static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
> +
> +struct huaweicdma_netreg_data {
> +	GAtChat *chat;
> +};
> +
> +static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_cdma_netreg *netreg =3D user_data;
> +	gint srv_status;
> +	gint srv_domain;
> +	gint roaming_status;
> +	int status;
> +	GAtResultIter iter;
> +
> +	if (!ok)
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "^SYSINFO:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &srv_status))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &srv_domain))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &roaming_status))
> +		return;
> +
> +	DBG("%d, %d, %d", srv_status, srv_domain, roaming_status);
> +
> +	switch (srv_status) {
> +	case 1:	/* Restricted service */
> +	case 2:	/* Service valid */
> +	case 3:	/* Restricted region service */
> +		status =3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED;
> +		break;
> +	case 0:	/* No service */
> +	case 4:	/* Not registered */
> +	default:
> +		status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
> +		break;
> +	}
> +
> +	switch (srv_domain) {
> +	case 0: /* No service */
> +	case 255: /* CDMA not supported */
> +		status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
> +		break;
> +	case 1: /* Only CS */
> +	case 2: /* Only PS */
> +	case 3: /* CS + PS */
> +	case 4: /* CS registered, PS in searching state */
> +		break;
> +	}
> +	=

> +	if (status =3D=3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED
> +				&& roaming_status)
> +		status =3D CDMA_NETWORK_REGISTRATION_STATUS_ROAMING;

Do we really have to make it this complicated? Just nest the switch
statement for srv_status and srv_domain.

It is pretty obvious that if srv_status results in not registered that
we do not have to do any further checks.

> +	ofono_cdma_netreg_status_notify(netreg, status);
> +}
> +
> +
> +static void mode_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_cdma_netreg *netreg =3D user_data;
> +	struct huaweicdma_netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg=
);
> +
> +	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix, sysinfo_cb,
> +				netreg, NULL);

Just for style sake, put sysinfo_cb on the next line. Most of the
command do that. Even if it fits into the previous line.

> +}
> +
> +static int huaweicdma_netreg_probe(struct ofono_cdma_netreg *netreg,
> +				unsigned int vendor, void *data)
> +{
> +	GAtChat *chat =3D data;
> +	struct huaweicdma_netreg_data *nd;
> +
> +	nd =3D g_try_new0(struct huaweicdma_netreg_data, 1);

You need to check if memory allocation succeeded here.

> +	nd->chat =3D g_at_chat_clone(chat);

Extra empty line here.

> +	ofono_cdma_netreg_set_data(netreg, nd);
> +
> +	g_at_chat_register(nd->chat, "^MODE:",
> +				mode_notify, FALSE, netreg, NULL);
> +
> +	ofono_cdma_netreg_register(netreg);

Please do not do that here. Also I am not sure that has actually been
tested, but this should fail and cause various side effects.

Just have a different callback for the initial AT^SYSINFO call. You
should really only register that atom once you know that it is supported
and at least on AT^SYSINFO succeeded

> +	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix, sysinfo_cb,
> +				netreg, NULL);

Same style comment as above.

> +
> +	return 0;
> +}
> +
> +static void huaweicdma_netreg_remove(struct ofono_cdma_netreg *netreg)
> +{
> +	struct huaweicdma_netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg=
);
> +
> +	ofono_cdma_netreg_set_data(netreg, NULL);
> +
> +	g_at_chat_unref(nd->chat);
> +	g_free(nd);
> +}
> +
> +static struct ofono_cdma_netreg_driver driver =3D {
> +	.name	=3D "huaweicdmamodem",
> +	.probe	=3D huaweicdma_netreg_probe,
> +	.remove	=3D huaweicdma_netreg_remove,
> +};
> +
> +void huaweicdma_netreg_init(void)
> +{
> +	ofono_cdma_netreg_driver_register(&driver);
> +}
> +
> +void huaweicdma_netreg_exit(void)
> +{
> +	ofono_cdma_netreg_driver_unregister(&driver);
> +}

Regards

Marcel



--===============3654990594822186723==--

