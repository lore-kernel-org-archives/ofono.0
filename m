Content-Type: multipart/mixed; boundary="===============8804592022001524345=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 1/7] handsfree-audio: Add Manager registration
Date: Wed, 20 Feb 2013 18:55:45 -0300
Message-ID: <1361397351-5841-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361397351-5841-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8804592022001524345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds the initial implementation of new experimental Handsfree Audio
Manager interface. This patch adds the interface registration and
the declaration of it's methods.
---
 Makefile.am           |  3 +-
 src/handsfree-audio.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/main.c            |  4 +++
 src/ofono.h           |  3 ++
 4 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 src/handsfree-audio.c

diff --git a/Makefile.am b/Makefile.am
index ef4d314..76d33b4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -507,7 +507,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/gnssagent.c src/gnssagent.h \
 			src/cdma-smsutil.h src/cdma-smsutil.c \
 			src/cdma-sms.c src/private-network.c src/cdma-netreg.c \
-			src/cdma-provision.c src/handsfree.c
+			src/cdma-provision.c src/handsfree.c \
+			src/handsfree-audio.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ -ldl
 =

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
new file mode 100644
index 0000000..e75c977
--- /dev/null
+++ b/src/handsfree-audio.c
@@ -0,0 +1,81 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+#include <stdio.h>
+
+#include <gdbus.h>
+
+#include "ofono.h"
+
+#define HFP_AUDIO_MANAGER_INTERFACE		OFONO_SERVICE ".HandsfreeAudioManager"
+
+static DBusMessage *am_get_cards(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	return __ofono_error_not_implemented(msg);
+}
+
+static DBusMessage *am_agent_register(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	return __ofono_error_not_implemented(msg);
+}
+
+static DBusMessage *am_agent_unregister(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	return __ofono_error_not_implemented(msg);
+}
+
+static const GDBusMethodTable am_methods[] =3D {
+	{ GDBUS_METHOD("GetCards",
+			NULL, GDBUS_ARGS({"cards", "a{oa{sv}}"}),
+			am_get_cards) } ,
+	{ GDBUS_METHOD("Register",
+			GDBUS_ARGS({"path", "o"}, {"codecs", "ay"}), NULL,
+			am_agent_register) },
+	{ GDBUS_METHOD("Unregister",
+			GDBUS_ARGS({"path", "o"}), NULL,
+			am_agent_unregister) },
+	{ }
+};
+
+int __ofono_handsfree_audio_manager_init(void)
+{
+	if (!g_dbus_register_interface(ofono_dbus_get_connection(),
+					"/", HFP_AUDIO_MANAGER_INTERFACE,
+					am_methods, NULL, NULL, NULL, NULL)) {
+		return -EIO;
+	}
+
+	return 0;
+}
+
+void __ofono_handsfree_audio_manager_cleanup(void)
+{
+	g_dbus_unregister_interface(ofono_dbus_get_connection(), "/",
+						HFP_AUDIO_MANAGER_INTERFACE);
+}
diff --git a/src/main.c b/src/main.c
index 46bb90b..d6349cb 100644
--- a/src/main.c
+++ b/src/main.c
@@ -239,6 +239,8 @@ int main(int argc, char **argv)
 =

 	__ofono_manager_init();
 =

+	__ofono_handsfree_audio_manager_init();
+
 	__ofono_plugin_init(option_plugin, option_noplugin);
 =

 	g_free(option_plugin);
@@ -248,6 +250,8 @@ int main(int argc, char **argv)
 =

 	__ofono_plugin_cleanup();
 =

+	__ofono_handsfree_audio_manager_cleanup();
+
 	__ofono_manager_cleanup();
 =

 	__ofono_modemwatch_cleanup();
diff --git a/src/ofono.h b/src/ofono.h
index 15c1dc5..8abaf1e 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -30,6 +30,9 @@ void __ofono_exit(void);
 int __ofono_manager_init(void);
 void __ofono_manager_cleanup(void);
 =

+int __ofono_handsfree_audio_manager_init(void);
+void __ofono_handsfree_audio_manager_cleanup(void);
+
 void __ofono_modem_shutdown(void);
 =

 #include <ofono/log.h>
-- =

1.7.11.7


--===============8804592022001524345==--

