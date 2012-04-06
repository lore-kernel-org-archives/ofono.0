Content-Type: multipart/mixed; boundary="===============1913250853686175026=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v4 09/10] hfp_ag: Add media transport support
Date: Fri, 06 Apr 2012 15:17:11 +0200
Message-ID: <1333718232-8447-10-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1333718232-8447-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1913250853686175026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index ea9c112..8500bff 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -37,7 +37,9 @@
 =

 #define AGENT_PATH "/hfp_ag"
 #define VERSION_1_5 0x0105
-#define FEATURES	(HFP_AG_FEATURE_3WAY | HFP_AG_FEATURE_REJECT_CALL | \
+#define FEATURES	(HFP_AG_FEATURE_3WAY | HFP_AG_FEATURE_ECNR | \
+			HFP_AG_FEATURE_IN_BAND_RING_TONE | \
+			HFP_AG_FEATURE_REJECT_CALL | \
 			HFP_AG_FEATURE_ENHANCED_CALL_STATUS | \
 			HFP_AG_FEATURE_ENHANCED_CALL_CONTROL | \
 			HFP_AG_FEATURE_EXTENDED_RES_CODE)
@@ -50,6 +52,13 @@ static guint modemwatch_id;
 static GList *modems;
 static GHashTable *sim_hash =3D NULL;
 =

+static gboolean client_event(GIOChannel *chan, GIOCondition cond, gpointer=
 data)
+{
+	bluetooth_free_audio_management(data);
+
+	return FALSE;
+}
+
 static DBusMessage *hfp_ag_agent_new_connection(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -60,6 +69,8 @@ static DBusMessage *hfp_ag_agent_new_connection(DBusConne=
ction *conn,
 	guint16 features =3D 0;
 	struct ofono_emulator *em;
 	struct ofono_modem *modem;
+	void *audio;
+	GIOChannel *io;
 =

 	fd =3D bluetooth_parse_newconnection_message(msg, &device, &uuid,
 						&version, &features, &path);
@@ -82,6 +93,12 @@ static DBusMessage *hfp_ag_agent_new_connection(DBusConn=
ection *conn,
 		return __ofono_error_failed(msg);
 =

 	ofono_emulator_register(em, fd);
+	audio =3D bluetooth_set_audio_management(em, path, features);
+
+	io =3D g_io_channel_unix_new(fd);
+	g_io_add_watch_full(io, G_PRIORITY_HIGH,
+				G_IO_HUP | G_IO_ERR | G_IO_NVAL, client_event,
+				audio, NULL);
 =

 	return dbus_message_new_method_return(msg);
 }
-- =

1.7.1


--===============1913250853686175026==--

