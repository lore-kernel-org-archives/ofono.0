Content-Type: multipart/mixed; boundary="===============4194829702656979015=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCHv5] plugin: Add ste modem initd integration
Date: Thu, 06 Jan 2011 10:38:02 +0100
Message-ID: <1294306682-7309-1-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1294265175.2521.24.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4194829702656979015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

This patch introduces auto discovery of ST-Ericsson modems.
ST-Ericsson modems (M57XX, M7XX, M74XX) are managed by a
Modem Init Daemon responsible for start, power cycles,
flashing etc. This STE plugin monitors the modem state exposed
from the Modem Init Damon's Dbus API. When the modem is in state
"on" the STE modem is created and registered. Muliple modem
instances, and reset handling is supported.
---
Hi Marcel.

>> +
>> +builtin_modules +=3D stemgr
>> +builtin_sources +=3D plugins/stemgr.c
>> +
>
> This is a minor nitpick, but I think this is better placed between ste
> and caif plugin details. And not on top of stemodem.
Sure, I've moved this entry.

>> +#define MGR_SERVICE          "com.stericsson.modeminit"
>> +#define MGR_MGR_INTERFACE    MGR_SERVICE ".Manager"
>
> Really? MGR_MGR and not MGR_MANAGER ;)
Oops, s/mid/mgr didn't do it right this time ;-)
Let's call it MGR_INTERFACE instead.

>> +struct ste_modem {
>> +     struct ofono_modem *modem;
>> +     char *path;
>
> You don't have to necessarily do it this way, but since you are using
> the path memory also as index for your hash table it might be good to
> put it first in your struct.

Ok, I've put path first in struct.
>> +static guint mgr_api_watch;
>
> It is more like a service watch or daemon watch.
Yes, I renamed this to modem_daemon_watch.
>
>> +static guint mgr_state_watch;
>
> And this is property changed watch, right?
Yes, renamed this to property_changed_watch

> What is this exactly for? How many do you expect to have pending?
I have removed this one. get_modems is *only* called
when the Modem Init Daemon is first connected.

>> +static inline gboolean is_ready(const char *action)
>> +{
>> +     return g_strcmp0(action, "ready") =3D=3D 0;
>> +}
...
> This is nasty. Why not convert the state into an enum once and be done
> with it.
Nasty? Anyway I've changed this to a ste_operation enum,
and I'll give you that - it does make the state machine a more readable.

>
> I find this all a bit complicated. Can you quickly describe the logic
> here in plain words.
Sure, I've written some prose describing the state machine.
I've also done this function like a standard FSM implementation:

switch(state) {
case STATE_A:
     switch (operation) {
     case OPERATION_1:
...


>> +static void get_modems(const char *path)
>> +{
>
> This path parameter is rather pointless. It is always "/".
Agree.

>> +     if (get_modems_call_pending)
>> +             return;
>
> I still haven't figured out what you are trying to protect here.
....
>> +static gboolean property_changed(DBusConnection *connection,
>> +                                     DBusMessage *message, void *user_d=
ata)
>> +{
...
>> +     stemodem =3D g_hash_table_lookup(modem_list,
>> +                                     dbus_message_get_path(message));
>> +
>> +     if (stemodem =3D=3D NULL) {
>> +             get_modems("/");
>> +             return TRUE;
>> +     }
>
> So here we go. So you are expecting a property changed signal before
> GetModems finished and therefor you just call it again. This is rather
> pointless since you get the properties with the return of the GetModems
> call and these should be the actual ones.
>
> So if the modem path is not in your hash-table, then just ignore the
> property changed signal.

Yes, agree. This was a left over from previous API. I have removed this =

completely. get_modems() is only called when Modem Init Daemon API =

becomes available. If modems ever pop up dynamically I will add a new
signal for this in the DBus API as suggested.

>> +static void stemgr_exit()
>> +{
>
> The only thing you missed here is to remove the property changed watch
> in case it was registered (aka the init daemon started).
Good catch thanks, I'v removed this watch.

Thank you for reviewing this code, hopefully we're close to completion now =
;-)

Regards,
Sjur

 Makefile.am      |    3 +
 plugins/stemgr.c |  385 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 388 insertions(+), 0 deletions(-)
 create mode 100644 plugins/stemgr.c

diff --git a/Makefile.am b/Makefile.am
index 8a8555d..1e4f9df 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -292,6 +292,9 @@ builtin_sources +=3D plugins/ifx.c
 builtin_modules +=3D ste
 builtin_sources +=3D plugins/ste.c
 =

+builtin_modules +=3D stemgr
+builtin_sources +=3D plugins/stemgr.c
+
 builtin_modules +=3D caif
 builtin_sources +=3D plugins/caif.c
 endif
diff --git a/plugins/stemgr.c b/plugins/stemgr.c
new file mode 100644
index 0000000..0e2745c
--- /dev/null
+++ b/plugins/stemgr.c
@@ -0,0 +1,385 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011 ST-Ericsson AB.
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
+#include <errno.h>
+#include <string.h>
+#include <net/if.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/dbus.h>
+
+/*
+ * ST-Ericsson's Modem Init Daemon is used for controling the modem power
+ * cycles and provides a dbus API for modem state and properties.
+ */
+#define MGR_SERVICE		"com.stericsson.modeminit"
+#define MGR_INTERFACE		MGR_SERVICE ".Manager"
+#define MGR_GET_MODEMS		"GetModems"
+#define GET_MODEMS_TIMEOUT	5000
+
+#define MGR_MODEM_INTERFACE	MGR_SERVICE ".Modem"
+#define PROPERTY_CHANGED	"PropertyChanged"
+
+enum ste_state {
+	STE_STATE_OFF,
+	STE_STATE_READY,
+	STE_STATE_RESET
+};
+
+enum ste_operation {
+	STE_OP_STARTING,
+	STE_OP_READY,
+	STE_OP_RESTART,
+	STE_OP_OFF
+};
+
+struct ste_modem {
+	char *path;
+	struct ofono_modem *modem;
+	enum ste_state state;
+	char *serial;
+	char *interface;
+};
+
+static GHashTable *modem_list;
+static guint modem_daemon_watch;
+static guint property_changed_watch;
+static DBusConnection *connection;
+
+static void state_change(struct ste_modem *stemodem, enum ste_operation op)
+{
+	switch (stemodem->state) {
+	case STE_STATE_OFF:
+		/*
+		 * The STE Modem is in state OFF and we're waiting for
+		 * the Modem Init Daemon to signal that modem is ready
+		 * in order to create and register the modem.
+		 */
+		switch (op) {
+		case STE_OP_READY:
+			stemodem->modem =3D ofono_modem_create(stemodem->serial,
+								"ste");
+			if (stemodem->modem =3D=3D NULL) {
+				ofono_error("Could not create modem %s, %s",
+						stemodem->path,
+						stemodem->serial);
+				return;
+			}
+
+			DBG("register modem %s, %s", stemodem->path,
+				stemodem->serial);
+
+			if (stemodem->interface !=3D NULL)
+				ofono_modem_set_string(stemodem->modem,
+							"Interface",
+							stemodem->interface);
+
+			ofono_modem_register(stemodem->modem);
+			stemodem->state =3D STE_STATE_READY;
+			break;
+		case STE_OP_STARTING:
+		case STE_OP_RESTART:
+		case STE_OP_OFF:
+			break;
+		}
+		break;
+	case STE_STATE_READY:
+		/*
+		 * The STE Modem is ready and the modem has been created
+		 * and registered in oFono. In this state two things can
+		 * happen: Modem restarts or is turned off. Turning off
+		 * the modem is an exceptional situation e.g. high-temperature,
+		 * low battery or upgrade. In this scenario we remove the
+		 * STE modem from oFono.
+		 */
+		switch (op) {
+		case STE_OP_READY:
+			break;
+		case STE_OP_STARTING:
+		case STE_OP_RESTART:
+			DBG("reset ongoing %s", stemodem->path);
+			/* Note: Consider to power off modem here? */
+			stemodem->state =3D STE_STATE_RESET;
+			break;
+		case STE_OP_OFF:
+			DBG("STE modem unregistering %s", stemodem->path);
+			ofono_modem_remove(stemodem->modem);
+			stemodem->modem =3D NULL;
+			stemodem->state =3D STE_STATE_OFF;
+			break;
+		}
+		break;
+	case STE_STATE_RESET:
+		/*
+		 * The STE Modem is resetting.In this state two things can
+		 * happen: Modem restarts succeeds, or modem is turned off.
+		 */
+		switch (op) {
+		case STE_OP_STARTING:
+		case STE_OP_RESTART:
+			break;
+		case STE_OP_READY:
+			DBG("STE modem reset complete %s", stemodem->path);
+			if (ofono_modem_get_powered(stemodem->modem))
+				ofono_modem_reset(stemodem->modem);
+			stemodem->state =3D STE_STATE_READY;
+			break;
+		case STE_OP_OFF:
+			DBG("STE modem unregistering %s", stemodem->path);
+			ofono_modem_remove(stemodem->modem);
+			stemodem->modem =3D NULL;
+			stemodem->state =3D STE_STATE_OFF;
+			break;
+		}
+		break;
+	}
+}
+
+static void update_property(struct ste_modem *stemodem, const char *prop,
+				DBusMessageIter *iter, enum ste_operation *op,
+				gboolean *op_valid)
+{
+	const char *value;
+
+	if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_STRING)
+		return;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	if (g_strcmp0(prop, "State") =3D=3D 0) {
+		*op_valid =3D TRUE;
+		if (g_strcmp0(value, "booting") =3D=3D 0)
+			*op =3D STE_OP_STARTING;
+		else if (g_strcmp0(value, "upgrading") =3D=3D 0)
+			*op =3D STE_OP_OFF;
+		else if (g_strcmp0(value, "ready") =3D=3D 0)
+			*op =3D STE_OP_READY;
+		else if (g_strcmp0(value, "off") =3D=3D 0)
+			*op =3D STE_OP_OFF;
+		else if (g_strcmp0(value, "dumping") =3D=3D 0)
+			*op =3D STE_OP_RESTART;
+		else
+			*op_valid =3D FALSE;
+	} else if (g_strcmp0(prop, "Interface") =3D=3D 0) {
+		g_free(stemodem->interface);
+		stemodem->interface =3D g_strdup(value);
+	} else if (g_strcmp0(prop, "Serial") =3D=3D 0) {
+		g_free(stemodem->serial);
+		stemodem->serial =3D g_strdup(value);
+	}
+}
+
+static void update_modem_properties(const char *path, DBusMessageIter *ite=
r)
+{
+	enum ste_operation operation;
+	gboolean operation_valid;
+	struct ste_modem *stemodem =3D g_hash_table_lookup(modem_list, path);
+
+	if (stemodem =3D=3D NULL) {
+		stemodem =3D g_try_new0(struct ste_modem, 1);
+		if (stemodem =3D=3D NULL)
+			return;
+
+		stemodem->path =3D g_strdup(path);
+		stemodem->state =3D STE_STATE_OFF;
+		g_hash_table_insert(modem_list, stemodem->path, stemodem);
+	}
+
+	while (dbus_message_iter_get_arg_type(iter) =3D=3D DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter entry, value;
+		const char *key;
+
+		dbus_message_iter_recurse(iter, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		update_property(stemodem, key, &value, &operation,
+					&operation_valid);
+
+		dbus_message_iter_next(iter);
+	}
+
+	if (operation_valid)
+		state_change(stemodem, operation);
+}
+
+static void get_modems_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusMessageIter iter, list;
+	DBusError err;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&err);
+
+	if (dbus_set_error_from_message(&err, reply)) {
+		ofono_error("%s: %s\n", err.name, err.message);
+		dbus_error_free(&err);
+		goto done;
+	}
+
+	if (!dbus_message_has_signature(reply, "a(oa{sv})"))
+		goto done;
+
+	if (!dbus_message_iter_init(reply, &iter))
+		goto done;
+
+	dbus_message_iter_recurse(&iter, &list);
+
+	while (dbus_message_iter_get_arg_type(&list) =3D=3D DBUS_TYPE_STRUCT) {
+		DBusMessageIter entry, dict;
+		const char *path;
+
+		dbus_message_iter_recurse(&list, &entry);
+		dbus_message_iter_get_basic(&entry, &path);
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &dict);
+
+		update_modem_properties(path, &dict);
+
+		dbus_message_iter_next(&list);
+	}
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void get_modems()
+{
+	DBusMessage *message;
+	DBusPendingCall *call;
+
+	message =3D dbus_message_new_method_call(MGR_SERVICE, "/",
+					MGR_INTERFACE, MGR_GET_MODEMS);
+	if (message =3D=3D NULL) {
+		ofono_error("Unable to allocate new D-Bus message");
+		goto error;
+	}
+
+	dbus_message_set_auto_start(message, FALSE);
+
+	if (!dbus_connection_send_with_reply(connection, message, &call,
+						GET_MODEMS_TIMEOUT)) {
+		ofono_error("Sending D-Bus message failed");
+		goto error;
+	}
+
+	if (call =3D=3D NULL) {
+		DBG("D-Bus connection not available");
+		goto error;
+	}
+
+	dbus_pending_call_set_notify(call, get_modems_reply, NULL, NULL);
+	dbus_pending_call_unref(call);
+
+error:
+	dbus_message_unref(message);
+}
+
+static gboolean property_changed(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	DBusMessageIter iter;
+	struct ste_modem *stemodem;
+	const char *key;
+	enum ste_operation operation;
+	gboolean operation_valid;
+
+	stemodem =3D g_hash_table_lookup(modem_list,
+					dbus_message_get_path(message));
+
+	if (stemodem =3D=3D NULL)
+		return TRUE;
+
+
+	if (!dbus_message_iter_init(message, &iter))
+		return TRUE;
+
+	dbus_message_iter_get_basic(&iter, &key);
+	dbus_message_iter_next(&iter);
+
+	update_property(stemodem, key, &iter, &operation, &operation_valid);
+
+	if (operation_valid)
+		state_change(stemodem, operation);
+
+	return TRUE;
+}
+
+static void mgr_connect(DBusConnection *connection, void *user_data)
+{
+	property_changed_watch =3D g_dbus_add_signal_watch(connection, NULL,
+						NULL,
+						MGR_MODEM_INTERFACE,
+						PROPERTY_CHANGED,
+						property_changed,
+						NULL, NULL);
+	get_modems();
+}
+
+static void mgr_disconnect(DBusConnection *connection, void *user_data)
+{
+	g_hash_table_remove_all(modem_list);
+	g_dbus_remove_watch(connection, property_changed_watch);
+}
+
+static void destroy_stemodem(gpointer data)
+{
+	struct ste_modem *stemodem =3D data;
+
+	ofono_modem_remove(stemodem->modem);
+	g_free(stemodem->interface);
+	g_free(stemodem->path);
+	g_free(stemodem->serial);
+	g_free(stemodem);
+}
+
+static int stemgr_init()
+{
+	connection =3D ofono_dbus_get_connection();
+
+	modem_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						NULL, destroy_stemodem);
+	modem_daemon_watch =3D g_dbus_add_service_watch(connection, MGR_SERVICE,
+				mgr_connect, mgr_disconnect, NULL, NULL);
+	return 0;
+}
+
+static void stemgr_exit()
+{
+	g_hash_table_destroy(modem_list);
+	g_dbus_remove_watch(connection, modem_daemon_watch);
+	g_dbus_remove_watch(connection, property_changed_watch);
+}
+
+OFONO_PLUGIN_DEFINE(stemgr, "ST-Ericsson Modem Init Daemon detection", VER=
SION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, stemgr_init, stemgr_exit)
-- =

1.7.0.4


--===============4194829702656979015==--

