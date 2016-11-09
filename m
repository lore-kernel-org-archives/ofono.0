Content-Type: multipart/mixed; boundary="===============4088833227656460645=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/9] include: add header file for lte atom
Date: Wed, 09 Nov 2016 14:19:50 -0600
Message-ID: <582384E6.8020709@gmail.com>
In-Reply-To: <1478713402-30780-2-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4088833227656460645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 11/09/2016 11:43 AM, Dragos Tatulea wrote:
> ---
>   include/lte.h | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 69 insertions(+)
>   create mode 100644 include/lte.h
>
> diff --git a/include/lte.h b/include/lte.h
> new file mode 100644
> index 0000000..8d73079
> --- /dev/null
> +++ b/include/lte.h
> @@ -0,0 +1,69 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2016  Endocode AG. All rights reserved.
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
> +#ifndef __OFONO_LTE_H
> +#define __OFONO_LTE_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include <ofono/types.h>
> +
> +struct ofono_lte;
> +
> +struct ofono_lte_context_config {
> +	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
> +	enum ofono_gprs_proto proto;
> +};

Lets name it ofono_lte_default_attach_info

> +
> +typedef void (*ofono_lte_cb_t)(const struct ofono_error *error, void *da=
ta);
> +
> +struct ofono_lte_driver {
> +	const char *name;
> +	int (*probe)(struct ofono_lte *lte, void *data);
> +	void (*remove)(struct ofono_lte *lte);
> +	int (*config)(struct ofono_lte *lte,

I'm not happy with the name, it is not descriptive enough

.set_default_attach_info
.set_default_context

Other ideas?

> +			struct ofono_lte_context_config *config,

const struct ofono_lte...

> +			ofono_lte_cb_t cb, void *data);
> +
> +};
> +
> +int ofono_lte_driver_register(const struct ofono_lte_driver *d);
> +
> +void ofono_lte_driver_unregister(const struct ofono_lte_driver *d);
> +
> +struct ofono_lte *ofono_lte_create(struct ofono_modem *modem,
> +					const char *driver, void *data);
> +
> +void ofono_lte_register(struct ofono_lte *lte);
> +
> +void ofono_lte_remove(struct ofono_lte *lte);
> +
> +void ofono_lte_set_data(struct ofono_lte *lte, void *data);
> +
> +void *ofono_lte_get_data(struct ofono_lte *lte);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
>

Regards,
-Denis

--===============4088833227656460645==--

