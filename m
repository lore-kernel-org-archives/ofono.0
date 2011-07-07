Content-Type: multipart/mixed; boundary="===============2888500988615261600=="
MIME-Version: 1.0
From: Gustavo Padovan <padovan@profusion.mobi>
Subject: Re: [RFC 3/3] dun_dt: Add baseline for dun_dt plug-in.
Date: Thu, 07 Jul 2011 13:59:32 -0300
Message-ID: <20110707165932.GA16322@joana>
In-Reply-To: <1310028323-29180-4-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2888500988615261600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mario,

* Mario Tokarz <mario@tokarz.eu> [2011-07-07 10:45:23 +0200]:

> From: Mario Tokarz <mario.tokarz@bmw-carit.de>
> =

> ---
>  Makefile.am      |    3 +
>  plugins/dun_dt.c |  337 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 340 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/dun_dt.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index c77a793..97698df 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -351,6 +351,9 @@ builtin_sources +=3D plugins/hfp_ag.c plugins/bluetoo=
th.h
>  builtin_modules +=3D dun_gw
>  builtin_sources +=3D plugins/dun_gw.c plugins/bluetooth.h
>  =

> +builtin_modules +=3D dun_dt
> +builtin_sources +=3D plugins/dun_dt.c plugins/bluetooth.h
> +
>  builtin_sources +=3D $(btio_sources)
>  builtin_cflags +=3D @BLUEZ_CFLAGS@
>  builtin_libadd +=3D @BLUEZ_LIBS@
> diff --git a/plugins/dun_dt.c b/plugins/dun_dt.c
> new file mode 100644
> index 0000000..98e2214
> --- /dev/null
> +++ b/plugins/dun_dt.c
> @@ -0,0 +1,337 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2010  ProFUSION embedded systems

So this is mine as in the original code I wrote. Not from ProFUSION.
It was part of a Google Summer of Code project.

	Copyright (C) 2010 Gustavo Padovan <gustavo@padovan.org>

> + *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
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
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <glib.h>
> +#include <gatchat.h>
> +#include <gattty.h>
> +#include <gdbus.h>
> +#include <ofono.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/netreg.h>
> +#include <ofono/voicecall.h>
> +#include <ofono/gprs.h>
> +#include <ofono/gprs-context.h>
> +#include <ofono/call-volume.h>

call-volume.h?

> +
> +#include <drivers/dunmodem/dunmodem.h>
> +
> +#include <ofono/dbus.h>
> +
> +#include "bluetooth.h"
> +
> +#define BLUEZ_SERIAL_INTERFACE BLUEZ_SERVICE ".Serial"
> +
> +#ifndef DBUS_TYPE_UNIX_FD
> +#define DBUS_TYPE_UNIX_FD -1
> +#endif
> +
> +static DBusConnection *connection;
> +static GHashTable *modem_hash;
> +
> +static int dun_dt_bt_probe(const char *device, const char *dev_addr,
> +				const char *adapter_addr, const char *alias)
> +{
> +	struct ofono_modem *modem;
> +	struct dun_data *data;
> +	char buf[256];
> +	char alias_buf[256];
> +
> +	DBG("");
> +
> +	/* We already have this device in our hash, ignore */
> +	if (g_hash_table_lookup(modem_hash, device) !=3D NULL)
> +		return -EALREADY;
> +
> +	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
> +			device, dev_addr, adapter_addr);
> +
> +	strcpy(buf, "dun/");
> +	bluetooth_create_path(dev_addr, adapter_addr, buf + 4, sizeof(buf) - 4);
> +
> +	modem =3D ofono_modem_create(buf, "dun_dt");
> +	if (modem =3D=3D NULL) {
> +		DBG("Failed to create modem");
> +		return -ENOMEM;
> +	}
> +
> +	DBG("Modem %p", modem);
> +
> +	data =3D g_try_new0(struct dun_data, 1);
> +	if (data =3D=3D NULL)
> +		goto free;
> +
> +	data->dun_path =3D g_strdup(device);
> +	if (data->dun_path =3D=3D NULL)
> +		goto free;
> +
> +	ofono_modem_set_data(modem, data);
> +
> +	strcpy(alias_buf, "DUN ");
> +	strcat(alias_buf, alias);

Do you really need tell the user this is a DUN modem? It doesn't care.

	Gustavo

--===============2888500988615261600==--

