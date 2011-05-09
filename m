Content-Type: multipart/mixed; boundary="===============2556989325496060832=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v4 2/5] private-network: add callback typedef drivers and
 settings
Date: Sun, 08 May 2011 23:48:28 -0500
Message-ID: <4DC7721C.5050707@gmail.com>
In-Reply-To: <1304690513-3137-3-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2556989325496060832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 05/06/2011 09:01 AM, Guillaume Zajac wrote:
> ---
>  include/private-network.h |   59 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 59 insertions(+), 0 deletions(-)
>  create mode 100644 include/private-network.h
> =


You also need to include this file into the build system, so changes to
Makefile.am should be included here as well.

> diff --git a/include/private-network.h b/include/private-network.h
> new file mode 100644
> index 0000000..ba84a36
> --- /dev/null
> +++ b/include/private-network.h
> @@ -0,0 +1,59 @@
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
> +

Why the double newline?

> +#ifndef __OFONO_PRIVATE_NETWORK_H
> +#define __OFONO_PRIVATE_NETWORK_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include <glib.h>

One of the rules of writing oFono public APIs (e.g. files under include)
is that they should use native C types.  Do not ever use glib types here.

> +
> +struct ofono_private_network_settings {
> +	int fd;
> +	const char *server_ip;
> +	const char *peer_ip;
> +	const char *primary_dns;
> +	const char *secondary_dns;
> +};
> +
> +

Why the double newline?

> +typedef gboolean (ofono_private_network_cb_t)(
> +		void *data, struct ofono_private_network_settings *settings);

What is the purpose of the gboolean return value in this callback?

> +
> +struct ofono_private_network_driver {
> +	char *name;
> +	int (*request)(ofono_private_network_cb_t cb, void *data);
> +	void (*release)(int uid);
> +};
> +
> +int ofono_private_network_driver_register(
> +			const struct ofono_private_network_driver *d);
> +void ofono_private_network_driver_unregister(
> +			const struct ofono_private_network_driver *d);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __OFONO_PRIVATE_NETWORK_H */

Regards,
-Denis

--===============2556989325496060832==--

