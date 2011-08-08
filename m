Content-Type: multipart/mixed; boundary="===============3852101407357751142=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v9 4/4] cdmamodem: add data strength to CDMA netreg atom.
Date: Mon, 08 Aug 2011 14:13:20 +0200
Message-ID: <1312805600-20043-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1312805600-20043-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3852101407357751142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Bertrand Aygon <bertrand.aygon@intel.com>

---
 src/cdma-netreg.c |   54 +++++++++++++++++++++++++++++++++++++++++++------=
---
 1 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index 12ddd23..3f08d1e 100644
--- a/src/cdma-netreg.c
+++ b/src/cdma-netreg.c
@@ -34,6 +34,7 @@ static GSList *g_drivers;
 struct ofono_cdma_netreg {
 	enum cdma_netreg_status status;
 	int strength;
+	int data_strength;
 	const struct ofono_cdma_netreg_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -82,6 +83,13 @@ static DBusMessage *network_get_properties(DBusConnectio=
n *conn,
 					&strength);
 	}
 =

+	if (cdma_netreg->data_strength !=3D -1) {
+		unsigned char data_strength =3D cdma_netreg->data_strength;
+
+		ofono_dbus_dict_append(&dict, "DataStrength", DBUS_TYPE_BYTE,
+					&data_strength);
+	}
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -121,15 +129,10 @@ void ofono_cdma_netreg_status_notify(struct ofono_cdm=
a_netreg *cdma_netreg,
 		set_registration_status(cdma_netreg, status);
 }
 =

-void ofono_cdma_netreg_strength_notify(struct ofono_cdma_netreg *netreg,
-					int strength)
+static void set_signal_strength(struct ofono_cdma_netreg *netreg,
+					int strength, gboolean is_data_type)
 {
-	if (netreg =3D=3D NULL)
-		return;
-
-	if (netreg->strength =3D=3D strength)
-		return;
-
+	const char *strengh_name;
 	/*
 	 * Theoretically we can get signal strength even when not registered
 	 * to any network.  However, what do we do with it in that case?
@@ -137,7 +140,13 @@ void ofono_cdma_netreg_strength_notify(struct ofono_cd=
ma_netreg *netreg,
 	if (netreg->status =3D=3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED)
 		return;
 =

-	netreg->strength =3D strength;
+	if (is_data_type =3D=3D TRUE) {
+		strengh_name =3D "DataStrength";
+		netreg->data_strength =3D strength;
+	} else {
+		strengh_name =3D "Strength";
+		netreg->strength =3D strength;
+	}
 =

 	if (strength !=3D -1) {
 		DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -146,11 +155,35 @@ void ofono_cdma_netreg_strength_notify(struct ofono_c=
dma_netreg *netreg,
 =

 		ofono_dbus_signal_property_changed(conn, path,
 				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
-				"Strength", DBUS_TYPE_BYTE,
+				strengh_name, DBUS_TYPE_BYTE,
 				&strength);
 	}
 }
 =

+void ofono_cdma_netreg_strength_notify(struct ofono_cdma_netreg *netreg,
+					int strength)
+{
+	if (netreg =3D=3D NULL)
+		return;
+
+	if (netreg->strength =3D=3D strength)
+		return;
+
+	set_signal_strength(netreg, strength, FALSE);
+}
+
+void ofono_cdma_netreg_data_strength_notify(struct ofono_cdma_netreg *netr=
eg,
+					int data_strength)
+{
+	if (netreg =3D=3D NULL)
+		return;
+
+	if (netreg->data_strength =3D=3D data_strength)
+		return;
+
+	set_signal_strength(netreg, data_strength, TRUE);
+}
+
 int ofono_cdma_netreg_driver_register(const struct ofono_cdma_netreg_drive=
r *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -216,6 +249,7 @@ struct ofono_cdma_netreg *ofono_cdma_netreg_create(stru=
ct ofono_modem *modem,
 =

 	cdma_netreg->status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
 	cdma_netreg->strength =3D -1;
+	cdma_netreg->data_strength =3D -1;
 =

 	cdma_netreg->atom =3D __ofono_modem_add_atom(modem,
 					OFONO_ATOM_TYPE_CDMA_NETREG,
-- =

1.7.1


--===============3852101407357751142==--

