Content-Type: multipart/mixed; boundary="===============8223604140345023163=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Mon, 06 Dec 2010 19:00:50 +0200
Message-ID: <201012061900.50380.remi.denis-courmont@nokia.com>
In-Reply-To: <1291369648-25059-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8223604140345023163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Nitpicking...

On Friday 03 December 2010 11:47:26 ext Antti Paila, you wrote:
> diff --git a/plugins/nettime.c b/plugins/nettime.c
> new file mode 100644
> index 0000000..0f99bb1
> --- /dev/null
> +++ b/plugins/nettime.c
> @@ -0,0 +1,293 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2010  Nokia Corporation and/or its
> subsidiary(-ies). + *
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
1 =

> USA + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <string.h>
> +#include <glib.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/log.h>
> +#include <ofono/nettime.h>
> +#include <ofono/types.h>
> +#include <gdbus.h>
> +#include "ofono.h"
> +
> +#include "common.h"
> +
> +#define MAX_TIME_STR_LEN 128
> +#define TIME_FORMAT "%FT%TZ"
> +
> +
> +struct nettime_data {
> +	struct ofono_network_time nw_time;
> +	time_t received;
> +};
> +
> +static void nettime_register(struct ofono_nettime_context *);
> +
> +static gboolean encode_time_format(struct ofono_network_time *time,
> +				 struct tm *tm)
> +{
> +	if (time->year < 0)
> +		return FALSE;
> +
> +	tm->tm_year =3D time->year - 1900;
> +	tm->tm_mon =3D time->mon - 1;
> +	tm->tm_mday =3D time->mday;
> +	tm->tm_hour =3D time->hour;
> +	tm->tm_min =3D time->min;
> +	tm->tm_sec =3D time->sec;
> +	tm->tm_gmtoff =3D time->utcoff;
> +	tm->tm_isdst =3D time->dst;
> +
> +	return TRUE;
> +}
> +
> +static time_t get_monotonic_time()
> +{
> +	struct timespec ts;
> +	clock_gettime(CLOCK_MONOTONIC, &ts);
> +	return ts.tv_sec;
> +}
> +
> +static struct tm *refresh_nw_time(struct tm *nw_time,
> +				time_t received)
> +{
> +	time_t now, new_nw_time;
> +
> +	now =3D get_monotonic_time();
> +	new_nw_time =3D timegm(nw_time) + now - received;
> +	return gmtime(&new_nw_time);
> +}

Brrr, the result is somewhere in static data. This can cause quite confusin=
g =

behaviour if/when the code is changed. I would much rather use gmtime_r().

That being said, wouldn't it be far simpler to return a second timestamp =

instead of a broken-down time structure over D-Bus? Eventually, timed/whate=
ver =

will want a timestamp anyway to set the system clock or whatever else it wa=
nts =

to do with the NITZ.

> +static int fill_time_changed_signal(DBusMessage *signal,
> +		struct nettime_data *ntd)
> +{
> +	DBusMessageIter iter, iter_array;
> +	int time_available;
> +	char buf[MAX_TIME_STR_LEN];
> +	struct tm time_tm, *new_time_tm;
> +	const char *str =3D buf;
> +
> +	dbus_message_iter_init_append(signal, &iter);
> +	dbus_message_iter_open_container(&iter,
> +					DBUS_TYPE_ARRAY,
> +					"{sv}",
> +					&iter_array);
> +
> +	time_available =3D encode_time_format(&ntd->nw_time, &time_tm);
> +	if (time_available !=3D 0) {
> +		new_time_tm =3D refresh_nw_time(&time_tm, ntd->received);
> +		strftime(buf, MAX_TIME_STR_LEN, TIME_FORMAT, new_time_tm);
> +
> +		ofono_dbus_dict_append(&iter_array,
> +					"DateAndTime",
> +					DBUS_TYPE_STRING,
> +					&str);
> +	}
> +
> +	ofono_dbus_dict_append(&iter_array,
> +				"Timezone",
> +				DBUS_TYPE_INT32,
> +				&ntd->nw_time.utcoff);
> +	ofono_dbus_dict_append(&iter_array,
> +				"DST",
> +				DBUS_TYPE_UINT32,
> +				&ntd->nw_time.dst);
> +	dbus_message_iter_close_container(&iter, &iter_array);
> +	return 0;
> +}

Are the time zone offset and the DST always available, but the current time =

not? This seems odd.

Passing the time over D-Bus may cause extra drift/imprecision than we alrea=
dy =

have. I wonder if it would make sense to provide not just the current time =
but =

both:
- the current time for trivial programs, and
- the system boot time (i.e. nw_time - received) for smarter programs;
  this value cannot drift.

> +static DBusMessage *create_time_changed_signal(
> +			struct ofono_nettime_context *context)
> +{
> +	DBusMessage *signal;
> +	struct nettime_data *ntd =3D context->data;
> +	const char *path =3D ofono_modem_get_path(context->modem);
> +
> +	if (path =3D=3D NULL) {
> +		ofono_error("Fetching path for modem failed");
> +		return NULL;
> +	}
> +
> +	signal =3D dbus_message_new_signal(path, OFONO_NETWORK_TIME_INTERFACE,
> +					"NetworkTimeChanged");
> +	fill_time_changed_signal(signal, ntd);
> +
> +	return signal;
> +}
> +
> +static void init_time(struct ofono_nettime_context *context)
> +{
> +	struct nettime_data *nettime_data;
> +	context->data =3D g_try_new0(struct nettime_data, 1);

Hmm, if you don't check the result, I suspect you should g_new0() instead.

> +	nettime_data =3D context->data;
> +	nettime_data->nw_time.year =3D -1;
> +}
> +
> +static int nettime_probe(struct ofono_nettime_context *context)
> +{
> +	ofono_debug("Network Time Probe for modem: %p", context->modem);
> +
> +	init_time(context);
> +
> +	nettime_register(context);
> +	return 0;
> +}
> +
> +static void nettime_remove(struct ofono_nettime_context *context)
> +{
> +	DBusConnection *conn;
> +	const char *path;
> +
> +	ofono_debug("Network Time Remove for modem: %p", context->modem);
> +
> +	g_free(context->data);
> +
> +	conn =3D ofono_dbus_get_connection();
> +	path =3D ofono_modem_get_path(context->modem);
> +
> +	if (!g_dbus_unregister_interface(conn,
> +					path,
> +					OFONO_NETWORK_TIME_INTERFACE))
> +		ofono_error("Could not unregister %s interface",
> +				OFONO_NETWORK_TIME_INTERFACE);
> +
> +	ofono_modem_remove_interface(context->modem,
> +			OFONO_NETWORK_TIME_INTERFACE);
> +}
> +
> +static void nettime_info_received(struct ofono_nettime_context *context,
> +				struct ofono_network_time *info)
> +{
> +	DBusMessage *nt_signal;
> +	struct nettime_data *ntd =3D context->data;
> +
> +	if (info =3D=3D NULL)
> +		return;
> +
> +	ofono_debug("Received a network time notification on modem: %p",
> +			context->modem);
> +
> +	ntd->nw_time =3D *info;
> +	ntd->received =3D get_monotonic_time();

That works. But I would do the gmtime() conversion here, and store the resu=
lt =

once and for all, instead of copying the raw data and recompute the convers=
ion =

every time.

> +	nt_signal =3D create_time_changed_signal(context);
> +	if (nt_signal =3D=3D NULL) {
> +		ofono_error("Failed to create NetworkTimeChanged signal");
> +		return;
> +	}
> +
> +	g_dbus_send_message(ofono_dbus_get_connection(), nt_signal);
> +}

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============8223604140345023163==--

