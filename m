Content-Type: multipart/mixed; boundary="===============6374085460854791223=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 6/6] cdmamodem: Add serving system identifier support
Date: Thu, 17 Nov 2011 17:21:04 +0100
Message-ID: <1321546864-368-7-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1321546864-368-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6374085460854791223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/network-registration.c |   78 ++++++++++++++++++++++++++=
++++
 include/cdma-netreg.h                    |    7 +++
 2 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/drivers/cdmamodem/network-registration.c b/drivers/cdmamodem/n=
etwork-registration.c
index a34db91..fe8b4f2 100644
--- a/drivers/cdmamodem/network-registration.c
+++ b/drivers/cdmamodem/network-registration.c
@@ -24,6 +24,7 @@
 #endif
 =

 #define _GNU_SOURCE
+#include <string.h>
 #include <glib.h>
 #include <errno.h>
 =

@@ -108,6 +109,67 @@ static void sysinfo_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	ofono_cdma_netreg_status_notify(netreg, status);
 }
 =

+static gboolean parse_css(GAtResult *result, const char **sid)
+{
+	GAtResultIter iter;
+	/*
+	* According TIA/EIA/IS-707, CSS query returns <AB>,<SID> but
+	* according TIA/EIA/IS-707-A , it returns <Band_Class>,<Band>,<SID>
+	* PREV field which has been added afterward is ignored
+	*/
+
+	g_at_result_iter_init(&iter, result);
+
+	g_at_result_iter_next(&iter, NULL);
+
+	/* Skip first field since we are not interested in this */
+	if (!g_at_result_iter_skip_next(&iter))
+		return FALSE;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, sid))
+		return FALSE;
+	/*
+	* As CSS answer may differ according which revision of TIA/EIA/IS-707
+	* the modem is compliant, we need to check if this field is Band or SID
+	*/
+	if (*sid[0] >=3D 'A' && *sid[0] <=3D 'F') {
+		/* This is the band field, the next field is the SID*/
+		if (!g_at_result_iter_next_unquoted_string(&iter, sid))
+			return FALSE;
+	}
+
+	if (!strcmp(*sid, "99999"))
+		/* The mobile station is not registered.*/
+		return FALSE;
+
+	return TRUE;
+}
+
+static void serving_system_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_cdma_netreg_serving_system_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const char* sid;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	if (parse_css(result, &sid) =3D=3D FALSE) {
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+		return;
+	}
+
+	DBG("serving system: SID %s", sid);
+
+	cb(&error, sid, cbd->data);
+}
+
 static void mode_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_cdma_netreg *netreg =3D user_data;
@@ -184,10 +246,26 @@ static void cdma_netreg_remove(struct ofono_cdma_netr=
eg *netreg)
 	g_at_chat_unref(chat);
 }
 =

+static void cdma_netreg_serving_system(struct ofono_cdma_netreg *netreg,
+		ofono_cdma_netreg_serving_system_cb_t cb, void *data)
+{
+	GAtChat *chat =3D ofono_cdma_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(chat, "AT+CSS=3D?", NULL, serving_system_cb, cbd,
+				g_free) > 0)
+			return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
 static struct ofono_cdma_netreg_driver driver =3D {
 	.name	=3D "cdmamodem",
 	.probe	=3D cdma_netreg_probe,
 	.remove	=3D cdma_netreg_remove,
+	.serving_system =3D cdma_netreg_serving_system,
 };
 =

 void cdma_netreg_init(void)
diff --git a/include/cdma-netreg.h b/include/cdma-netreg.h
index 31ed289..529dab5 100644
--- a/include/cdma-netreg.h
+++ b/include/cdma-netreg.h
@@ -36,12 +36,19 @@ enum cdma_netreg_status {
 =

 struct ofono_cdma_netreg;
 =

+typedef void (*ofono_cdma_netreg_serving_system_cb_t)(
+				const struct ofono_error *error,
+				const char *sid,
+				void *data);
+
 struct ofono_cdma_netreg_driver {
 	const char *name;
 	int (*probe)(struct ofono_cdma_netreg *cdma_netreg,
 				unsigned int vendor,
 				void *data);
 	void (*remove)(struct ofono_cdma_netreg *cdma_netreg);
+	void (*serving_system)(struct ofono_cdma_netreg *cdma_netreg,
+			ofono_cdma_netreg_serving_system_cb_t cb, void *data);
 };
 =

 void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *netreg,
-- =

1.7.1


--===============6374085460854791223==--

