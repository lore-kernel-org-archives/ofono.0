Content-Type: multipart/mixed; boundary="===============4374109995054296739=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH 3/5] cdma-providers: add driver APIs implementation
Date: Thu, 01 Dec 2011 08:56:09 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E07DBBA@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <1322688060-17588-4-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4374109995054296739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> diff --git a/src/cdma-providers.c b/src/cdma-providers.c new file mode 10=
0644
> index 0000000..d02d41c
> --- /dev/null
> +++ b/src/cdma-providers.c
> @@ -0,0 +1,80 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2011  Nokia Corporation and/or its subsidiary(-ies).

Same comment about copyright.

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
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <string.h>
> +#include <glib.h>
> +#include "ofono.h"
> +
> +static GSList *g_drivers =3D NULL;
> +
> +ofono_bool_t __ofono_cdma_providers_get_name(const char *sid, char
> +**name) {
> +	GSList *d;
> +
> +	if (sid =3D=3D NULL || strlen(sid) =3D=3D 0)
> +		return FALSE;
> +
> +	for (d =3D g_drivers; d !=3D NULL; d =3D d->next) {
> +		const struct ofono_cdma_providers_driver *driver =3D d->data;
> +
> +		if (driver->get_provider_name =3D=3D NULL)
> +			continue;
> +
> +		DBG("Calling providers plugin '%s'", driver->name);
> +
> +		if (driver->get_provider_name(sid, name) < 0)
> +			continue;
> +
> +		return TRUE;
> +	}
> +
> +	return FALSE;
> +}
> +
> +static gint compare_priority(gconstpointer a, gconstpointer b) {
> +	const struct ofono_cdma_providers_driver *plugin1 =3D a;
> +	const struct ofono_cdma_providers_driver *plugin2 =3D b;
> +
> +	return plugin2->priority - plugin1->priority; }
> +
> +int ofono_cdma_providers_driver_register(
> +		const struct ofono_cdma_providers_driver *driver) {
> +	DBG("driver: %p name: %s", driver, driver->name);
> +
> +	g_drivers =3D g_slist_insert_sorted(g_drivers, (void *) driver,
> +						compare_priority);
> +	return 0;
> +}
> +
> +void ofono_cdma_providers_driver_unregister(
> +		const struct ofono_cdma_providers_driver *driver) {
> +	DBG("driver: %p name: %s", driver, driver->name);
> +
> +	g_drivers =3D g_slist_remove(g_drivers, driver); }
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


--===============4374109995054296739==--

