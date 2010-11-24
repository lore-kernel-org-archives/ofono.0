Content-Type: multipart/mixed; boundary="===============4845109985628349126=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/7] text-telephony: add public header
Date: Wed, 24 Nov 2010 09:28:34 -0600
Message-ID: <4CED2F22.8010700@gmail.com>
In-Reply-To: <1290535458-18786-2-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4845109985628349126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 11/23/2010 12:04 PM, Lucas De Marchi wrote:
> ---
>  Makefile.am              |    3 +-
>  include/text-telephony.h |   71 ++++++++++++++++++++++++++++++++++++++++=
++++++

So I'd like to name this file include/ctm.h, looks nicer and is shorter
to type.

>  2 files changed, 73 insertions(+), 1 deletions(-)
>  create mode 100644 include/text-telephony.h
> =

> diff --git a/Makefile.am b/Makefile.am
> index f841b4c..fb075a0 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -13,7 +13,8 @@ include_HEADERS =3D include/log.h include/plugin.h incl=
ude/history.h \
>  			include/cbs.h include/call-volume.h \
>  			include/gprs.h include/gprs-context.h \
>  			include/radio-settings.h include/stk.h \
> -			include/audio-settings.h include/nettime.h
> +			include/audio-settings.h include/nettime.h \
> +			include/text-telephony.h
>  =

>  nodist_include_HEADERS =3D include/version.h
>  =

> diff --git a/include/text-telephony.h b/include/text-telephony.h
> new file mode 100644
> index 0000000..fafa7dd
> --- /dev/null
> +++ b/include/text-telephony.h
> @@ -0,0 +1,71 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
> + *  Copyright (C) 2010  Intel Corporation. All rights reserved.
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
> +#ifndef __OFONO_TEXT_TELEPHONY_H
> +#define __OFONO_TEXT_TELEPHONY_H

OFONO_CTM here please

> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include <ofono/types.h>
> +
> +struct ofono_text_telephony;

Can you do me a favor and rename all occurrences of ofono_text_telephony
into ofono_ctm?

> +
> +typedef void (*ofono_text_telephony_set_cb_t)(const struct ofono_error *=
error,
> +						void *data);
> +typedef void (*ofono_text_telephony_query_cb_t)(const struct ofono_error=
 *error,
> +						ofono_bool_t enable, void *data);
> +
> +struct ofono_text_telephony_driver {
> +	const char *name;
> +	int (*probe)(struct ofono_text_telephony *tt, unsigned int vendor,
> +			void *data);
> +	void (*remove)(struct ofono_text_telephony *tt);
> +	void (*query_tty)(struct ofono_text_telephony *tt,
> +				ofono_text_telephony_query_cb_t cb,
> +				void *data);
> +	void (*set_tty)(struct ofono_text_telephony *tt,
> +				int enable,
> +				ofono_text_telephony_set_cb_t cb,
> +				void *data);
> +};
> +
> +int ofono_text_telephony_driver_register(const struct ofono_text_telepho=
ny_driver *d);
> +void ofono_text_telephony_driver_unregister(const struct ofono_text_tele=
phony_driver *d);
> +
> +struct ofono_text_telephony *ofono_text_telephony_create(struct ofono_mo=
dem *modem,
> +								unsigned int vendor,
> +								const char *driver,
> +								void *data);
> +
> +void ofono_text_telephony_register(struct ofono_text_telephony *tt);
> +void ofono_text_telephony_remove(struct ofono_text_telephony *tt);
> +
> +void ofono_text_telephony_set_data(struct ofono_text_telephony *tt, void=
 *data);
> +void *ofono_text_telephony_get_data(struct ofono_text_telephony *tt);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __OFONO_TEXT_TELEPHONY_H */

Otherwise, looks good to me.

Regards,
-Denis

--===============4845109985628349126==--

