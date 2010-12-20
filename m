Content-Type: multipart/mixed; boundary="===============2788336468336876097=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/9] cdma-voicecall: Add CDMA MO Call Support
Date: Mon, 20 Dec 2010 14:50:35 -0600
Message-ID: <4D0FC19B.6080908@gmail.com>
In-Reply-To: <1292627481-9109-4-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2788336468336876097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 12/17/2010 05:11 PM, Dara Spieker-Doyle wrote:
> ---
>  Makefile.am              |    2 +-
>  include/cdma-voicecall.h |   89 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 90 insertions(+), 1 deletions(-)
>  create mode 100644 include/cdma-voicecall.h
> =

> diff --git a/Makefile.am b/Makefile.am
> index 12b3c33..1270be5 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -14,7 +14,7 @@ include_HEADERS =3D include/log.h include/plugin.h incl=
ude/history.h \
>  			include/gprs.h include/gprs-context.h \
>  			include/radio-settings.h include/stk.h \
>  			include/audio-settings.h include/nettime.h \
> -			include/ctm.h
> +			include/ctm.h include/cdma-voicecall.h
>  =

>  nodist_include_HEADERS =3D include/version.h
>  =

> diff --git a/include/cdma-voicecall.h b/include/cdma-voicecall.h
> new file mode 100644
> index 0000000..aaae028
> --- /dev/null
> +++ b/include/cdma-voicecall.h
> @@ -0,0 +1,89 @@
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
> +#ifndef __OFONO_CDMA_VOICECALL_H
> +#define __OFONO_CDMA_VOICECALL_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include <ofono/types.h>
> +
> +struct ofono_cdma_voicecall_manager;

Please call this ofono_cdma_voicecall.

> +
> +enum cdma_call_status {
> +	CDMA_CALL_STATUS_ACTIVE,
> +	CDMA_CALL_STATUS_DIALING,
> +	CDMA_CALL_STATUS_ALERTING,
> +	CDMA_CALL_STATUS_INCOMING,
> +	CDMA_CALL_STATUS_DISCONNECTED
> +};
> +
> +typedef void (*ofono_cdma_voicecall_cb_t)(const struct ofono_error *erro=
r,
> +					void *data);
> +
> +/* Voice call related functionality, including AT+CDV, AT+CHV */
> +struct ofono_cdma_voicecall_driver {
> +	const char *name;
> +	int (*probe)(struct ofono_cdma_voicecall_manager *vc,
> +			unsigned int vendor, void *data);
> +	void (*remove)(struct ofono_cdma_voicecall_manager *vc);
> +
> +	void (*dial)(struct ofono_cdma_voicecall_manager *vc,
> +			const struct ofono_cdma_phone_number *number,
> +			ofono_cdma_voicecall_cb_t cb, void *data);
> +
> +	/* Hangs up active, dialing, alerting or incoming calls */
> +	void (*hangup)(struct ofono_cdma_voicecall_manager *vc,
> +			ofono_cdma_voicecall_cb_t cb, void *data);
> +};
> +
> +void ofono_cdma_voicecall_manager_disconnected(
> +			struct ofono_cdma_voicecall_manager *vc,
> +			enum ofono_disconnect_reason reason,
> +			const struct ofono_error *error);
> +
> +int ofono_cdma_voicecall_driver_register(
> +			const struct ofono_cdma_voicecall_driver *d);
> +void ofono_cdma_voicecall_driver_unregister(
> +			const struct ofono_cdma_voicecall_driver *d);
> +
> +struct ofono_cdma_voicecall_manager *ofono_cdma_voicecall_manager_create(
> +					struct ofono_modem *modem,
> +					unsigned int vendor,
> +					const char *driver, void *data);
> +
> +void ofono_cdma_voicecall_manager_register(
> +			struct ofono_cdma_voicecall_manager *vc);
> +void ofono_cdma_voicecall_manager_remove(
> +			struct ofono_cdma_voicecall_manager *vc);
> +
> +void ofono_cdma_voicecall_manager_set_data(
> +			struct ofono_cdma_voicecall_manager *vc, void *data);
> +void *ofono_cdma_voicecall_manager_get_data(
> +			struct ofono_cdma_voicecall_manager *vc);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __OFONO_CDMA_VOICECALL_H */

Regards,
-Denis

--===============2788336468336876097==--

