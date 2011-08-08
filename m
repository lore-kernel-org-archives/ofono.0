Content-Type: multipart/mixed; boundary="===============7632389615368264126=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v7 4/4] cdmamodem: add data strength to CDMA netreg atom.
Date: Mon, 08 Aug 2011 13:53:29 +0200
Message-ID: <1312804409-6913-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1312804409-6913-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7632389615368264126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Bertrand Aygon <bertrand.aygon@intel.com>

---
 src/cdma-netreg.c |   48 +++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index 12ddd23..f1fcb26 100644
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
@@ -121,15 +129,9 @@ void ofono_cdma_netreg_status_notify(struct ofono_cdma=
_netreg *cdma_netreg,
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
 	/*
 	 * Theoretically we can get signal strength even when not registered
 	 * to any network.  However, what do we do with it in that case?
@@ -137,7 +139,10 @@ void ofono_cdma_netreg_strength_notify(struct ofono_cd=
ma_netreg *netreg,
 	if (netreg->status =3D=3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED)
 		return;
 =

-	netreg->strength =3D strength;
+	if (is_data_type =3D=3D TRUE)
+		netreg->data_strength =3D strength;
+	else
+		netreg->strength =3D strength;
 =

 	if (strength !=3D -1) {
 		DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -151,6 +156,30 @@ void ofono_cdma_netreg_strength_notify(struct ofono_cd=
ma_netreg *netreg,
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
@@ -216,6 +245,7 @@ struct ofono_cdma_netreg *ofono_cdma_netreg_create(stru=
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


--===============7632389615368264126==--

