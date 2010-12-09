Content-Type: multipart/mixed; boundary="===============4260454873358216821=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] cdma-voicecall: Add CDMA MO Call Support
Date: Thu, 09 Dec 2010 02:13:32 -0600
Message-ID: <4D008FAC.5080006@gmail.com>
In-Reply-To: <1291332685-18740-2-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4260454873358216821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 12/02/2010 05:31 PM, Dara Spieker-Doyle wrote:
> ---
>  Makefile.am              |    2 +-
>  include/cdma-voicecall.h |   82 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/dbus.h           |    3 ++
>  include/types.h          |    8 ++++
>  4 files changed, 94 insertions(+), 1 deletions(-)
>  create mode 100644 include/cdma-voicecall.h
> =

> diff --git a/Makefile.am b/Makefile.am
> index a4c47e8..aea3fd3 100644
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
> index 0000000..d5ef3c5
> --- /dev/null
> +++ b/include/cdma-voicecall.h
> @@ -0,0 +1,82 @@
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
> +
> +typedef void (*ofono_cdma_voicecall_cb_t)(const struct ofono_error *erro=
r,
> +					void *data);
> +
> +/* Voice call related functionality, including AT+CDV, AT+CHV */
> +struct ofono_cdma_voicecall_manager_driver {

Please call this ofono_cdma_voicecall_driver to be consistent with
ofono_voicecall_*

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
> +

Please remove this empty line

> +};
> +
> +void ofono_cdma_voicecall_manager_disconnected(
> +			struct ofono_cdma_voicecall_manager *vc,
> +			enum ofono_disconnect_reason reason,
> +			const struct ofono_error *error);
> +
> +int ofono_cdma_voicecall_manager_driver_register(
> +			const struct ofono_cdma_voicecall_manager_driver *d);
> +void ofono_cdma_voicecall_manager_driver_unregister(
> +			const struct ofono_cdma_voicecall_manager_driver *d);
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
> diff --git a/include/dbus.h b/include/dbus.h
> index 9e29afb..ad84ca9 100644
> --- a/include/dbus.h
> +++ b/include/dbus.h
> @@ -55,6 +55,9 @@ extern "C" {
>  #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
>  #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
>  =

> +/*CDMA Interfaces*/

Sorry to nitpick, but I prefer 1 space after the opening of the comment
and 1 space right before the closing of the comment

> +#define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCall=
Manager"
> +

This chunk should come in a separate patch.

>  /* Essentially a{sv} */
>  #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_S=
TRING \
>  					DBUS_TYPE_STRING_AS_STRING \
> diff --git a/include/types.h b/include/types.h
> index ba2481f..1ebedc6 100644
> --- a/include/types.h
> +++ b/include/types.h
> @@ -83,6 +83,14 @@ struct ofono_phone_number {
>  	int type;
>  };
>  =

> +/* Length of NUM_FIELDS in 3GPP2 C.S0005-E v2.0*/
> +#define OFONO_MAX_CDMA_PHONE_NUMBER_LENGTH 256
> +
> +struct ofono_cdma_phone_number {
> +	/*char maps to max size of CHARi (8 bit) in 3GPP2 C.S0005-E v2.0*/
> +	char number[OFONO_MAX_CDMA_PHONE_NUMBER_LENGTH];
> +};
> +

Please submit this chunk in a separate patch as well.

>  struct ofono_call {
>  	unsigned int id;
>  	int type;

Regards,
-Denis

--===============4260454873358216821==--

