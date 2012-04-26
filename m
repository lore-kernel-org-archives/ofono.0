Content-Type: multipart/mixed; boundary="===============5511505642418035046=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v5 11/12] hfp_ag: Add media transport support
Date: Thu, 26 Apr 2012 16:27:03 +0200
Message-ID: <1335450424-19964-12-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1335450424-19964-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5511505642418035046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index ea9c112..9279745 100644
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
@@ -60,6 +62,7 @@ static DBusMessage *hfp_ag_agent_new_connection(DBusConne=
ction *conn,
 	guint16 features =3D 0;
 	struct ofono_emulator *em;
 	struct ofono_modem *modem;
+	struct bt_audio *audio;
 =

 	fd =3D bluetooth_parse_newconnection_message(msg, &device, &uuid,
 						&version, &features, &path);
@@ -82,6 +85,9 @@ static DBusMessage *hfp_ag_agent_new_connection(DBusConne=
ction *conn,
 		return __ofono_error_failed(msg);
 =

 	ofono_emulator_register(em, fd);
+	audio =3D bluetooth_set_audio_management(em, path, features);
+	ofono_emulator_set_data(em, audio,
+			(ofono_destroy_func)bluetooth_free_audio_management);
 =

 	return dbus_message_new_method_return(msg);
 }
-- =

1.7.1


--===============5511505642418035046==--

