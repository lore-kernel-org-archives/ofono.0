Content-Type: multipart/mixed; boundary="===============7119771794343199209=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 4/5] hfp_ag_bluez5: Add list of HFP AG emulators
Date: Tue, 05 Feb 2013 17:26:59 +0100
Message-ID: <1360081620-19458-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1360081620-19458-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7119771794343199209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will be used to retrieve hfp_ag related to the incoming SCO
---
 plugins/hfp_ag_bluez5.c |   56 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 56 insertions(+)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 80dd601..c6b858e 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -44,9 +44,29 @@
 =

 #define HFP_AG_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_ag"
 =

+struct hfp_ag {
+	struct ofono_emulator *em;
+	bdaddr_t local;
+	bdaddr_t peer;
+};
+
 static guint modemwatch_id;
 static GList *modems;
 static GHashTable *sim_hash =3D NULL;
+static GSList *hfp_ags;
+
+static void free_hfp_ag(void *data)
+{
+	struct hfp_ag *hfp_ag =3D data;
+
+	DBG("");
+
+	if (hfp_ag =3D=3D NULL)
+		return;
+
+	hfp_ags =3D g_slist_remove(hfp_ags, hfp_ag);
+	g_free(hfp_ag);
+}
 =

 static DBusMessage *profile_new_connection(DBusConnection *conn,
 						DBusMessage *msg, void *data)
@@ -54,8 +74,13 @@ static DBusMessage *profile_new_connection(DBusConnectio=
n *conn,
 	DBusMessageIter entry;
 	const char *device;
 	int fd;
+	struct sockaddr_rc saddr;
+	bdaddr_t local;
+	bdaddr_t peer;
+	socklen_t optlen;
 	struct ofono_emulator *em;
 	struct ofono_modem *modem;
+	struct hfp_ag *hfp_ag;
 =

 	DBG("Profile handler NewConnection");
 =

@@ -79,6 +104,26 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 =

 	DBG("%s", device);
 =

+	memset(&saddr, 0, sizeof(saddr));
+	optlen =3D sizeof(saddr);
+	if (getsockname(fd, (struct sockaddr *) &saddr, &optlen) < 0) {
+		ofono_error("RFCOMM getsockname(): %s (%d)", strerror(errno),
+									errno);
+		goto error;
+	}
+
+	local =3D saddr.rc_bdaddr;
+
+	memset(&saddr, 0, sizeof(saddr));
+	optlen =3D sizeof(saddr);
+	if (getpeername(fd, (struct sockaddr *) &saddr, &optlen) < 0) {
+		ofono_error("RFCOMM getpeername(): %s (%d)", strerror(errno),
+									errno);
+		goto error;
+	}
+
+	peer =3D saddr.rc_bdaddr;
+
 	/* Pick the first voicecall capable modem */
 	modem =3D modems->data;
 	if (modem =3D=3D NULL) {
@@ -100,8 +145,19 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 =

 	ofono_emulator_register(em, fd);
 =

+	hfp_ag =3D g_new0(struct hfp_ag, 1);
+	hfp_ag->em =3D em;
+	hfp_ag->local =3D local;
+	hfp_ag->peer =3D peer;
+	ofono_emulator_set_data(em, hfp_ag, free_hfp_ag);
+
+	hfp_ags =3D g_slist_append(hfp_ags, hfp_ag);
+
 	return dbus_message_new_method_return(msg);
 =

+error:
+	close(fd);
+
 invalid:
 	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
 					"Invalid arguments in method call");
-- =

1.7.9.5


--===============7119771794343199209==--

