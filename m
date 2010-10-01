Content-Type: multipart/mixed; boundary="===============5890334663136707183=="
MIME-Version: 1.0
From: Kai Vehmanen <kai.vehmanen@nokia.com>
Subject: [PATCH 1/2] isimodem: Add support for audio settings
Date: Fri, 01 Oct 2010 16:04:15 +0300
Message-ID: <1285938256-6423-2-git-send-email-kai.vehmanen@nokia.com>
In-Reply-To: <1285938256-6423-1-git-send-email-kai.vehmanen@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5890334663136707183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The audio state is mapped directly to isimodem's call server status
indications. When active, the modem speech path should be opened, and
when closed, the modem speech path may be closed.
---
 Makefile.am                       |    3 +-
 drivers/isimodem/audio-settings.c |  148 +++++++++++++++++++++++++++++++++=
++++
 drivers/isimodem/isimodem.c       |    2 +
 drivers/isimodem/isimodem.h       |    3 +
 4 files changed, 155 insertions(+), 1 deletions(-)
 create mode 100644 drivers/isimodem/audio-settings.c

diff --git a/Makefile.am b/Makefile.am
index a4888fb..cb81ee9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -128,7 +128,8 @@ builtin_sources +=3D $(gisi_sources) \
 				drivers/isimodem/gss.h \
 				drivers/isimodem/gprs.c \
 				drivers/isimodem/gprs-context.c \
-				drivers/isimodem/gpds.h
+				drivers/isimodem/gpds.h \
+				drivers/isimodem/audio-settings.c
 =

 builtin_modules +=3D isigen
 builtin_sources +=3D plugins/isigen.c
diff --git a/drivers/isimodem/audio-settings.c b/drivers/isimodem/audio-set=
tings.c
new file mode 100644
index 0000000..0ec768d
--- /dev/null
+++ b/drivers/isimodem/audio-settings.c
@@ -0,0 +1,148 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Nokia Corporation. All rights reserved.
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
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/audio-settings.h>
+
+#include <gisi/client.h>
+
+#include "debug.h"
+
+struct audio_settings_data {
+	GIsiClient *client;
+};
+
+static void isi_call_server_status_ind_cb(GIsiClient *client,
+			void const *restrict data,
+			size_t len,
+			uint16_t object,
+			void *_oas)
+{
+	struct ofono_audio_settings *oas =3D _oas;
+	struct {
+		uint8_t message_id, server_status, sub_blocks;
+	} const *m =3D data;
+	gboolean call_server_status;
+
+	DBG("Call server status changed");
+
+	if (len < 3)
+		return;
+
+	call_server_status =3D m->server_status & 0xf ? TRUE : FALSE;
+	ofono_audio_settings_active_notify(oas, call_server_status);
+}
+
+static gboolean isi_call_register(gpointer _oas)
+{
+	struct ofono_audio_settings *oas =3D _oas;
+	struct audio_settings_data *asd =3D ofono_audio_settings_get_data(oas);
+	const char *debug =3D getenv("OFONO_ISI_DEBUG");
+
+	if (debug && (strcmp(debug, "all") =3D=3D 0) =3D=3D 0)
+		g_isi_client_set_debug(asd->client, call_debug, NULL);
+
+	g_isi_subscribe(asd->client,
+			CALL_SERVER_STATUS_IND, isi_call_server_status_ind_cb,
+			oas);
+
+	ofono_audio_settings_register(oas);
+
+	return FALSE;
+}
+
+static void isi_call_verify_cb(GIsiClient *client,
+				gboolean alive, uint16_t object, void *ovc)
+{
+	if (!alive) {
+		DBG("Unable to bootstrap audio settings driver");
+		return;
+	}
+
+	DBG("%s (v%03d.%03d) reachable",
+		pn_resource_name(g_isi_client_resource(client)),
+		g_isi_version_major(client),
+		g_isi_version_minor(client));
+
+	g_idle_add(isi_call_register, ovc);
+}
+
+static int isi_audio_settings_probe(struct ofono_audio_settings *as,
+					unsigned int vendor, void *data)
+{
+	GIsiModem *idx =3D data;
+	struct audio_settings_data *asd =3D
+		g_try_new0(struct audio_settings_data, 1);
+
+	if (!asd)
+		return -ENOMEM;
+
+	asd->client =3D g_isi_client_create(idx, PN_CALL);
+	if (!asd->client) {
+		g_free(asd);
+		return -ENOMEM;
+	}
+
+	ofono_audio_settings_set_data(as, asd);
+
+	if (!g_isi_verify(asd->client, isi_call_verify_cb, as))
+		DBG("Unable to verify reachability");
+
+	return 0;
+}
+
+static void isi_audio_settings_remove(struct ofono_audio_settings *as)
+{
+	struct audio_settings_data *asd =3D ofono_audio_settings_get_data(as);
+
+	ofono_audio_settings_set_data(as, NULL);
+
+	g_free(asd);
+}
+
+static struct ofono_audio_settings_driver driver =3D {
+	.name		=3D "isimodem",
+	.probe		=3D isi_audio_settings_probe,
+	.remove		=3D isi_audio_settings_remove,
+};
+
+void isi_audio_settings_init()
+{
+	ofono_audio_settings_driver_register(&driver);
+}
+
+void isi_audio_settings_exit()
+{
+	ofono_audio_settings_driver_unregister(&driver);
+}
diff --git a/drivers/isimodem/isimodem.c b/drivers/isimodem/isimodem.c
index 10d681e..27b25ff 100644
--- a/drivers/isimodem/isimodem.c
+++ b/drivers/isimodem/isimodem.c
@@ -53,6 +53,7 @@ static int isimodem_init(void)
 	isi_radio_settings_init();
 	isi_gprs_init();
 	isi_gprs_context_init();
+	isi_audio_settings_init();
 =

 	return 0;
 }
@@ -75,6 +76,7 @@ static void isimodem_exit(void)
 	isi_radio_settings_exit();
 	isi_gprs_exit();
 	isi_gprs_context_exit();
+	isi_audio_settings_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(isimodem, "PhoNet / ISI modem driver", VERSION,
diff --git a/drivers/isimodem/isimodem.h b/drivers/isimodem/isimodem.h
index 57abcb2..873aca6 100644
--- a/drivers/isimodem/isimodem.h
+++ b/drivers/isimodem/isimodem.h
@@ -68,3 +68,6 @@ extern void isi_gprs_exit();
 =

 extern void isi_gprs_context_init();
 extern void isi_gprs_context_exit();
+
+extern void isi_audio_settings_init();
+extern void isi_audio_settings_exit();
-- =

1.7.0.4


--===============5890334663136707183==--

