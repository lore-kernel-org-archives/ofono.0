Content-Type: multipart/mixed; boundary="===============2184112886234251394=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2] plugin: Add ste modem initd integration
Date: Tue, 21 Dec 2010 06:36:29 -0800
Message-ID: <1292942189.2658.44.camel@aeonflux>
In-Reply-To: <1292449768-6060-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2184112886234251394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> This patch introduces auto discovery of ST-Ericsson modems.
> ST-Ericsson modems (M5XX, M57XX, M7XX, M74XX) are managed by a
> Modem Init Daemon responsible for start, power cycles,
> flashing etc. This STE plugin monitors the modem state exposed
> from the Modem Init Damon's Dbus API. When the modem is in state
> "on" the STE modem is created and registered. Multiple modem
> instances, and reset handling is supported.

I don't really like on how STE, ST and TI do abbreviations these days.

It is MID for modem init daemon, it is UIM for user init manager, KIM
for kernel init manager and TI calls a shared transport ST. This will
end up in a massive confusion at some point ;)

> ---
> Changes:
> - Support for multiple STE modems.
> - Better naming of STE modem instances, using received dbus path.
> - CAIF Link layer to use for AT channels specified pr modem instance.
> - Added support for reset.
> =

>  Makefile.am      |    5 +
>  configure.ac     |    6 +
>  plugins/stemid.c |  310 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 321 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/stemid.c

Can we just call this something like stemgr for STE Manager or STE Init
Manager. The MID part is just confusing.

> diff --git a/Makefile.am b/Makefile.am
> index 12b3c33..98096ae 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -82,6 +82,11 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.=
c \
>  =

>  udev_files =3D plugins/ofono.rules
>  =

> +if STE_MODEM_INITD
> +builtin_modules +=3D stemid
> +builtin_sources +=3D plugins/stemid.c
> +endif
> +
>  if UDEV
>  builtin_modules +=3D udev
>  builtin_sources +=3D plugins/udev.c
> diff --git a/configure.ac b/configure.ac
> index 5c18f68..f733fc4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -177,6 +177,12 @@ AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-d=
atafiles],
>  =

>  AM_CONDITIONAL(DATAFILES, test "${enable_datafiles}" !=3D "no")
>  =

> +AC_ARG_ENABLE(ste_modem_initd, AC_HELP_STRING([--disable-ste-modem-initd=
],
> +			[disable auto discovery of STE modem using modem init daemon]),
> +					[enable_ste_modem_initd=3D${enableval}])
> +
> +AM_CONDITIONAL(STE_MODEM_INITD, test "${enable_ste_modem_initd}" !=3D "n=
o")
> +

Don't bother with this and just always compile this in. For now that is
fine and in case we start with more fine grained control here, I will do
that on modem technology based and not on plugins.

Right now we do atmodem and isimodem. If we feel like it is needed, we
would do stemodem, but right now, I don't see it.

>  if (test "${prefix}" =3D "NONE"); then
>  	dnl no prefix and no localstatedir, so default to /var
>  	if (test "$localstatedir" =3D '${prefix}/var'); then
> diff --git a/plugins/stemid.c b/plugins/stemid.c
> new file mode 100644
> index 0000000..9f5da22
> --- /dev/null
> +++ b/plugins/stemid.c
> @@ -0,0 +1,310 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2010 ST-Ericsson AB.
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
> +#include <errno.h>
> +#include <string.h>
> +#include <net/if.h>
> +
> +#include <glib.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/dbus.h>
> +
> +/*
> + * ST-Ericsson's Modem Init Daemon is used for controling the modem power
> + * cycles and provides a dbus API for modem state and properties.
> + */
> +#define MID_SERVICE		"com.stericsson.modeminit"
> +#define MID_INTERFACE		MID_SERVICE ".Modem"
> +
> +/* The signal StateChange sends the modem state.*/
> +#define STATUS_CHANGED		"StateChange"
> +
> +#define MID_ACTION_ON		"on"		/* Modem is on */
> +#define MID_ACTION_RESET	"dumping"	/* Modem is resetting */
> +#define MID_ACTION_UNKNOWN	"unknown"	/* Don't care */
> +
> +/* ResetState requests resending of StateChange. */
> +#define MID_RESEND_STATE	"ResendState"

This is a bad D-Bus API btw. Using a D-Bus method to trigger signal
sending. You will wake up any listener for that signal. What is wrong
with just having a GetState?

> +/* GetCaifIfName requests the CAIF Interface Name. */
> +#define MID_GET_CAIFIF		"GetCaifIfName"
> +
> +#define TIMEOUT		5000
> +#define STE_DRIVER_NAME	"ste"

I don't think you should be doing the naming like this. Don't you have a
proper serial number? If not, then use at least

> +#define STE_INTERFACE_PROPERTY	"Interface"

One time it is a property, and then you have a method call? What is it
now?

> +enum ste_state {
> +	STE_PENDING,    /* Waiting for caifif and "on" notification */
> +	STE_PENDING_IF, /* Waiting for caifif, already got "on" */
> +	STE_REGISTERED, /* Modem is registered */
> +	STE_RESETTING   /* Modem is resetting */
> +};
> +
> +struct ste_modem {
> +	char *path;
> +	struct ofono_modem *modem;
> +	enum ste_state state;
> +	gboolean got_caifif;
> +	gboolean pending_call;
> +};
> +
> +static GHashTable *modem_list;
> +static guint mid_api_watch;
> +static guint mid_state_watch;
> +static DBusConnection *connection;

<snip>

I have not looked at anything in between just yet.

> +static int stemid_init()
> +{
> +	connection =3D ofono_dbus_get_connection();
> +	if (connection =3D=3D NULL)
> +		return -EIO;

Don't bother with the check here. It will not fail. It if fails, you
have a seriously other problem.

> +	modem_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> +						NULL, destroy_stemodem);
> +	mid_api_watch =3D g_dbus_add_service_watch(connection, MID_SERVICE,
> +				mid_connect, mid_disconnect, NULL, NULL);
> +	return 0;
> +}
> +
> +static void stemid_exit()
> +{
> +	DBusConnection *connection =3D ofono_dbus_get_connection();

Why not use the global one you stored. Why call the function again?

> +
> +	g_hash_table_destroy(modem_list);
> +	g_dbus_remove_watch(connection, mid_api_watch);
> +}
> +
> +OFONO_PLUGIN_DEFINE(stemid, "STE Modem Init Daemon dbus api", VERSION,
> +			OFONO_PLUGIN_PRIORITY_DEFAULT, stemid_init, stemid_exit)

The plugin description is wrong. You are not providing a D-Bus API here.

Regards

Marcel



--===============2184112886234251394==--

