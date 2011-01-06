Content-Type: multipart/mixed; boundary="===============0527945794179856542=="
MIME-Version: 1.0
From: Faiyaz Baxamusa <faiyaz.baxamusa@nokia.com>
Subject: [PATCH 2/3] include: Introduce message
Date: Thu, 06 Jan 2011 11:50:54 -0800
Message-ID: <1294343455-29551-3-git-send-email-faiyaz.baxamusa@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0527945794179856542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am       |    2 +-
 include/message.h |   67 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 68 insertions(+), 1 deletions(-)
 create mode 100644 include/message.h

diff --git a/Makefile.am b/Makefile.am
index 14f53ef..8b19eef 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -15,7 +15,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
-			include/cdma-sms.h
+			include/cdma-sms.h include/message.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

diff --git a/include/message.h b/include/message.h
new file mode 100644
index 0000000..7c60390
--- /dev/null
+++ b/include/message.h
@@ -0,0 +1,67 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_MESSAGE_H
+#define __OFONO_MESSAGE_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+enum message_state {
+	MESSAGE_STATE_PENDING,
+	MESSAGE_STATE_SENT,
+	MESSAGE_STATE_FAILED
+};
+
+struct message;
+
+struct message *ofono_message_create(const struct ofono_uuid *uuid,
+								void *data);
+
+gboolean ofono_message_dbus_register(const char *atompath, struct message =
*m);
+void ofono_message_dbus_unregister(const char *atompath, struct message *m=
);
+
+const struct ofono_uuid *ofono_message_get_uuid(const struct message *m);
+
+void ofono_message_set_state(const char *atompath, struct message *m,
+						enum message_state new_state);
+
+void ofono_message_append_properties(struct message *m, DBusMessageIter *d=
ict);
+
+void ofono_emit_message_added(const char *atompath, const char *interface,
+							struct message *m);
+
+void ofono_emit_message_removed(const char *atompath, const char *interfac=
e,
+							struct message *m);
+
+void *ofono_message_get_data(struct message *m);
+
+const char *ofono_message_path_from_uuid(const char *atompath,
+						const struct ofono_uuid *uuid);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_MESSAGE_H */
-- =

1.7.0.4


--===============0527945794179856542==--

