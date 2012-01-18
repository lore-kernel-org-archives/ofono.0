Content-Type: multipart/mixed; boundary="===============2713643929887672651=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 4/6] huaweimodem: Probe the QCDM port with the version info
 request
Date: Wed, 18 Jan 2012 18:05:15 +0100
Message-ID: <1326906317-11601-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1326906317-11601-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2713643929887672651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweimodem/cdma-netreg.c |   66 ++++++++++++++++++++++++++++++---=
---
 1 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/drivers/huaweimodem/cdma-netreg.c b/drivers/huaweimodem/cdma-n=
etreg.c
index 2ae66e1..bf48b53 100644
--- a/drivers/huaweimodem/cdma-netreg.c
+++ b/drivers/huaweimodem/cdma-netreg.c
@@ -24,6 +24,8 @@
 #endif
 =

 #define _GNU_SOURCE
+#include <string.h>
+#include <stdio.h>
 #include <glib.h>
 #include <errno.h>
 =

@@ -32,11 +34,19 @@
 #include <ofono/cdma-netreg.h>
 =

 #include "gatchat.h"
+#include "gatqcdm.h"
 =

 #include "huaweimodem.h"
 =

 static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
 =

+struct netreg_data {
+	GAtChat *chat;
+	GAtHDLC *diag;
+	void *cb;
+	void *cb_data;
+};
+
 static gboolean parse_sysinfo(GAtResult *result, gint *status)
 {
 	GAtResultIter iter;
@@ -107,12 +117,34 @@ static void sysinfo_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	ofono_cdma_netreg_status_notify(netreg, status);
 }
 =

+static void version_info_cb(const unsigned char *buf, gsize len,
+							gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
+	struct version_info verinfo;
+
+	if (!g_at_qcdm_result_get_version_info(buf, len, &verinfo)) {
+		/* This is probably not a QCDM port */
+		g_at_hdlc_unref(nd->diag);
+		nd->diag =3D NULL;
+		return;
+	}
+
+	DBG("Version information\n");
+	DBG("Compiled Date: %s\n", verinfo.comp_date);
+	DBG("Compiled Time: %s\n", verinfo.comp_time);
+	DBG("Release Date: %s\n", verinfo.rel_date);
+	DBG("Release Time: %s\n", verinfo.rel_time);
+	DBG("Model: %s\n", verinfo.model);
+	DBG("MSM version: %d\n", verinfo.msm_ver);
+}
 static void mode_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_cdma_netreg *netreg =3D user_data;
-	GAtChat *chat =3D ofono_cdma_netreg_get_data(netreg);
+	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
 =

-	g_at_chat_send(chat, "AT^SYSINFO", sysinfo_prefix,
+	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix,
 				sysinfo_cb, netreg, NULL);
 }
 =

@@ -169,20 +201,20 @@ error:
 static void probe_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_cdma_netreg *netreg =3D user_data;
-	GAtChat *chat =3D ofono_cdma_netreg_get_data(netreg);
+	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
 =

 	if (!ok) {
 		ofono_cdma_netreg_remove(netreg);
 		return;
 	}
 =

-	g_at_chat_register(chat, "^MODE:",
+	g_at_chat_register(nd->chat, "^MODE:",
 				mode_notify, FALSE, netreg, NULL);
 =

-	g_at_chat_register(chat, "^RSSILVL:",
+	g_at_chat_register(nd->chat, "^RSSILVL:",
 				rssilvl_notify, FALSE, netreg, NULL);
 =

-	g_at_chat_register(chat, "^HRSSILVL:",
+	g_at_chat_register(nd->chat, "^HRSSILVL:",
 				hrssilvl_notify, FALSE, netreg, NULL);
 =

 	ofono_cdma_netreg_register(netreg);
@@ -191,23 +223,35 @@ static void probe_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 static int huawei_cdma_netreg_probe(struct ofono_cdma_netreg *netreg,
 				unsigned int vendor, void *data)
 {
-	GAtChat *chat =3D g_at_chat_clone(data);
+	struct netreg_data *nd;
 =

-	ofono_cdma_netreg_set_data(netreg, chat);
+	nd =3D g_new0(struct netreg_data, 1);
 =

-	g_at_chat_send(chat, "AT^SYSINFO", sysinfo_prefix,
+	nd->chat =3D g_at_chat_clone(data);
+	nd->diag =3D g_at_chat_get_slave_qcdm(data);
+
+	ofono_cdma_netreg_set_data(netreg, nd);
+
+	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix,
 				probe_cb, netreg, NULL);
 =

+	if (nd->diag)
+		/* Request version info to probe the QCDM port */
+		g_at_qcdm_send(nd->diag, G_AT_QCDM_CMD_VERSION_INFO,
+					version_info_cb, netreg);
+
 	return 0;
 }
 =

 static void huawei_cdma_netreg_remove(struct ofono_cdma_netreg *netreg)
 {
-	GAtChat *chat =3D ofono_cdma_netreg_get_data(netreg);
+	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
 =

 	ofono_cdma_netreg_set_data(netreg, NULL);
 =

-	g_at_chat_unref(chat);
+	g_at_chat_unref(nd->chat);
+	g_at_hdlc_unref(nd->diag);
+	g_free(nd);
 }
 =

 static struct ofono_cdma_netreg_driver driver =3D {
-- =

1.7.1


--===============2713643929887672651==--

