Content-Type: multipart/mixed; boundary="===============5186162984502185972=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v6 05/14] cdmamodem: implement cdma network status.
Date: Fri, 05 Aug 2011 15:21:06 +0200
Message-ID: <1312550475-8537-6-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312550475-8537-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5186162984502185972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-netreg.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index 927af52..ec6b315 100644
--- a/src/cdma-netreg.c
+++ b/src/cdma-netreg.c
@@ -32,18 +32,36 @@
 static GSList *g_drivers;
 =

 struct ofono_cdma_netreg {
+	enum cdma_netreg_status status;
 	const struct ofono_cdma_netreg_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
 };
 =

+static const char *cdma_netreg_status_to_string(enum cdma_netreg_status st=
atus)
+{
+	switch (status) {
+	case CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED:
+		return "unregistered";
+	case CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED:
+		return "registered";
+	case CDMA_NETWORK_REGISTRATION_STATUS_ROAMING:
+		return "roaming";
+	}
+
+	return "";
+}
+
 static DBusMessage *network_get_properties(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
+	struct ofono_cdma_netreg *cdma_netreg =3D data;
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 =

+	const char *status =3D cdma_netreg_status_to_string(cdma_netreg->status);
+
 	reply =3D dbus_message_new_method_return(msg);
 	if (reply =3D=3D NULL)
 		return NULL;
@@ -54,6 +72,8 @@ static DBusMessage *network_get_properties(DBusConnection=
 *conn,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 					&dict);
 =

+	ofono_dbus_dict_append(&dict, "Status", DBUS_TYPE_STRING, &status);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -68,6 +88,31 @@ static GDBusSignalTable cdma_netreg_manager_signals[] =
=3D {
 	{ }
 };
 =

+static void set_registration_status(struct ofono_cdma_netreg *cdma_netreg,
+						enum cdma_netreg_status status)
+{
+	const char *str_status =3D cdma_netreg_status_to_string(status);
+	const char *path =3D __ofono_atom_get_path(cdma_netreg->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	cdma_netreg->status =3D status;
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
+				"Status", DBUS_TYPE_STRING,
+				&str_status);
+}
+
+void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *cdma_netreg,
+					enum cdma_netreg_status status)
+{
+	if (cdma_netreg =3D=3D NULL)
+		return;
+
+	if (cdma_netreg->status !=3D status)
+		set_registration_status(cdma_netreg, status);
+}
+
 int ofono_cdma_netreg_driver_register(const struct ofono_cdma_netreg_drive=
r *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -131,6 +176,8 @@ struct ofono_cdma_netreg *ofono_cdma_netreg_create(stru=
ct ofono_modem *modem,
 	if (cdma_netreg =3D=3D NULL)
 		return NULL;
 =

+	cdma_netreg->status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+
 	cdma_netreg->atom =3D __ofono_modem_add_atom(modem,
 					OFONO_ATOM_TYPE_CDMA_NETREG,
 					cdma_netreg_remove, cdma_netreg);
-- =

1.7.4.1

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

--===============5186162984502185972==--

