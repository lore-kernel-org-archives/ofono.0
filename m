Content-Type: multipart/mixed; boundary="===============7559874234605867601=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 3/3] uim: Add uim implementation
Date: Thu, 03 Nov 2011 10:45:55 +0100
Message-ID: <1320313555-10320-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1320313555-10320-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7559874234605867601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    2 +-
 src/ofono.h |    8 +
 src/uim.c   | 1031 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 1040 insertions(+), 1 deletions(-)
 create mode 100644 src/uim.c

diff --git a/Makefile.am b/Makefile.am
index 40144c2..b60cc22 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -430,7 +430,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/gnssagent.c src/gnssagent.h \
 			src/cdma-smsutil.h src/cdma-smsutil.c \
 			src/cdma-sms.c src/private-network.c src/cdma-netreg.c \
-			src/handsfree.c
+			src/handsfree.c src/uim.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/ofono.h b/src/ofono.h
index bd45560..256d001 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -140,6 +140,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_CDMA_SMS,
 	OFONO_ATOM_TYPE_CDMA_NETREG,
 	OFONO_ATOM_TYPE_HANDSFREE,
+	OFONO_ATOM_TYPE_UIM,
 };
 =

 enum ofono_atom_watch_condition {
@@ -491,3 +492,10 @@ void __ofono_gprs_provision_free_settings(
 void __ofono_private_network_release(int id);
 ofono_bool_t __ofono_private_network_request(ofono_private_network_cb_t cb,
 						int *id, void *data);
+
+#include <ofono/uim.h>
+
+ofono_bool_t __ofono_is_valid_uim_pin(const char *pin,
+					enum ofono_uim_password_type type);
+
+void __ofono_uim_recheck_pin(struct ofono_uim *uim);
diff --git a/src/uim.c b/src/uim.c
new file mode 100644
index 0000000..7015cb1
--- /dev/null
+++ b/src/uim.c
@@ -0,0 +1,1031 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdio.h>
+#include <stdint.h>
+
+#include <glib.h>
+#include <gdbus.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include "ofono.h"
+
+#include "common.h"
+#include "util.h"
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_uim {
+	enum ofono_uim_password_type pin_type;
+	gboolean locked_pins[OFONO_UIM_PASSWORD_UIM_PUK]; /* Number of PINs */
+
+	int pin_retries[OFONO_UIM_PASSWORD_INVALID];
+
+	unsigned char mnc_length;
+	char *imsi;
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+
+	enum ofono_uim_state state;
+	struct ofono_watchlist *state_watches;
+
+	DBusMessage *pending;
+	const struct ofono_uim_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static const char *const passwd_name[] =3D {
+	[OFONO_UIM_PASSWORD_NONE] =3D "none",
+	[OFONO_UIM_PASSWORD_UIM_PIN] =3D "pin",
+	[OFONO_UIM_PASSWORD_UIM_PUK] =3D "puk",
+	[OFONO_UIM_PASSWORD_PHUIM_PIN] =3D "phone",
+	[OFONO_UIM_PASSWORD_PHFUIM_PIN] =3D "firstphone",
+	[OFONO_UIM_PASSWORD_PHFUIM_PUK] =3D "firstphonepuk",
+	[OFONO_UIM_PASSWORD_UIM_PIN2] =3D "pin2",
+	[OFONO_UIM_PASSWORD_UIM_PUK2] =3D "puk2",
+	[OFONO_UIM_PASSWORD_PHNET_PIN] =3D "network",
+	[OFONO_UIM_PASSWORD_PHNET_PUK] =3D "networkpuk",
+	[OFONO_UIM_PASSWORD_PHNETSUB_PIN] =3D "netsub",
+	[OFONO_UIM_PASSWORD_PHNETSUB_PUK] =3D "netsubpuk",
+	[OFONO_UIM_PASSWORD_PHSP_PIN] =3D "service",
+	[OFONO_UIM_PASSWORD_PHSP_PUK] =3D "servicepuk",
+	[OFONO_UIM_PASSWORD_PHCORP_PIN] =3D "corp",
+	[OFONO_UIM_PASSWORD_PHCORP_PUK] =3D "corppuk",
+};
+
+static const char *uim_passwd_name(enum ofono_uim_password_type type)
+{
+	return passwd_name[type];
+}
+
+static enum ofono_uim_password_type uim_string_to_passwd(const char *name)
+{
+	int len =3D sizeof(passwd_name) / sizeof(*passwd_name);
+	int i;
+
+	for (i =3D 0; i < len; i++)
+		if (!strcmp(passwd_name[i], name))
+			return i;
+
+	return OFONO_UIM_PASSWORD_INVALID;
+}
+
+static gboolean password_is_pin(enum ofono_uim_password_type type)
+{
+	switch (type) {
+	case OFONO_UIM_PASSWORD_UIM_PIN:
+	case OFONO_UIM_PASSWORD_PHUIM_PIN:
+	case OFONO_UIM_PASSWORD_PHFUIM_PIN:
+	case OFONO_UIM_PASSWORD_UIM_PIN2:
+	case OFONO_UIM_PASSWORD_PHNET_PIN:
+	case OFONO_UIM_PASSWORD_PHNETSUB_PIN:
+	case OFONO_UIM_PASSWORD_PHSP_PIN:
+	case OFONO_UIM_PASSWORD_PHCORP_PIN:
+		return TRUE;
+	case OFONO_UIM_PASSWORD_UIM_PUK:
+	case OFONO_UIM_PASSWORD_PHFUIM_PUK:
+	case OFONO_UIM_PASSWORD_UIM_PUK2:
+	case OFONO_UIM_PASSWORD_PHNET_PUK:
+	case OFONO_UIM_PASSWORD_PHNETSUB_PUK:
+	case OFONO_UIM_PASSWORD_PHSP_PUK:
+	case OFONO_UIM_PASSWORD_PHCORP_PUK:
+	case OFONO_UIM_PASSWORD_INVALID:
+	case OFONO_UIM_PASSWORD_NONE:
+		return FALSE;
+	}
+
+	return FALSE;
+}
+
+static enum ofono_uim_password_type puk2pin(enum ofono_uim_password_type t=
ype)
+{
+	switch (type) {
+	case OFONO_UIM_PASSWORD_UIM_PUK:
+		return OFONO_UIM_PASSWORD_UIM_PIN;
+	case OFONO_UIM_PASSWORD_PHFUIM_PUK:
+		return OFONO_UIM_PASSWORD_PHFUIM_PIN;
+	case OFONO_UIM_PASSWORD_UIM_PUK2:
+		return OFONO_UIM_PASSWORD_UIM_PIN2;
+	case OFONO_UIM_PASSWORD_PHNET_PUK:
+		return OFONO_UIM_PASSWORD_PHNET_PUK;
+	case OFONO_UIM_PASSWORD_PHNETSUB_PUK:
+		return OFONO_UIM_PASSWORD_PHNETSUB_PIN;
+	case OFONO_UIM_PASSWORD_PHSP_PUK:
+		return OFONO_UIM_PASSWORD_PHSP_PIN;
+	case OFONO_UIM_PASSWORD_PHCORP_PUK:
+		return OFONO_UIM_PASSWORD_PHCORP_PIN;
+	default:
+		return OFONO_UIM_PASSWORD_INVALID;
+	}
+}
+
+static char **get_locked_pins(struct ofono_uim *uim)
+{
+	int i;
+	int nelem =3D 0;
+	char **ret;
+
+	for (i =3D 1; i < OFONO_UIM_PASSWORD_UIM_PUK; i++) {
+		if (uim->locked_pins[i] =3D=3D FALSE)
+			continue;
+
+		nelem +=3D 1;
+	}
+
+	ret =3D g_new0(char *, nelem + 1);
+
+	nelem =3D 0;
+
+	for (i =3D 1; i < OFONO_UIM_PASSWORD_UIM_PUK; i++) {
+		if (uim->locked_pins[i] =3D=3D FALSE)
+			continue;
+
+		ret[nelem] =3D g_strdup(uim_passwd_name(i));
+		nelem +=3D 1;
+	}
+
+	return ret;
+}
+
+static void **get_pin_retries(struct ofono_uim *uim)
+{
+	int i, nelem;
+	void **ret;
+
+	for (i =3D 1, nelem =3D 0; i < OFONO_UIM_PASSWORD_INVALID; i++) {
+		if (uim->pin_retries[i] =3D=3D -1)
+			continue;
+
+		nelem +=3D 1;
+	}
+
+	ret =3D g_new0(void *, nelem * 2 + 1);
+
+	for (i =3D 1, nelem =3D 0; i < OFONO_UIM_PASSWORD_INVALID; i++) {
+		if (uim->pin_retries[i] =3D=3D -1)
+			continue;
+
+		ret[nelem++] =3D (void *) uim_passwd_name(i);
+		ret[nelem++] =3D &uim->pin_retries[i];
+	}
+
+	return ret;
+}
+
+static void call_state_watches(struct ofono_uim *uim)
+{
+	GSList *l;
+	ofono_uim_state_event_cb_t notify;
+
+	for (l =3D uim->state_watches->items; l; l =3D l->next) {
+		struct ofono_watchlist_item *item =3D l->data;
+		notify =3D item->notify;
+
+		notify(uim->state, item->notify_data);
+	}
+}
+
+static DBusMessage *uim_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_uim *uim =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	char **locked_pins;
+	const char *pin_name;
+	void **pin_retries;
+	dbus_bool_t present =3D uim->state !=3D OFONO_UIM_STATE_NOT_PRESENT;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	ofono_dbus_dict_append(&dict, "Present", DBUS_TYPE_BOOLEAN, &present);
+
+	if (!present)
+		goto done;
+
+	if (uim->imsi)
+		ofono_dbus_dict_append(&dict, "SubscriberIdentity",
+					DBUS_TYPE_STRING, &uim->imsi);
+
+	if (uim->mcc[0] !=3D '\0' && uim->mnc[0] !=3D '\0') {
+		const char *str;
+		str =3D uim->mcc;
+		ofono_dbus_dict_append(&dict, "MobileCountryCode",
+					DBUS_TYPE_STRING, &str);
+
+		str =3D uim->mnc;
+		ofono_dbus_dict_append(&dict, "MobileNetworkCode",
+					DBUS_TYPE_STRING, &str);
+	}
+
+
+	locked_pins =3D get_locked_pins(uim);
+	ofono_dbus_dict_append_array(&dict, "LockedPins",
+					DBUS_TYPE_STRING, &locked_pins);
+	g_strfreev(locked_pins);
+
+	pin_name =3D uim_passwd_name(uim->pin_type);
+	ofono_dbus_dict_append(&dict, "PinRequired",
+				DBUS_TYPE_STRING,
+				(void *) &pin_name);
+
+	pin_retries =3D get_pin_retries(uim);
+	ofono_dbus_dict_append_dict(&dict, "Retries", DBUS_TYPE_BYTE,
+								&pin_retries);
+	g_free(pin_retries);
+
+done:
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static void uim_pin_retries_query_cb(const struct ofono_error *error,
+					int retries[OFONO_UIM_PASSWORD_INVALID],
+					void *data)
+{
+	struct ofono_uim *uim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(uim->atom);
+	void **pin_retries;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Querying remaining pin retries failed");
+
+		return;
+	}
+
+	if (!memcmp(retries, uim->pin_retries, sizeof(uim->pin_retries)))
+		return;
+
+	memcpy(uim->pin_retries, retries, sizeof(uim->pin_retries));
+
+	pin_retries =3D get_pin_retries(uim);
+	ofono_dbus_signal_dict_property_changed(conn, path,
+				OFONO_CDMA_UIM_MANAGER_INTERFACE, "Retries",
+				DBUS_TYPE_BYTE,	&pin_retries);
+	g_free(pin_retries);
+}
+
+static void uim_pin_retries_check(struct ofono_uim *uim)
+{
+	if (uim->driver->query_pin_retries =3D=3D NULL)
+		return;
+
+	uim->driver->query_pin_retries(uim, uim_pin_retries_query_cb, uim);
+}
+
+static void uim_locked_cb(struct ofono_uim *uim, gboolean locked)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(uim->atom);
+	const char *typestr;
+	const char *pin;
+	char **locked_pins;
+	enum ofono_uim_password_type type;
+	DBusMessage *reply;
+
+	reply =3D dbus_message_new_method_return(uim->pending);
+
+	dbus_message_get_args(uim->pending, NULL, DBUS_TYPE_STRING, &typestr,
+					DBUS_TYPE_STRING, &pin,
+					DBUS_TYPE_INVALID);
+
+	type =3D uim_string_to_passwd(typestr);
+
+	/* This is used by lock/unlock pin, no puks allowed */
+	uim->locked_pins[type] =3D locked;
+	__ofono_dbus_pending_reply(&uim->pending, reply);
+
+	locked_pins =3D get_locked_pins(uim);
+	ofono_dbus_signal_array_property_changed(conn, path,
+					OFONO_CDMA_UIM_MANAGER_INTERFACE,
+					"LockedPins", DBUS_TYPE_STRING,
+					&locked_pins);
+	g_strfreev(locked_pins);
+
+	uim_pin_retries_check(uim);
+}
+
+static void uim_unlock_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_uim *uim =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBusMessage *reply =3D __ofono_error_failed(uim->pending);
+
+		__ofono_dbus_pending_reply(&uim->pending, reply);
+		__ofono_uim_recheck_pin(uim);
+
+		return;
+	}
+
+	uim_locked_cb(uim, FALSE);
+}
+
+static void uim_lock_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_uim *uim =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBusMessage *reply =3D __ofono_error_failed(uim->pending);
+
+		__ofono_dbus_pending_reply(&uim->pending, reply);
+		__ofono_uim_recheck_pin(uim);
+
+		return;
+	}
+
+	uim_locked_cb(uim, TRUE);
+}
+
+static DBusMessage *uim_lock_or_unlock(struct ofono_uim *uim, int lock,
+					DBusConnection *conn, DBusMessage *msg)
+{
+	enum ofono_uim_password_type type;
+	const char *typestr;
+	const char *pin;
+
+	if (uim->driver->lock =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	if (uim->pending)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &typestr,
+					DBUS_TYPE_STRING, &pin,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	type =3D uim_string_to_passwd(typestr);
+
+	/*
+	 * UIM PIN2 cannot be locked / unlocked according to 27.007,
+	 * however the PIN combination can be changed
+	 */
+	if (password_is_pin(type) =3D=3D FALSE ||
+			type =3D=3D OFONO_UIM_PASSWORD_UIM_PIN2)
+		return __ofono_error_invalid_format(msg);
+
+	if (!__ofono_is_valid_uim_pin(pin, type))
+		return __ofono_error_invalid_format(msg);
+
+	uim->pending =3D dbus_message_ref(msg);
+
+	uim->driver->lock(uim, type, lock, pin,
+				lock ? uim_lock_cb : uim_unlock_cb, uim);
+
+	return NULL;
+}
+
+static DBusMessage *uim_lock_pin(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_uim *uim =3D data;
+
+	return uim_lock_or_unlock(uim, 1, conn, msg);
+}
+
+static DBusMessage *uim_unlock_pin(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_uim *uim =3D data;
+
+	return uim_lock_or_unlock(uim, 0, conn, msg);
+}
+
+static void uim_change_pin_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_uim *uim =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		__ofono_dbus_pending_reply(&uim->pending,
+				__ofono_error_failed(uim->pending));
+
+		__ofono_uim_recheck_pin(uim);
+
+		return;
+	}
+
+	__ofono_dbus_pending_reply(&uim->pending,
+				dbus_message_new_method_return(uim->pending));
+
+	uim_pin_retries_check(uim);
+}
+
+static DBusMessage *uim_change_pin(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_uim *uim =3D data;
+	enum ofono_uim_password_type type;
+	const char *typestr;
+	const char *old;
+	const char *new;
+
+	if (uim->driver->change_passwd =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	if (uim->pending)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &typestr,
+					DBUS_TYPE_STRING, &old,
+					DBUS_TYPE_STRING, &new,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	type =3D uim_string_to_passwd(typestr);
+
+	if (password_is_pin(type) =3D=3D FALSE)
+		return __ofono_error_invalid_format(msg);
+
+	if (!__ofono_is_valid_uim_pin(old, type))
+		return __ofono_error_invalid_format(msg);
+
+	if (!__ofono_is_valid_uim_pin(new, type))
+		return __ofono_error_invalid_format(msg);
+
+	if (!strcmp(new, old))
+		return dbus_message_new_method_return(msg);
+
+	uim->pending =3D dbus_message_ref(msg);
+	uim->driver->change_passwd(uim, type, old, new,
+					uim_change_pin_cb, uim);
+
+	return NULL;
+}
+
+static void uim_enter_pin_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_uim *uim =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D __ofono_error_failed(uim->pending);
+	else
+		reply =3D dbus_message_new_method_return(uim->pending);
+
+	__ofono_dbus_pending_reply(&uim->pending, reply);
+
+	__ofono_uim_recheck_pin(uim);
+}
+
+static DBusMessage *uim_enter_pin(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_uim *uim =3D data;
+	const char *typestr;
+	enum ofono_uim_password_type type;
+	const char *pin;
+
+	if (uim->driver->send_passwd =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	if (uim->pending)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &typestr,
+					DBUS_TYPE_STRING, &pin,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	type =3D uim_string_to_passwd(typestr);
+
+	if (type =3D=3D OFONO_UIM_PASSWORD_NONE || type !=3D uim->pin_type)
+		return __ofono_error_invalid_format(msg);
+
+	if (password_is_pin(type) =3D=3D FALSE)
+		return __ofono_error_invalid_format(msg);
+
+	if (!__ofono_is_valid_uim_pin(pin, type))
+		return __ofono_error_invalid_format(msg);
+
+	uim->pending =3D dbus_message_ref(msg);
+	uim->driver->send_passwd(uim, pin, uim_enter_pin_cb, uim);
+
+	return NULL;
+}
+
+static DBusMessage *uim_reset_pin(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_uim *uim =3D data;
+	const char *typestr;
+	enum ofono_uim_password_type type;
+	const char *puk;
+	const char *pin;
+
+	if (uim->driver->reset_passwd =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	if (uim->pending)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &typestr,
+					DBUS_TYPE_STRING, &puk,
+					DBUS_TYPE_STRING, &pin,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	type =3D uim_string_to_passwd(typestr);
+
+	if (type =3D=3D OFONO_UIM_PASSWORD_NONE || type !=3D uim->pin_type)
+		return __ofono_error_invalid_format(msg);
+
+	if (!__ofono_is_valid_uim_pin(puk, type))
+		return __ofono_error_invalid_format(msg);
+
+	type =3D puk2pin(type);
+
+	if (!__ofono_is_valid_uim_pin(pin, type))
+		return __ofono_error_invalid_format(msg);
+
+	uim->pending =3D dbus_message_ref(msg);
+	uim->driver->reset_passwd(uim, puk, pin, uim_enter_pin_cb, uim);
+
+	return NULL;
+}
+
+static GDBusMethodTable uim_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",	uim_get_properties	},
+	{ "ChangePin",		"sss",	"",		uim_change_pin,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "EnterPin",		"ss",	"",		uim_enter_pin,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "ResetPin",		"sss",	"",		uim_reset_pin,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "LockPin",		"ss",	"",		uim_lock_pin,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "UnlockPin",		"ss",	"",		uim_unlock_pin,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable uim_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+static void uim_set_ready(struct ofono_uim *uim)
+{
+	if (uim =3D=3D NULL)
+		return;
+
+	if (uim->state !=3D OFONO_UIM_STATE_INSERTED &&
+			uim->state !=3D OFONO_UIM_STATE_LOCKED_OUT)
+		return;
+
+	uim->state =3D OFONO_UIM_STATE_READY;
+
+	call_state_watches(uim);
+}
+
+static void uim_imsi_cb(const struct ofono_error *error, const char *imsi,
+		void *data)
+{
+	struct ofono_uim *uim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(uim->atom);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Unable to read IMSI, emergency calls only");
+		return;
+	}
+
+	uim->imsi =3D g_strdup(imsi);
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CDMA_UIM_MANAGER_INTERFACE,
+					"SubscriberIdentity",
+					DBUS_TYPE_STRING, &uim->imsi);
+
+	if (uim->mnc_length) {
+		const char *str;
+
+		strncpy(uim->mcc, uim->imsi, OFONO_MAX_MCC_LENGTH);
+		uim->mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
+		strncpy(uim->mnc, uim->imsi + OFONO_MAX_MCC_LENGTH,
+			uim->mnc_length);
+		uim->mnc[uim->mnc_length] =3D '\0';
+
+		str =3D uim->mcc;
+		ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CDMA_UIM_MANAGER_INTERFACE,
+					"MobileCountryCode",
+					DBUS_TYPE_STRING, &str);
+
+		str =3D uim->mnc;
+		ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CDMA_UIM_MANAGER_INTERFACE,
+					"MobileNetworkCode",
+					DBUS_TYPE_STRING, &str);
+	}
+
+	uim_set_ready(uim);
+}
+
+static void uim_retrieve_imsi(struct ofono_uim *uim)
+{
+	if (uim->driver->read_imsi =3D=3D NULL) {
+		ofono_error("IMSI retrieval not implemented,"
+				" only emergency calls will be available");
+		return;
+	}
+
+	uim->driver->read_imsi(uim, uim_imsi_cb, uim);
+}
+
+const char *ofono_uim_get_imsi(struct ofono_uim *uim)
+{
+	if (uim =3D=3D NULL)
+		return NULL;
+
+	return uim->imsi;
+}
+
+const char *ofono_uim_get_mcc(struct ofono_uim *uim)
+{
+	if (uim =3D=3D NULL)
+		return NULL;
+
+	return uim->mcc;
+}
+
+const char *ofono_uim_get_mnc(struct ofono_uim *uim)
+{
+	if (uim =3D=3D NULL)
+		return NULL;
+
+	return uim->mnc;
+}
+
+static void uim_inserted_update(struct ofono_uim *uim)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(uim->atom);
+	dbus_bool_t present =3D uim->state !=3D OFONO_UIM_STATE_NOT_PRESENT;
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CDMA_UIM_MANAGER_INTERFACE,
+					"Present",
+					DBUS_TYPE_BOOLEAN, &present);
+}
+
+static void uim_free_main_state(struct ofono_uim *uim)
+{
+	if (uim->imsi) {
+		g_free(uim->imsi);
+		uim->imsi =3D NULL;
+	}
+
+	uim->mcc[0] =3D '\0';
+	uim->mnc[0] =3D '\0';
+}
+
+void ofono_uim_inserted_notify(struct ofono_uim *uim, ofono_bool_t inserte=
d)
+{
+	if (inserted =3D=3D TRUE && uim->state =3D=3D OFONO_UIM_STATE_NOT_PRESENT)
+		uim->state =3D OFONO_UIM_STATE_INSERTED;
+	else if (inserted =3D=3D FALSE &&
+			uim->state !=3D OFONO_UIM_STATE_NOT_PRESENT)
+		uim->state =3D OFONO_UIM_STATE_NOT_PRESENT;
+	else
+		return;
+
+	if (!__ofono_atom_get_registered(uim->atom))
+		return;
+
+	uim_inserted_update(uim);
+	call_state_watches(uim);
+}
+
+unsigned int ofono_uim_add_state_watch(struct ofono_uim *uim,
+					ofono_uim_state_event_cb_t notify,
+					void *data, ofono_destroy_func destroy)
+{
+	struct ofono_watchlist_item *item;
+
+	DBG("%p", uim);
+
+	if (uim =3D=3D NULL)
+		return 0;
+
+	if (notify =3D=3D NULL)
+		return 0;
+
+	item =3D g_new0(struct ofono_watchlist_item, 1);
+
+	item->notify =3D notify;
+	item->destroy =3D destroy;
+	item->notify_data =3D data;
+
+	return __ofono_watchlist_add_item(uim->state_watches, item);
+}
+
+void ofono_uim_remove_state_watch(struct ofono_uim *uim, unsigned int id)
+{
+	__ofono_watchlist_remove_item(uim->state_watches, id);
+}
+
+enum ofono_uim_state ofono_uim_get_state(struct ofono_uim *uim)
+{
+	if (uim =3D=3D NULL)
+		return OFONO_UIM_STATE_NOT_PRESENT;
+
+	return uim->state;
+}
+
+static void uim_pin_query_cb(const struct ofono_error *error,
+				enum ofono_uim_password_type pin_type,
+				void *data)
+{
+	struct ofono_uim *uim =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(uim->atom);
+	const char *pin_name;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Querying PIN authentication state failed");
+
+		goto checkdone;
+	}
+
+	if (uim->pin_type !=3D pin_type) {
+		uim->pin_type =3D pin_type;
+		pin_name =3D uim_passwd_name(pin_type);
+
+		if (pin_type !=3D OFONO_UIM_PASSWORD_NONE &&
+				password_is_pin(pin_type) =3D=3D FALSE)
+			pin_type =3D puk2pin(pin_type);
+
+		if (pin_type !=3D OFONO_UIM_PASSWORD_INVALID)
+			uim->locked_pins[pin_type] =3D TRUE;
+
+		ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CDMA_UIM_MANAGER_INTERFACE,
+					"PinRequired", DBUS_TYPE_STRING,
+					&pin_name);
+	}
+
+	switch (pin_type) {
+	case OFONO_UIM_PASSWORD_NONE:
+	case OFONO_UIM_PASSWORD_UIM_PIN2:
+	case OFONO_UIM_PASSWORD_UIM_PUK2:
+		break;
+	default:
+		if (uim->state =3D=3D OFONO_UIM_STATE_READY) {
+			/* Force the uim state out of READY */
+			uim_free_main_state(uim);
+
+			uim->state =3D OFONO_UIM_STATE_LOCKED_OUT;
+			call_state_watches(uim);
+		}
+		break;
+	}
+
+	uim_pin_retries_check(uim);
+
+checkdone:
+	switch (pin_type) {
+	case OFONO_UIM_PASSWORD_UIM_PIN2:
+	case OFONO_UIM_PASSWORD_UIM_PUK2:
+		if (uim->state =3D=3D OFONO_UIM_STATE_READY)
+			break;
+
+		/* Fall through */
+	case OFONO_UIM_PASSWORD_NONE:
+	default:
+		uim_retrieve_imsi(uim);
+		break;
+	}
+}
+
+void __ofono_uim_recheck_pin(struct ofono_uim *uim)
+{
+	if (uim->driver->query_passwd_state =3D=3D NULL) {
+		uim_retrieve_imsi(uim);
+		return;
+	}
+
+	uim->driver->query_passwd_state(uim, uim_pin_query_cb, uim);
+}
+
+int ofono_uim_driver_register(const struct ofono_uim_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
+
+	return 0;
+}
+
+void ofono_uim_driver_unregister(const struct ofono_uim_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
+
+static void uim_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+	struct ofono_uim *uim =3D __ofono_atom_get_data(atom);
+
+	__ofono_watchlist_free(uim->state_watches);
+	uim->state_watches =3D NULL;
+
+	g_dbus_unregister_interface(conn, path,
+					OFONO_CDMA_UIM_MANAGER_INTERFACE);
+	ofono_modem_remove_interface(modem, OFONO_CDMA_UIM_MANAGER_INTERFACE);
+}
+
+static void uim_remove(struct ofono_atom *atom)
+{
+	struct ofono_uim *uim =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (uim =3D=3D NULL)
+		return;
+
+	if (uim->driver !=3D NULL && uim->driver->remove !=3D NULL)
+		uim->driver->remove(uim);
+
+	g_free(uim);
+}
+
+struct ofono_uim *ofono_uim_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver,
+					void *data)
+{
+	struct ofono_uim *uim;
+	GSList *l;
+	int i;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	uim =3D g_try_new0(struct ofono_uim, 1);
+
+	if (uim =3D=3D NULL)
+		return NULL;
+
+	uim->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_UIM,
+						uim_remove, uim);
+
+	for (i =3D 0; i < OFONO_UIM_PASSWORD_INVALID; i++)
+		uim->pin_retries[i] =3D -1;
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_uim_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(uim, vendor, data) < 0)
+			continue;
+
+		uim->driver =3D drv;
+		break;
+	}
+
+	return uim;
+}
+
+void ofono_uim_register(struct ofono_uim *uim)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(uim->atom);
+	const char *path =3D __ofono_atom_get_path(uim->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_CDMA_UIM_MANAGER_INTERFACE,
+					uim_methods, uim_signals, NULL,
+					uim, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_CDMA_UIM_MANAGER_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_CDMA_UIM_MANAGER_INTERFACE);
+	uim->state_watches =3D __ofono_watchlist_new(g_free);
+
+	__ofono_atom_register(uim->atom, uim_unregister);
+}
+
+void ofono_uim_remove(struct ofono_uim *uim)
+{
+	__ofono_atom_free(uim->atom);
+}
+
+void ofono_uim_set_data(struct ofono_uim *uim, void *data)
+{
+	uim->driver_data =3D data;
+}
+
+void *ofono_uim_get_data(struct ofono_uim *uim)
+{
+	return uim->driver_data;
+}
+
+static ofono_bool_t is_valid_pin(const char *pin, unsigned int min,
+					unsigned int max)
+{
+	unsigned int i;
+
+	/* Pin must not be empty */
+	if (pin =3D=3D NULL || pin[0] =3D=3D '\0')
+		return FALSE;
+
+	i =3D strlen(pin);
+	if (i !=3D strspn(pin, "0123456789"))
+		return FALSE;
+
+	if (min <=3D i && i <=3D max)
+		return TRUE;
+
+	return FALSE;
+}
+
+ofono_bool_t __ofono_is_valid_uim_pin(const char *pin,
+					enum ofono_uim_password_type type)
+{
+	switch (type) {
+	case OFONO_UIM_PASSWORD_UIM_PIN:
+	case OFONO_UIM_PASSWORD_UIM_PIN2:
+		/* 11.11 Section 9.3 ("CHV"): 4..8 IA-5 digits */
+		return is_valid_pin(pin, 4, 8);
+		break;
+	case OFONO_UIM_PASSWORD_PHUIM_PIN:
+	case OFONO_UIM_PASSWORD_PHFUIM_PIN:
+	case OFONO_UIM_PASSWORD_PHNET_PIN:
+	case OFONO_UIM_PASSWORD_PHNETSUB_PIN:
+	case OFONO_UIM_PASSWORD_PHSP_PIN:
+	case OFONO_UIM_PASSWORD_PHCORP_PIN:
+		/* 22.022 Section 14 4..16 IA-5 digits */
+		return is_valid_pin(pin, 4, 16);
+		break;
+	case OFONO_UIM_PASSWORD_UIM_PUK:
+	case OFONO_UIM_PASSWORD_UIM_PUK2:
+	case OFONO_UIM_PASSWORD_PHFUIM_PUK:
+	case OFONO_UIM_PASSWORD_PHNET_PUK:
+	case OFONO_UIM_PASSWORD_PHNETSUB_PUK:
+	case OFONO_UIM_PASSWORD_PHSP_PUK:
+	case OFONO_UIM_PASSWORD_PHCORP_PUK:
+		/* 11.11 Section 9.3 ("UNBLOCK CHV"), 8 IA-5 digits */
+		return is_valid_pin(pin, 8, 8);
+		break;
+	case OFONO_UIM_PASSWORD_NONE:
+		return is_valid_pin(pin, 0, 8);
+		break;
+	case OFONO_UIM_PASSWORD_INVALID:
+		break;
+	}
+
+	return FALSE;
+}
-- =

1.7.1


--===============7559874234605867601==--

