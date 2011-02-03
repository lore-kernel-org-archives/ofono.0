Content-Type: multipart/mixed; boundary="===============6721041705203886760=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/4] nettime: Network time plugin implementation
Date: Thu, 03 Feb 2011 17:17:47 +0200
Message-ID: <AANLkTi=4Qofyq7exsfL=8gMhio=fHs+OttxQtkh2nqaP@mail.gmail.com>
In-Reply-To: <1296571771-26513-2-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6721041705203886760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

2011/2/1 Antti Paila <antti.paila@nokia.com>:
> ---
> =C2=A0plugins/nettime.c | =C2=A0326 +++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A01 files changed, 326 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 plugins/nettime.c
>
> diff --git a/plugins/nettime.c b/plugins/nettime.c
> new file mode 100644
> index 0000000..894dce7
> --- /dev/null
> +++ b/plugins/nettime.c
> @@ -0,0 +1,326 @@
> +/*
> + *
> + * =C2=A0oFono - Open Source Telephony
> + *
> + * =C2=A0Copyright (C) 2008-2010 =C2=A0Nokia Corporation and/or its subs=
idiary(-ies).
> + *
> + * =C2=A0This program is free software; you can redistribute it and/or m=
odify
> + * =C2=A0it under the terms of the GNU General Public License version 2 =
as
> + * =C2=A0published by the Free Software Foundation.
> + *
> + * =C2=A0This program is distributed in the hope that it will be useful,
> + * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See =
the
> + * =C2=A0GNU General Public License for more details.
> + *
> + * =C2=A0You should have received a copy of the GNU General Public Licen=
se
> + * =C2=A0along with this program; if not, write to the Free Software
> + * =C2=A0Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA =C2=
=A002110-1301 =C2=A0USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdlib.h>
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
> +#define TIMED_PATH "/com/meego/time"
> +#define TIMED_SERVICE "com.meego.time"

s/time/timed

> +struct nt_data {
> + =C2=A0 =C2=A0 =C2=A0 gboolean time_available;
> + =C2=A0 =C2=A0 =C2=A0 gboolean time_pending;
> + =C2=A0 =C2=A0 =C2=A0 time_t nw_time_utc;
> + =C2=A0 =C2=A0 =C2=A0 time_t received;
> + =C2=A0 =C2=A0 =C2=A0 int dst;
> + =C2=A0 =C2=A0 =C2=A0 int time_zone;
> + =C2=A0 =C2=A0 =C2=A0 const char *mcc;
> + =C2=A0 =C2=A0 =C2=A0 const char *mnc;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int timed_watch;
> + =C2=A0 =C2=A0 =C2=A0 gboolean timed_present;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_netreg *netreg;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int netreg_st_watch;

Let's call this just netereg_watch, as there is only one watch that is used.

> +};
> +
> +static void nettime_register(struct ofono_nettime_context *);
> +
> +static gboolean encode_time_format(struct ofono_network_time *time,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tm *tm)
> +{
> +
> + =C2=A0 =C2=A0 =C2=A0 tm->tm_gmtoff =3D time->utcoff;
> + =C2=A0 =C2=A0 =C2=A0 tm->tm_isdst =3D time->dst;

Why are you setting these? The values you are using in struct tm are
UTC. Also, tm_isdst is a boolean, and time->dst can be any of -1, 0,
1, 2.

> + =C2=A0 =C2=A0 =C2=A0 if (time->year < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
> +
> + =C2=A0 =C2=A0 =C2=A0 tm->tm_year =3D time->year - 1900;
> + =C2=A0 =C2=A0 =C2=A0 tm->tm_mon =3D time->mon - 1;
> + =C2=A0 =C2=A0 =C2=A0 tm->tm_mday =3D time->mday;
> + =C2=A0 =C2=A0 =C2=A0 tm->tm_hour =3D time->hour;
> + =C2=A0 =C2=A0 =C2=A0 tm->tm_min =3D time->min;
> + =C2=A0 =C2=A0 =C2=A0 tm->tm_sec =3D time->sec;
> +
> + =C2=A0 =C2=A0 =C2=A0 return TRUE;
> +}
> +
> +static time_t get_monotonic_time()
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct timespec ts;
> + =C2=A0 =C2=A0 =C2=A0 clock_gettime(CLOCK_MONOTONIC, &ts);
> + =C2=A0 =C2=A0 =C2=A0 return ts.tv_sec;
> +}
> +
> +static int fill_time_notification(DBusMessage *msg,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct nt_data *ntd)
> +{
> + =C2=A0 =C2=A0 =C2=A0 DBusMessageIter iter, iter_array;
> + =C2=A0 =C2=A0 =C2=A0 int64_t utc;
> +
> + =C2=A0 =C2=A0 =C2=A0 dbus_message_iter_init_append(msg, &iter);
> + =C2=A0 =C2=A0 =C2=A0 dbus_message_iter_open_container(&iter,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_AR=
RAY,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "{sv}",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &iter_array);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (ntd->time_pending) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ntd->time_availabl=
e) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 utc =3D ntd->nw_time_utc - ntd->received;

I would just store the ofono_network_time struct, and check if year < 0.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ofono_dbus_dict_append(&iter_array,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 "UTC",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 DBUS_TYPE_INT64,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &utc);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_dbus_dict_append=
(&iter_array,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "DST",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_IN=
T32,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &ntd->dst);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_dbus_dict_append=
(&iter_array,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Timezone",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_IN=
T32,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &ntd->time_z=
one);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 ofono_dbus_dict_append(&iter_array,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "MobileCountryCode",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 DBUS_TYPE_STRING,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &ntd->mcc);
> + =C2=A0 =C2=A0 =C2=A0 ofono_dbus_dict_append(&iter_array,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "MobileNetworkCode",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 DBUS_TYPE_STRING,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &ntd->mnc);
> +
> + =C2=A0 =C2=A0 =C2=A0 dbus_message_iter_close_container(&iter, &iter_arr=
ay);
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static DBusMessage *create_time_notification(
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct ofono_nettime_context *context)
> +{
> + =C2=A0 =C2=A0 =C2=A0 DBusMessage *message;
> + =C2=A0 =C2=A0 =C2=A0 struct nt_data *ntd =3D context->data;
> + =C2=A0 =C2=A0 =C2=A0 const char *path =3D ofono_modem_get_path(context-=
>modem);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (path =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("Fetching =
path for modem failed");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 message =3D dbus_message_new_method_call(TIMED_SER=
VICE, TIMED_PATH,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "com.meego.N=
etworkTime", "Notify");
> + =C2=A0 =C2=A0 =C2=A0 if (message =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 dbus_message_set_no_reply(message, TRUE);
> + =C2=A0 =C2=A0 =C2=A0 fill_time_notification(message, ntd);
> +
> + =C2=A0 =C2=A0 =C2=A0 return message;
> +}
> +
> +static void init_time(struct ofono_nettime_context *context)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct nt_data *nt_data =3D g_new0(struct nt_data,=
 1);
> +
> + =C2=A0 =C2=A0 =C2=A0 nt_data->time_available =3D FALSE;
> + =C2=A0 =C2=A0 =C2=A0 nt_data->time_pending =3D FALSE;
> + =C2=A0 =C2=A0 =C2=A0 nt_data->dst =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 nt_data->time_zone =3D 0;

That '0' after new actually zeroes out the memory, so these are not necessa=
ry.

> + =C2=A0 =C2=A0 =C2=A0 context->data =3D nt_data;
> +}
> +
> +static int nettime_probe(struct ofono_nettime_context *context)
> +{
> + =C2=A0 =C2=A0 =C2=A0 DBG("Network Time Probe for modem: %p", context->m=
odem);
> +
> + =C2=A0 =C2=A0 =C2=A0 init_time(context);

As the function above reduces to just a g_new0() call and setting it
to context->data, just move all that here.

> + =C2=A0 =C2=A0 =C2=A0 nettime_register(context);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static void nettime_remove(struct ofono_nettime_context *context)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct nt_data *ntd =3D context->data;
> +
> + =C2=A0 =C2=A0 =C2=A0 DBG("Network Time Remove for modem: %p", context->=
modem);
> + =C2=A0 =C2=A0 =C2=A0 g_dbus_remove_watch(ofono_dbus_get_connection(),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ntd->timed_watch);

Just to be safe, you should check that ntd->timed_watch > 0 here. I
think you should also do the same with the netreg_watch.

> + =C2=A0 =C2=A0 =C2=A0 g_free(ntd);
> +}
> +
> +static void notify(int status, int lac, int ci, int tech, const char *mc=
c,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 const char *mnc, void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_nettime_context *context =3D data;
> + =C2=A0 =C2=A0 =C2=A0 struct nt_data *ntd =3D context->data;
> + =C2=A0 =C2=A0 =C2=A0 DBusMessage *message;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (mcc =3D=3D NULL || mnc =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 ntd->mcc =3D mcc;
> + =C2=A0 =C2=A0 =C2=A0 ntd->mnc =3D mnc;

You're not checking whether MCC has changed since last time.

> + =C2=A0 =C2=A0 =C2=A0 if (ntd->timed_present =3D=3D FALSE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("Timed not present=
. Caching time info");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }

What are you caching here?

> + =C2=A0 =C2=A0 =C2=A0 message =3D create_time_notification(context);
> + =C2=A0 =C2=A0 =C2=A0 if (message =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("Failed to=
 create Notification message");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 g_dbus_send_message(ofono_dbus_get_connection(), m=
essage);
> + =C2=A0 =C2=A0 =C2=A0 ntd->time_pending =3D FALSE;
> +}

Please split the actual D-Bus message sending out to a separate
function. That way, you don't need to call this function with (0, 0,
0, 0, ... arguments all over the place, which looks weird.

> +static void nr_st_watch_destroy(void *data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_nettime_context *context =3D data;
> + =C2=A0 =C2=A0 =C2=A0 struct nt_data *ntd =3D context->data;
> + =C2=A0 =C2=A0 =C2=A0 DBG("");
> +
> + =C2=A0 =C2=A0 =C2=A0 ntd->netreg_st_watch =3D 0;
> +}

Don't give a destroy callback unless you have memory to clean up.

Cheers,
Aki

--===============6721041705203886760==--

