Content-Type: multipart/mixed; boundary="===============7847635662366578766=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH 1/5] cdma-providers: add driver APIs header
Date: Thu, 01 Dec 2011 08:51:01 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E07DB87@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <1322688060-17588-2-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7847635662366578766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> diff --git a/include/cdma-providers.h b/include/cdma-providers.h new file=
 mode
> 100644 index 0000000..8ee9e1e
> --- /dev/null
> +++ b/include/cdma-providers.h
> @@ -0,0 +1,44 @@
> +/*
> + *
> + *  oFono - Open Telephony stack for Linux
> + *
> + *  Copyright (C) 2011  Nokia Corporation and/or its subsidiary(-ies).

Are you sure about the copyright?

> + *
> + *  This program is free software; you can redistribute it and/or
> +modify
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
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> +02110-1301  USA
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
> +	int (*get_provider_name)(const char *sid, char **name); };
> +
> +int ofono_cdma_providers_driver_register(
> +		const struct ofono_cdma_providers_driver *driver); void
> +ofono_cdma_providers_driver_unregister(
> +		const struct ofono_cdma_providers_driver *driver);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __OFONO_CDMA_PROVIDERS_H */
> --
> 1.7.1

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============7847635662366578766==--

