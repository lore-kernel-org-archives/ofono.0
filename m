Content-Type: multipart/mixed; boundary="===============8364120973951638681=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 1/2] Add Suspended property to GPRS atom
Date: Wed, 08 Sep 2010 12:17:00 +0300
Message-ID: <1283937421-19465-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1283937421-19465-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8364120973951638681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Mika Liljeberg <mika.liljeberg@nokia.com>
---
 doc/connman-api.txt |   19 +++++++++++++++++++
 include/gprs.h      |    1 +
 src/gprs.c          |   21 +++++++++++++++++++++
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 43d8897..b576e19 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -77,6 +77,25 @@ Properties	boolean Attached [readonly]
 			be available, e.g. receiving SMS over packet radio
 			or network initiated PDP activation.
 =

+		boolean Suspended [readonly]
+
+			Contains whether the GPRS service is suspended.
+			During suspended state the modem is attached to the
+			GPRS service and all contexts remain established,
+			however, data transfer is not possible.
+
+			The suspended state may be entered if the modem is
+			temporarily out of network coverage. GPRS class B
+			modems will suspend GPRS whenever a voice call is
+			active at the same time. GPRS may also be suspended
+			if the network does not support simultaneous packet
+			data and voice. Various signalling procedures may
+			also cause GPRS to be briefly suspended.
+
+			As the suspension may be brief, clients should wait
+			for an appropriate time for GPRS service to resume
+			before taking corrective action.
+
 		boolean RoamingAllowed [readwrite]
 =

 			Contains whether data roaming is allowed.  In the off
diff --git a/include/gprs.h b/include/gprs.h
index a1cbcd9..7578513 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -49,6 +49,7 @@ struct ofono_gprs_driver {
 =

 void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status);
 void ofono_gprs_detached_notify(struct ofono_gprs *gprs);
+void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, ofono_bool_t statu=
s);
 =

 int ofono_gprs_driver_register(const struct ofono_gprs_driver *d);
 void ofono_gprs_driver_unregister(const struct ofono_gprs_driver *d);
diff --git a/src/gprs.c b/src/gprs.c
index d57115b..288ddd5 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -64,6 +64,7 @@ struct ofono_gprs {
 	ofono_bool_t driver_attached;
 	ofono_bool_t roaming_allowed;
 	ofono_bool_t powered;
+	ofono_bool_t suspended;
 	int status;
 	int flags;
 	struct idmap *pid_map;
@@ -1052,6 +1053,9 @@ static DBusMessage *gprs_get_properties(DBusConnectio=
n *conn,
 	value =3D gprs->powered;
 	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
 =

+	value =3D gprs->suspended;
+	ofono_dbus_dict_append(&dict, "Suspended", DBUS_TYPE_BOOLEAN, &value);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -1428,6 +1432,23 @@ static GDBusSignalTable manager_signals[] =3D {
 	{ }
 };
 =

+void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, ofono_bool_t statu=
s)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(gprs->atom);
+	dbus_bool_t value =3D status;
+
+	if (gprs->suspended =3D=3D status)
+		return;
+
+	DBG("%s suspended %d", __ofono_atom_get_path(gprs->atom), status);
+
+	gprs->suspended =3D status;
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CONNECTION_MANAGER_INTERFACE,
+					"Suspended", DBUS_TYPE_BOOLEAN, &value);
+}
+
 void ofono_gprs_detached_notify(struct ofono_gprs *gprs)
 {
 	DBG("%s", __ofono_atom_get_path(gprs->atom));
-- =

1.7.0.4


--===============8364120973951638681==--

