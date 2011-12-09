Content-Type: multipart/mixed; boundary="===============7364157147628237792=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 01/12] cdma-providers: add driver APIs header
Date: Fri, 09 Dec 2011 05:50:51 -0600
Message-ID: <4EE1F61B.4080100@gmail.com>
In-Reply-To: <1323355803-22096-2-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7364157147628237792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 12/08/2011 08:49 AM, Philippe Nunes wrote:
> ---
>  include/cdma-providers.h |   44 ++++++++++++++++++++++++++++++++++++++++=
++++
>  1 files changed, 44 insertions(+), 0 deletions(-)
>  create mode 100644 include/cdma-providers.h
> =

> diff --git a/include/cdma-providers.h b/include/cdma-providers.h
> new file mode 100644
> index 0000000..6878087
> --- /dev/null
> +++ b/include/cdma-providers.h
> @@ -0,0 +1,44 @@
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
> +#ifndef __OFONO_CDMA_PROVIDERS_H
> +#define __OFONO_CDMA_PROVIDERS_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +struct ofono_cdma_providers_driver {
> +	const char *name;
> +	int priority;
> +	int (*get_provider_name)(const char *sid, char **name);
> +};

Please rename this to ofono_cdma_provision_driver.  We can later expand
this to provision username and password settings.

> +
> +int ofono_cdma_providers_driver_register(
> +		const struct ofono_cdma_providers_driver *driver);
> +void ofono_cdma_providers_driver_unregister(
> +		const struct ofono_cdma_providers_driver *driver);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __OFONO_CDMA_PROVIDERS_H */

Regards

--===============7364157147628237792==--

