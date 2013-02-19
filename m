Content-Type: multipart/mixed; boundary="===============5374436713446061297=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 04/11] hfp_audio: Add initial manager methods declaration
Date: Tue, 19 Feb 2013 17:44:45 -0300
Message-ID: <1361306692-959-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5374436713446061297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the initial Handsfree Audio Manager D-Bus methods
declaration.
---
 plugins/hfp_audio.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_audio.c b/plugins/hfp_audio.c
index e90d35b..e3646e5 100644
--- a/plugins/hfp_audio.c
+++ b/plugins/hfp_audio.c
@@ -23,10 +23,72 @@
 #include <config.h>
 #endif
 =

+#include <errno.h>
 #include <stdio.h>
 =

+#include <gdbus.h>
+
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
+#include <ofono/dbus.h>
+#include <ofono/log.h>
+
+#define HFP_AUDIO_MANAGER_INTERFACE		OFONO_SERVICE ".HandsfreeAudioManager"
+
+static DBusMessage *am_get_cards(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
+						".NotImplemented",
+						"Implementation not provided");
+}
+
+static DBusMessage *am_agent_register(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
+						".NotImplemented",
+						"Implementation not provided");
+}
+
+static DBusMessage *am_agent_unregister(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
+						".NotImplemented",
+						"Implementation not provided");
+}
+
+static const GDBusMethodTable am_methods[] =3D {
+	{ GDBUS_EXPERIMENTAL_METHOD("GetCards",
+			NULL, GDBUS_ARGS({"cards", "a{oa{sv}}"}),
+			am_get_cards) } ,
+	{ GDBUS_EXPERIMENTAL_METHOD("Register",
+			GDBUS_ARGS({"path", "o"}, {"codecs", "ay"}), NULL,
+			am_agent_register) },
+	{ GDBUS_EXPERIMENTAL_METHOD("Unregister",
+			GDBUS_ARGS({"path", "o"}), NULL,
+			am_agent_unregister) },
+	{ }
+};
+
+static int hfp_audio_init(void)
+{
+	if (!g_dbus_register_interface(ofono_dbus_get_connection(),
+					"/", HFP_AUDIO_MANAGER_INTERFACE,
+					am_methods, NULL, NULL, NULL, NULL)) {
+		ofono_error("Register Handsfree Audio Manager failed");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void hfp_audio_exit(void)
+{
+	g_dbus_unregister_interface(ofono_dbus_get_connection(), "/",
+						HFP_AUDIO_MANAGER_INTERFACE);
+}
 =

 OFONO_PLUGIN_DEFINE(hfp_audio, "Handsfree Audio Plugin", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
+		OFONO_PLUGIN_PRIORITY_DEFAULT, hfp_audio_init, hfp_audio_exit)
-- =

1.7.11.7


--===============5374436713446061297==--

