Content-Type: multipart/mixed; boundary="===============7044422380783268378=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 12/16] elect: Add skeleton dial implementation
Date: Tue, 13 Dec 2011 16:00:06 +0100
Message-ID: <1323788410-9988-13-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7044422380783268378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am   |    3 +-
 elect/dial.c  |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 elect/elect.h |   16 +++++++++++
 3 files changed, 101 insertions(+), 1 deletions(-)
 create mode 100644 elect/dial.c

diff --git a/Makefile.am b/Makefile.am
index a11176e..588183d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -653,7 +653,8 @@ sbin_PROGRAMS +=3D elect/electd
 =

 elect_electd_SOURCES =3D $(gdbus_sources) $(btio_sources) \
 			src/log.c src/dbus.c plugins/bluetooth.c \
-			elect/main.c elect/dbus.c elect/manager.c elect/device.c
+			elect/main.c elect/dbus.c elect/manager.c elect/device.c \
+			elect/dial.c
 =

 elect_electd_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LI=
BS@ -ldl
 =

diff --git a/elect/dial.c b/elect/dial.c
new file mode 100644
index 0000000..6f83981
--- /dev/null
+++ b/elect/dial.c
@@ -0,0 +1,83 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
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
+#include <glib.h>
+
+#include "elect.h"
+
+struct elect_dial {
+	char *path;
+	void *data;
+
+	elect_dial_connect_cb_t connect_cb;
+	elect_dial_disconnect_cb_t disconnect_cb;
+};
+
+struct elect_dial *__elect_dial_create(elect_dial_connect_cb_t connect_cb,
+				elect_dial_disconnect_cb_t disconnect_cb,
+				void *data)
+{
+	struct elect_dial *dial;
+
+	DBG("");
+
+	dial =3D g_try_new0(struct elect_dial, 1);
+	if (dial =3D=3D NULL)
+		return NULL;
+
+	dial->data =3D data;
+
+	dial->connect_cb =3D connect_cb;
+	dial->disconnect_cb =3D disconnect_cb;
+
+	return dial;
+}
+
+int __elect_dial_connect(struct elect_dial *dial, const char *path)
+{
+	DBG("%s", dial->path);
+
+	g_free(dial->path);
+	dial->path =3D g_strdup(path);	=

+
+	return 0;
+}
+
+int __elect_dial_disconnect(struct elect_dial *dial)
+{
+	DBG("%s", dial->path);
+
+	return 0;
+}
+
+void __elect_dial_unref(struct elect_dial *dial)
+{
+	DBG("%s", dial->path);
+
+	g_free(dial->path);
+
+	g_free(dial);
+}
diff --git a/elect/elect.h b/elect/elect.h
index b8cccda..e79acf7 100644
--- a/elect/elect.h
+++ b/elect/elect.h
@@ -70,3 +70,19 @@ void __elect_device_foreach(elect_device_foreach_func cb=
, void *userdata);
 const char *__elect_device_get_path(struct elect_device *device);
 void __elect_device_append_properties(struct elect_device *device,
 					DBusMessageIter *dict);
+
+
+struct elect_dial;
+
+typedef void (*elect_dial_connect_cb_t)(const char *interface, const char =
*ip,
+				const char *peer,
+				const char *dns1, const char *dns2,
+				void *data);
+typedef void (*elect_dial_disconnect_cb_t)(void *data);
+
+struct elect_dial *__elect_dial_create(elect_dial_connect_cb_t connect_cb,
+				elect_dial_disconnect_cb_t disconnect_cb,
+				void *data);
+int __elect_dial_connect(struct elect_dial *dial, const char *path);
+int __elect_dial_disconnect(struct elect_dial *dial);
+void __elect_dial_unref(struct elect_dial *dial);
-- =

1.7.8.110.g4cb5d1


--===============7044422380783268378==--

