Content-Type: multipart/mixed; boundary="===============1541050722448573310=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Add call-volume interface to allow user adjust speaker
 and mic volume
Date: Fri, 25 Sep 2009 06:41:35 -0700
Message-ID: <1253886095.2931.42.camel@localhost.localdomain>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E089B3D5FCC@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1541050722448573310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

>  Makefile.am           |    4 +-
>  include/call-volume.h |   67 +++++++++
>  src/call-volume.c     |  374 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/ofono.h           |    1 +
>  4 files changed, 444 insertions(+), 2 deletions(-)
>  create mode 100644 include/call-volume.h
>  create mode 100644 src/call-volume.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index 02f8835..522c1b5 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -10,7 +10,7 @@ include_HEADERS =3D include/log.h include/plugin.h incl=
ude/history.h \
>                         include/phonebook.h include/ssn.h include/ussd.h \
>                         include/sms.h include/sim.h include/message-waiti=
ng.h \
>                         include/netreg.h include/voicecall.h include/devi=
nfo.h \
> -                       include/cbs.h
> +                       include/cbs.h include/call-volume.h
>  =

>  nodist_include_HEADERS =3D include/version.h
>  =

> @@ -163,7 +163,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sou=
rces) \
>                         src/ssn.c src/call-barring.c src/sim.c \
>                         src/phonebook.c src/history.c src/message-waiting=
.c \
>                         src/simutil.h src/simutil.c src/storage.h \
> -                       src/storage.c src/cbs.c src/watch.c
> +                       src/storage.c src/cbs.c src/watch.c src/call-volu=
me.c
>  =

>  src_ofonod_LDADD =3D $(builtin_libadd) \
>                         @GLIB_LIBS@ @GTHREAD_LIBS@ @DBUS_LIBS@ -ldl
> diff --git a/include/call-volume.h b/include/call-volume.h
> new file mode 100644
> index 0000000..f36d2f4
> --- /dev/null
> +++ b/include/call-volume.h
> @@ -0,0 +1,67 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
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
> +#ifndef __OFONO_CALL_VOLUME_H
> +#define __OFONO_CALL_VOLUME_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include <ofono/types.h>
> +#include <ofono/dbus.h>
> +
> +struct ofono_call_volume;
> +
> +typedef void (*ofono_call_volume_cb_t)(const struct ofono_error *error,
> +                                       void *data);
> +
> +struct ofono_call_volume_driver {
> +       const char *name;
> +       int (*probe)(struct ofono_call_volume *cv, unsigned int vendor,
> +                       void *data);
> +       void (*remove)(struct ofono_call_volume *cv);
> +       void (*speaker_volume)(struct ofono_call_volume *cv, unsigned int=
 percent,
> +                       ofono_call_volume_cb_t cb, void *data);
> +       void (*microphone_volume)(struct ofono_call_volume *cv, unsigned =
int percent,
> +                       ofono_call_volume_cb_t cb, void *data);
> +};
> +
> +void ofono_call_volume_notify(struct ofono_call_volume *cv,
> +                                       const char *property, unsigned in=
t percent);
> +
> +int ofono_call_volume_driver_register(const struct ofono_call_volume_dri=
ver *d);
> +void ofono_call_volume_driver_unregister(const struct ofono_call_volume_=
driver *d);
> +
> +struct ofono_call_volume *ofono_call_volume_create(struct ofono_modem *m=
odem,
> +                                       unsigned int vendor, const char *=
driver, void *data);
> +
> +void ofono_call_volume_register(struct ofono_call_volume *cv);
> +void ofono_call_volume_remove(struct ofono_call_volume *cv);
> +
> +void ofono_call_volume_set_data(struct ofono_call_volume *cv, void *data=
);
> +void *ofono_call_volume_get_data(struct ofono_call_volume *cv);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __OFONO_CALL_VOLUME_H */
> diff --git a/src/call-volume.c b/src/call-volume.c
> new file mode 100644
> index 0000000..aa740c0
> --- /dev/null
> +++ b/src/call-volume.c
> @@ -0,0 +1,374 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
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
> +#define _GNU_SOURCE
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <unistd.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/call-volume.h>
> +
> +#include <gdbus.h>
> +#include "ofono.h"
> +#include "common.h"
> +
> +#define CALL_VOLUME_INTERFACE "org.ofono.CallVolume"

we have to stop doing this. Start using this:

#define FOO_INTERFACE  OFONO_SERVICE ".FooInterface"

> +#define CALL_VOLUME_FLAG_PENDING 0x1
> +
> +static GSList *g_drivers =3D NULL;
> +
> +struct ofono_call_volume {
> +       DBusMessage *pending;
> +       const struct ofono_call_volume_driver *driver;
> +       int flags;
> +       void *driver_data;
> +       struct ofono_atom *atom;
> +
> +       unsigned int speaker_volume;
> +       unsigned int microphone_volume;
> +
> +       unsigned int temp_volume; /* temp volume before it is accepted by=
 remote */
> +};
> +
> +static void call_volume_unregister(struct ofono_atom *atom);

That forward declaration seems pointless unless I actually missed
something. No forward declaration unless they are really needed. Just
shuffle the code around.

> +void ofono_call_volume_notify(struct ofono_call_volume *cv,
> +                                               const char *property,
> +                                               unsigned int percent)
> +{
> +       DBusConnection *conn =3D ofono_dbus_get_connection();
> +       const char *path =3D __ofono_atom_get_path(cv->atom);
> +
> +       if(!strcmp(property, "SpeakerVolume")) {
> +               cv->speaker_volume =3D percent;
> +       }

Coding style. Actually twice. No space behind if and single if
statements need no { }.

> +
> +       if (!strcmp(property, "MicrophoneVolume")) {
> +               cv->microphone_volume =3D percent;
> +       }

No  { } needed.

> +       ofono_dbus_signal_property_changed(conn, path, CALL_VOLUME_INTERF=
ACE,
> +                                               property, DBUS_TYPE_UINT3=
2,
> +                                               &percent);
> +}
> +
> +static DBusMessage *cv_get_properties(DBusConnection *conn,
> +                                               DBusMessage *msg, void *d=
ata)
> +{
> +       struct ofono_call_volume *cv =3D data;
> +       DBusMessage *reply;
> +       DBusMessageIter iter, dict;
> +       unsigned int speaker_volume =3D cv->speaker_volume;
> +       unsigned int microphone_volume =3D cv->microphone_volume;

What is this variable non-sense for. You can use cv->speaker_volume
directly from D-Bus message append functions. Only for certain strings
you need this.

> +
> +       if (cv->pending)
> +               return __ofono_error_busy(msg);
> +
> +       cv->pending =3D dbus_message_ref(msg);
> +
> +       reply =3D dbus_message_new_method_return(cv->pending);
> +
> +       if (!reply)
> +               return NULL;

What is this empty line for? Just don't do that. The error check
logically belongs to the function creating reply.

Also who unrefs cv->pending in this case?

> +       dbus_message_iter_init_append(reply, &iter);
> +
> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +                                       OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +                                       &dict);
> +
> +       ofono_dbus_dict_append(&dict, "SpeakerVolume", DBUS_TYPE_UINT32,
> +                                       &speaker_volume);
> +
> +       ofono_dbus_dict_append(&dict, "MicrophoneVolume",
> +                                       DBUS_TYPE_UINT32, &microphone_vol=
ume);

Why do we use UINT32 for percentage values? A BYTE would be clearly
enough.

> +
> +       dbus_message_iter_close_container(&iter, &dict);
> +
> +       __ofono_dbus_pending_reply(&cv->pending, reply);
> +
> +       return NULL;
> +}
> +
> +static void generic_callback(const struct ofono_error *error, void *data)
> +{
> +       struct ofono_call_volume *cv =3D data;
> +       DBusConnection *conn =3D ofono_dbus_get_connection();
> +       DBusMessage *reply;
> +
> +       cv->flags &=3D ~CALL_VOLUME_FLAG_PENDING;
> +
> +       if (!cv->pending)
> +               return;
> +
> +       if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
> +               reply =3D dbus_message_new_method_return(cv->pending);
> +       else
> +               reply =3D __ofono_error_failed(cv->pending);
> +
> +       g_dbus_send_message(conn, reply);
> +
> +       dbus_message_unref(cv->pending);
> +       cv->pending =3D NULL;
> +}
> +
> +static void sv_set_callback(const struct ofono_error *error, void *data)
> +{
> +       struct ofono_call_volume *cv =3D data;
> +
> +       if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +               ofono_debug("Error occurred during Speaker Volume set: %s=
",
> +                                               telephony_error_to_str(er=
ror));
> +       } else {
> +               cv->speaker_volume =3D cv->temp_volume;
> +       }
> +
> +       generic_callback(error, data);
> +}
> +
> +static void mv_set_callback(const struct ofono_error *error, void *data)
> +{
> +       struct ofono_call_volume *cv =3D data;
> +
> +       if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +               ofono_debug("Error occurred during Microphone Volume set:=
 %s",
> +                                               telephony_error_to_str(er=
ror));
> +       } else {
> +               cv->microphone_volume =3D cv->temp_volume;
> +       }
> +
> +       generic_callback(error, data);
> +}

So personally I think the ofono_debug() call makes these two function
hard to read and more complicated than needed. If we really want to
display this error then either use ofono_error() or just don't bother at
all with any kind of output.

> +static DBusMessage *cv_set_call_volume(DBusMessage *msg, struct ofono_ca=
ll_volume *cv,
> +                                        const char *property, unsigned i=
nt percent)
> +{
> +       if (percent > 100)
> +               return __ofono_error_invalid_format(msg);
> +
> +       DBG("set %s volume to %d percent", property, percent);
> +
> +       cv->flags |=3D CALL_VOLUME_FLAG_PENDING;
> +       cv->temp_volume =3D percent;
> +
> +       if (msg)
> +               cv->pending =3D dbus_message_ref(msg);
> +
> +       if(!strcmp(property, "SpeakerVolume")) {
> +               if (!cv->driver->speaker_volume) {
> +                       return (msg !=3D NULL)?__ofono_error_not_implemen=
ted(msg):NULL;
> +               }
> +               cv->driver->speaker_volume(cv, percent, sv_set_callback, =
cv);
> +       }

So the space after if is missing again. And this return statement is not
readable at all. It violates coding style and makes my brain hurt. Redo
this it becomes readable. Cramping everything in one line is just no
helpful.

> +
> +       if (!strcmp(property, "MicrophoneVolume")) {
> +               if (!cv->driver->microphone_volume)
> +                       return (msg !=3D NULL)?__ofono_error_not_implemen=
ted(msg):NULL;
> +               cv->driver->microphone_volume(cv, percent, mv_set_callbac=
k, cv);
> +       }

See comment above.

> +
> +       return NULL;
> +}
> +
> +static DBusMessage *cv_set_property(DBusConnection *conn, DBusMessage *m=
sg,
> +                                       void *data)
> +{
> +       struct ofono_call_volume *cv =3D data;
> +       DBusMessageIter iter;
> +       DBusMessageIter var;
> +       const char *property;
> +       unsigned int percent;
> +
> +       if (cv->pending)
> +               return __ofono_error_busy(msg);
> +
> +       if (!dbus_message_iter_init(msg, &iter))
> +               return __ofono_error_invalid_args(msg);
> +
> +       if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
> +               return __ofono_error_invalid_args(msg);
> +
> +       dbus_message_iter_get_basic(&iter, &property);
> +       dbus_message_iter_next(&iter);
> +
> +       if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
> +               return __ofono_error_invalid_args(msg);
> +
> +       dbus_message_iter_recurse(&iter, &var);
> +
> +       if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_UINT32)
> +               return __ofono_error_invalid_args(msg);
> +
> +       dbus_message_iter_get_basic(&var, &percent);
> +
> +       return cv_set_call_volume(msg, cv, property, percent);
> +}
> +
> +static GDBusMethodTable cv_methods[] =3D {
> +       { "GetProperties",      "",     "a{sv}",        cv_get_properties,
> +                                                       G_DBUS_METHOD_FLA=
G_ASYNC},
> +       { "SetProperty",        "sv",   "",             cv_set_property,
> +                                                       G_DBUS_METHOD_FLA=
G_ASYNC },
> +       { }
> +};

I am missing the point why GetProperties has to be done async. That
looks like too much overhead for something just returning stored values.

> +
> +static GDBusSignalTable cv_signals[] =3D {
> +       { "PropertyChanged",    "sv" },
> +       { }
> +};
> +
> +static void call_volume_remove(struct ofono_atom *atom)
> +{
> +       struct ofono_call_volume *cv =3D __ofono_atom_get_data(atom);
> +
> +       DBG("atom: %p", atom);
> +
> +       if (cv=3D=3D NULL)
> +               return;
> +
> +       if (cv->driver && cv->driver->remove)
> +               cv->driver->remove(cv);
> +
> +       g_free(cv);
> +}
> +
> +struct ofono_call_volume *ofono_call_volume_create(struct ofono_modem *m=
odem,
> +                                       unsigned int vendor,
> +                                       const char *driver,
> +                                       void *data)
> +{
> +       struct ofono_call_volume *cv;
> +       GSList *l;
> +
> +       if (driver =3D=3D NULL)
> +               return NULL;
> +
> +       cv =3D g_try_new0(struct ofono_call_volume, 1);
> +       cv->speaker_volume =3D 100;
> +       cv->microphone_volume =3D 100;
> +
> +       if (cv =3D=3D NULL)
> +               return NULL;

How do you expect this to work actually? If cv =3D=3D NULL, then your
assignment are NULL pointer dereferences and the daemon will crash. Your
error handling is not protecting it.

> +
> +       cv->atom =3D __ofono_modem_add_atom(modem,
> +                                               OFONO_ATOM_TYPES_CALL_VOL=
UME,
> +                                               call_volume_remove, cv);
> +
> +       for (l =3D g_drivers; l; l =3D l->next) {
> +               const struct ofono_call_volume_driver *drv =3D l->data;
> +
> +               if (g_strcmp0(drv->name, driver))
> +                       continue;
> +
> +               if (drv->probe(cv, vendor, data) < 0)
> +                       continue;
> +
> +               cv->driver =3D drv;
> +               break;
> +       }
> +
> +       if (cv->driver) {
> +               cv_set_call_volume(NULL, cv, "SpeakerVolume", cv->speaker=
_volume);
> +               cv_set_call_volume(NULL, cv, "MicrophoneVolume", cv->micr=
ophone_volume);
> +       }
> +
> +       return cv;
> +}
> +
> +void ofono_call_volume_register(struct ofono_call_volume *cv)
> +{
> +       DBusConnection *conn =3D ofono_dbus_get_connection();
> +       struct ofono_modem *modem =3D __ofono_atom_get_modem(cv->atom);
> +       const char *path =3D __ofono_atom_get_path(cv->atom);
> +
> +       if (!g_dbus_register_interface(conn, path,
> +                                       CALL_VOLUME_INTERFACE,
> +                                       cv_methods, cv_signals, NULL,
> +                                       cv, NULL)) {
> +               ofono_error("Could not create %s interface",
> +                               CALL_VOLUME_INTERFACE);
> +
> +               return;
> +       }
> +
> +       ofono_modem_add_interface(modem, CALL_VOLUME_INTERFACE);
> +
> +       __ofono_atom_register(cv->atom, call_volume_unregister);
> +}
> +
> +void call_volume_unregister(struct ofono_atom *atom)
> +{
> +       DBusConnection *conn =3D ofono_dbus_get_connection();
> +       struct ofono_call_volume *cv =3D __ofono_atom_get_data(atom);
> +       struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
> +       const char *path =3D __ofono_atom_get_path(atom);
> +       GSList *l;
> +
> +       ofono_modem_remove_interface(modem, CALL_VOLUME_INTERFACE);
> +       g_dbus_unregister_interface(conn, path,
> +                                       CALL_VOLUME_INTERFACE);
> +}
> +
> +int ofono_call_volume_driver_register(const struct ofono_call_volume_dri=
ver *d)
> +{
> +       DBG("driver: %p, name: %s", d, d->name);
> +
> +       if (d->probe =3D=3D NULL)
> +               return -EINVAL;
> +
> +       g_drivers =3D g_slist_prepend(g_drivers, (void *)d);

I really hate these casts only because of const driver declaration.

Personally I am against it, but I see some value behind having this
const. However there has to be a space between the cast and the
variable.

> +
> +       return 0;
> +}
> +
> +void ofono_call_volume_driver_unregister(const struct ofono_call_volume_=
driver *d)
> +{
> +       DBG("driver: %p, name: %s", d, d->name);
> +
> +       g_drivers =3D g_slist_remove(g_drivers, (void *)d);
> +}

See comment above.

> +
> +void ofono_call_volume_remove(struct ofono_call_volume *cv)
> +{
> +       __ofono_atom_free(cv->atom);
> +}
> +
> +void ofono_call_volume_set_data(struct ofono_call_volume *cv, void *data)
> +{
> +       cv->driver_data =3D data;
> +}
> +
> +void *ofono_call_volume_get_data(struct ofono_call_volume *cv)
> +{
> +       return cv->driver_data;
> +}
> +
> diff --git a/src/ofono.h b/src/ofono.h
> index 0659989..409a9e2 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -105,6 +105,7 @@ enum ofono_atom_type {
>         OFONO_ATOM_TYPE_SSN =3D 12,
>         OFONO_ATOM_TYPE_MESSAGE_WAITING =3D 13,
>         OFONO_ATOM_TYPE_CBS =3D 14,
> +       OFONO_ATOM_TYPES_CALL_VOLUME =3D 15,
>  };
>  =

>  enum ofono_atom_watch_condition {

Regards

Marcel



--===============1541050722448573310==--

