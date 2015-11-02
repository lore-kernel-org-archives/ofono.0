Content-Type: multipart/mixed; boundary="===============4348309654533111922=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 3/5] plugins: Adapt to emulator changes
Date: Mon, 02 Nov 2015 18:27:18 +0100
Message-ID: <1446485240-22049-4-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1446485240-22049-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4348309654533111922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adapt to emulator changes for supporting multiple modems.
---
 plugins/dun_gw_bluez4.c | 12 +++++++++---
 plugins/dun_gw_bluez5.c | 12 +++++++++---
 plugins/hfp_ag_bluez4.c | 12 +++++++++---
 plugins/hfp_ag_bluez5.c |  8 +-------
 plugins/phonesim.c      |  3 +--
 5 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/plugins/dun_gw_bluez4.c b/plugins/dun_gw_bluez4.c
index a1de7a4..6034790 100644
--- a/plugins/dun_gw_bluez4.c
+++ b/plugins/dun_gw_bluez4.c
@@ -81,6 +81,7 @@ static void dun_gw_connect_cb(GIOChannel *io, GError *err=
, gpointer user_data)
 	struct ofono_emulator *em =3D user_data;
 	struct ofono_modem *modem;
 	int fd;
+	GList *last;
 =

 	DBG("");
 =

@@ -90,11 +91,16 @@ static void dun_gw_connect_cb(GIOChannel *io, GError *e=
rr, gpointer user_data)
 		return;
 	}
 =

-	/* Pick the first powered modem */
-	modem =3D modems->data;
+	/*
+	 * Pick the last one to avoid creating a new list with one modem just
+	 * for the call to ofono_emulator_create() (for this plugin we only
+	 * support registering one modem in the emulator)
+	 */
+	last =3D g_list_last(modems);
+	modem =3D last->data;
 	DBG("Picked modem %p for emulator", modem);
 =

-	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_DUN);
+	em =3D ofono_emulator_create(last, OFONO_EMULATOR_TYPE_DUN);
 	if (em =3D=3D NULL) {
 		g_io_channel_shutdown(io, TRUE, NULL);
 		return;
diff --git a/plugins/dun_gw_bluez5.c b/plugins/dun_gw_bluez5.c
index faea12b..6719b27 100644
--- a/plugins/dun_gw_bluez5.c
+++ b/plugins/dun_gw_bluez5.c
@@ -57,6 +57,7 @@ static DBusMessage *profile_new_connection(DBusConnection=
 *conn,
 	int fd;
 	struct ofono_emulator *em;
 	struct ofono_modem *modem;
+	GList *last;
 =

 	DBG("Profile handler NewConnection");
 =

@@ -80,7 +81,6 @@ static DBusMessage *profile_new_connection(DBusConnection=
 *conn,
 =

 	DBG("%s", device);
 =

-	/* Pick the first powered modem */
 	if (modems =3D=3D NULL) {
 		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
@@ -88,10 +88,16 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 						"No GPRS capable modem");
 	}
 =

-	modem =3D modems->data;
+	/*
+	 * Pick the last one to avoid creating a new list with one modem just
+	 * for the call to ofono_emulator_create() (for this plugin we only
+	 * support registering one modem in the emulator)
+	 */
+	last =3D g_list_last(modems);
+	modem =3D last->data;
 	DBG("Picked modem %p for emulator", modem);
 =

-	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_DUN);
+	em =3D ofono_emulator_create(last, OFONO_EMULATOR_TYPE_DUN);
 	if (em =3D=3D NULL) {
 		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
diff --git a/plugins/hfp_ag_bluez4.c b/plugins/hfp_ag_bluez4.c
index 039b665..69f6e7e 100644
--- a/plugins/hfp_ag_bluez4.c
+++ b/plugins/hfp_ag_bluez4.c
@@ -91,6 +91,7 @@ static void hfp_ag_connect_cb(GIOChannel *io, GError *err=
, gpointer user_data)
 	struct ofono_modem *modem;
 	struct ofono_emulator *em;
 	int fd;
+	GList *last;
 =

 	DBG("");
 =

@@ -99,14 +100,19 @@ static void hfp_ag_connect_cb(GIOChannel *io, GError *=
err, gpointer user_data)
 		return;
 	}
 =

-	/* Pick the first voicecall capable modem */
-	modem =3D modems->data;
+	/*
+	 * Pick the last one to avoid creating a new list with one modem just
+	 * for the call to ofono_emulator_create() (for this plugin we only
+	 * support registering one modem in the emulator)
+	 */
+	last =3D g_list_last(modems);
+	modem =3D last->data;
 	if (modem =3D=3D NULL)
 		return;
 =

 	DBG("Picked modem %p for emulator", modem);
 =

-	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_HFP);
+	em =3D ofono_emulator_create(last, OFONO_EMULATOR_TYPE_HFP);
 	if (em =3D=3D NULL)
 		return;
 =

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 22faeb7..f80d1d5 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -172,7 +172,6 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	struct sockaddr_rc saddr;
 	socklen_t optlen;
 	struct ofono_emulator *em;
-	struct ofono_modem *modem;
 	char local[BT_ADDR_SIZE], remote[BT_ADDR_SIZE];
 	struct ofono_handsfree_card *card;
 	int err;
@@ -202,7 +201,6 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 		goto invalid;
 	}
 =

-	/* Pick the first voicecall capable modem */
 	if (modems =3D=3D NULL) {
 		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
@@ -210,10 +208,6 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 						"No voice call capable modem");
 	}
 =

-	modem =3D modems->data;
-
-	DBG("Picked modem %p for emulator", modem);
-
 	memset(&saddr, 0, sizeof(saddr));
 	optlen =3D sizeof(saddr);
 =

@@ -240,7 +234,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 =

 	bt_ba2str(&saddr.rc_bdaddr, remote);
 =

-	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_HFP);
+	em =3D ofono_emulator_create(modems, OFONO_EMULATOR_TYPE_HFP);
 	if (em =3D=3D NULL) {
 		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 16bccd5..4290d84 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -545,13 +545,12 @@ static void crst_notify(GAtResult *result, gpointer u=
ser_data)
 =

 static void emulator_battery_cb(struct ofono_atom *atom, void *data)
 {
-	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
 	int val =3D 0;
 =

 	if (GPOINTER_TO_INT(data) > 0)
 		val =3D (GPOINTER_TO_INT(data) - 1) / 20 + 1;
 =

-	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_BATTERY, val);
+	ofono_emulator_set_indicator(atom, OFONO_EMULATOR_IND_BATTERY, val);
 }
 =

 static void cbc_notify(GAtResult *result, gpointer user_data)
-- =

2.1.4


--===============4348309654533111922==--

