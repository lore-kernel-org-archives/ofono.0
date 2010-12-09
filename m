Content-Type: multipart/mixed; boundary="===============5158915243138408277=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] cdma-atmodem: Add CDMA MO Call Support
Date: Thu, 09 Dec 2010 02:43:11 -0600
Message-ID: <4D00969F.9070303@gmail.com>
In-Reply-To: <1291332685-18740-4-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5158915243138408277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 12/02/2010 05:31 PM, Dara Spieker-Doyle wrote:
> ---
>  Makefile.am                      |    7 ++
>  configure.ac                     |    5 +
>  drivers/cdma-atmodem/atmodem.c   |   47 +++++++++
>  drivers/cdma-atmodem/atmodem.h   |   26 +++++

Lets call this cdmamodem/cdmamodem.[ch]

>  drivers/cdma-atmodem/atutil.c    |   45 +++++++++
>  drivers/cdma-atmodem/atutil.h    |   65 +++++++++++++

Are these verbatim copies of atmodem/atutil.[ch]?  If so, then there's
no reason why you can't re-use those.  No need to copy them.

>  drivers/cdma-atmodem/voicecall.c |  195 ++++++++++++++++++++++++++++++++=
++++++
>  7 files changed, 390 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/cdma-atmodem/atmodem.c
>  create mode 100644 drivers/cdma-atmodem/atmodem.h
>  create mode 100644 drivers/cdma-atmodem/atutil.c
>  create mode 100644 drivers/cdma-atmodem/atutil.h
>  create mode 100644 drivers/cdma-atmodem/voicecall.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index f111f96..9aac08b 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -242,6 +242,13 @@ conf_DATA +=3D plugins/phonesim.conf
>  endif
>  endif
>  =

> +if CDMA_ATMODEM
> +builtin_modules +=3D cdma_atmodem
> +builtin_sources +=3D drivers/cdma-atmodem/atmodem.c \
> +			drivers/cdma-atmodem/atmodem.h \
> +			drivers/cdma-atmodem/voicecall.c
> +endif
> +
>  builtin_modules +=3D g1
>  builtin_sources +=3D plugins/g1.c
>  =

> diff --git a/configure.ac b/configure.ac
> index 0c1986a..090f3ee 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -158,6 +158,11 @@ AC_ARG_ENABLE(atmodem, AC_HELP_STRING([--disable-atm=
odem],
>  					[enable_atmodem=3D${enableval}])
>  AM_CONDITIONAL(ATMODEM, test "${enable_atmodem}" !=3D "no")
>  =

> +AC_ARG_ENABLE(cdmaatmodem, AC_HELP_STRING([--disable-cdma-atmodem],
> +				[disable CDMA AT modem support]),
> +					[enable_cdma_atmodem=3D${enableval}])
> +AM_CONDITIONAL(CDMA_ATMODEM, test "${enable_cdma_atmodem}" !=3D "no")
> +
>  AC_ARG_ENABLE(phonesim, AC_HELP_STRING([--disable-phonesim],
>  				[disable Phone simulator support]),
>  					[enable_phonesim=3D${enableval}])
> diff --git a/drivers/cdma-atmodem/atmodem.c b/drivers/cdma-atmodem/atmode=
m.c
> new file mode 100644
> index 0000000..86dd074
> --- /dev/null
> +++ b/drivers/cdma-atmodem/atmodem.c
> @@ -0,0 +1,47 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
> +#include <glib.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/types.h>
> +
> +#include "atmodem.h"
> +
> +static int cdma_atmodem_init(void)
> +{
> +	cdma_at_voicecall_init();
> +
> +	return 0;
> +}
> +
> +static void cdma_atmodem_exit(void)
> +{
> +	cdma_at_voicecall_exit();
> +}
> +
> +OFONO_PLUGIN_DEFINE(cdma_atmodem, "CDMA AT modem driver", VERSION,
> +	OFONO_PLUGIN_PRIORITY_DEFAULT, cdma_atmodem_init, cdma_atmodem_exit)
> diff --git a/drivers/cdma-atmodem/atmodem.h b/drivers/cdma-atmodem/atmode=
m.h
> new file mode 100644
> index 0000000..32facbc
> --- /dev/null
> +++ b/drivers/cdma-atmodem/atmodem.h
> @@ -0,0 +1,26 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
> +extern void cdma_at_voicecall_init();
> +extern void cdma_at_voicecall_exit();
> +
> +extern void cdma_at_devinfo_init();
> +extern void cdma_at_devinfo_exit();
> diff --git a/drivers/cdma-atmodem/atutil.c b/drivers/cdma-atmodem/atutil.c
> new file mode 100644
> index 0000000..b58c1ee
> --- /dev/null
> +++ b/drivers/cdma-atmodem/atutil.c
> @@ -0,0 +1,45 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
> +#include <glib.h>
> +#include <string.h>
> +#include <stdlib.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/log.h>
> +#include <ofono/types.h>
> +
> +#include "atutil.h"
> +
> +void decode_at_error(struct ofono_error *error, const char *final)
> +{
> +	if (!strcmp(final, "OK")) {
> +		error->type =3D OFONO_ERROR_TYPE_NO_ERROR;
> +		error->error =3D 0;
> +	} else {
> +		error->type =3D OFONO_ERROR_TYPE_FAILURE;
> +		error->error =3D 0;
> +	}
> +}
> diff --git a/drivers/cdma-atmodem/atutil.h b/drivers/cdma-atmodem/atutil.h
> new file mode 100644
> index 0000000..9a7c5e1
> --- /dev/null
> +++ b/drivers/cdma-atmodem/atutil.h
> @@ -0,0 +1,65 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
> +#ifndef __AT_UTIL_H
> +#define __AT_UTIL_H
> +
> +void decode_at_error(struct ofono_error *error, const char *final);
> +
> +struct cb_data {
> +	void *cb;
> +	void *data;
> +	void *user;
> +};
> +
> +static inline struct cb_data *cb_data_new(void *cb, void *data)
> +{
> +	struct cb_data *ret;
> +
> +	ret =3D g_try_new0(struct cb_data, 1);
> +
> +	if (ret =3D=3D NULL)
> +		return ret;
> +
> +	ret->cb =3D cb;
> +	ret->data =3D data;
> +
> +	return ret;
> +}
> +
> +#define CALLBACK_WITH_FAILURE(cb, args...)		\
> +	do {						\
> +		struct ofono_error cb_e;		\
> +		cb_e.type =3D OFONO_ERROR_TYPE_FAILURE;	\
> +		cb_e.error =3D 0;				\
> +							\
> +		cb(&cb_e, ##args);			\
> +	} while (0)					\
> +
> +#define CALLBACK_WITH_SUCCESS(f, args...)		\
> +	do {						\
> +		struct ofono_error e;			\
> +		e.type =3D OFONO_ERROR_TYPE_NO_ERROR;	\
> +		e.error =3D 0;				\
> +		f(&e, ##args);				\
> +	} while (0)					\
> +
> +#endif /* __AT_UTIL_H */
> diff --git a/drivers/cdma-atmodem/voicecall.c b/drivers/cdma-atmodem/voic=
ecall.c
> new file mode 100644
> index 0000000..efae370
> --- /dev/null
> +++ b/drivers/cdma-atmodem/voicecall.c
> @@ -0,0 +1,195 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/cdma-voicecall.h>
> +
> +#include "gatchat.h"
> +#include "gatresult.h"
> +
> +#include "atutil.h"
> +#include "atmodem.h"
> +
> +static const char *none_prefix[] =3D { NULL };
> +
> +struct voicecall_driver {
> +	struct ofono_cdma_voicecall_manager *vc;
> +	unsigned int local_release;
> +	GAtChat *chat;
> +	unsigned int vendor;
> +};
> +
> +struct change_state_req {
> +	struct ofono_cdma_voicecall_manager *vc;
> +	ofono_cdma_voicecall_cb_t cb;
> +	void *data;
> +};
> +
> +static void at_dial_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_cdma_voicecall_cb_t cb =3D cbd->cb;
> +	GAtResultIter iter;
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok)
> +		goto out;
> +
> +	g_at_result_iter_init(&iter, result);

What is this for?

> +
> +out:
> +	cb(&error, cbd->data);
> +}
> +
> +static void at_dial(struct ofono_cdma_voicecall_manager *vc,
> +				const struct ofono_cdma_phone_number *ph,
> +				ofono_cdma_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_driver *vd =3D ofono_cdma_voicecall_manager_get_data(v=
c);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[256];
> +
> +	if (cbd =3D=3D NULL)
> +		goto error;
> +
> +	cbd->user =3D vc;
> +
> +	snprintf(buf, sizeof(buf), "AT+CDV=3D%s", ph->number);
> +
> +	if (g_at_chat_send(vd->chat, buf, none_prefix,
> +				at_dial_cb, cbd, g_free) > 0)
> +		return;
> +
> +error:
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
> +static void at_template(const char *cmd,
> +				struct ofono_cdma_voicecall_manager *vc,
> +				GAtResultFunc result_cb,
> +				ofono_cdma_voicecall_cb_t cb, void *data)
> +{
> +	struct voicecall_driver *vd =3D ofono_cdma_voicecall_manager_get_data(v=
c);
> +	struct change_state_req *req =3D g_try_new0(struct change_state_req, 1);
> +
> +	if (req =3D=3D NULL)
> +		goto error;
> +
> +	req->vc =3D vc;
> +	req->cb =3D cb;
> +	req->data =3D data;
> +
> +	if (g_at_chat_send(vd->chat, cmd, none_prefix,
> +				result_cb, req, g_free) > 0)
> +		return;
> +
> +error:
> +	g_free(req);
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
> +static void at_hangup_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct change_state_req *req =3D user_data;
> +
> +	if (!ok) {
> +		ofono_error("hangup failed.");
> +		return;
> +	}
> +
> +	ofono_cdma_voicecall_manager_disconnected(req->vc,
> +				OFONO_DISCONNECT_REASON_LOCAL_HANGUP, NULL);
> +		CALLBACK_WITH_SUCCESS(req->cb, req->data);
> +

Why the extra empty line?

How do we handle remote side hanging up?

> +}
> +
> +static void at_hangup(struct ofono_cdma_voicecall_manager *vc,
> +			ofono_cdma_voicecall_cb_t cb, void *data)
> +{
> +	/* Hangup active call */
> +	at_template("AT+CHV", vc, at_hangup_cb, cb, data);
> +}
> +
> +static int at_voicecall_probe(struct ofono_cdma_voicecall_manager *vc,
> +		unsigned int vendor, void *data)
> +{
> +	GAtChat *chat =3D data;
> +	struct voicecall_driver *vd;
> +
> +	vd =3D g_try_new0(struct voicecall_driver, 1);
> +	if (vd =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	vd->chat =3D g_at_chat_clone(chat);
> +	vd->vendor =3D vendor;
> +
> +	ofono_cdma_voicecall_manager_set_data(vc, vd);
> +
> +	ofono_cdma_voicecall_manager_register(vc);
> +
> +	return 0;
> +}
> +
> +static void at_voicecall_remove(struct ofono_cdma_voicecall_manager *vc)
> +{
> +	struct voicecall_driver *vd =3D ofono_cdma_voicecall_manager_get_data(v=
c);
> +
> +	ofono_cdma_voicecall_manager_set_data(vc, NULL);
> +
> +	g_at_chat_unref(vd->chat);
> +	g_free(vd);
> +}
> +
> +static struct ofono_cdma_voicecall_manager_driver driver =3D {
> +	.name			=3D "cdma-atmodem",
> +	.probe			=3D at_voicecall_probe,
> +	.remove			=3D at_voicecall_remove,
> +	.dial			=3D at_dial,
> +	.hangup			=3D at_hangup,
> +};
> +
> +void cdma_at_voicecall_init()
> +{
> +	ofono_cdma_voicecall_manager_driver_register(&driver);
> +}
> +
> +void cdma_at_voicecall_exit()
> +{
> +	ofono_cdma_voicecall_manager_driver_unregister(&driver);
> +}

Regards,
-Denis

--===============5158915243138408277==--

