Content-Type: multipart/mixed; boundary="===============1751670010725361335=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 5/7] cdmamodem: Add serving system identifier support
Date: Thu, 24 Nov 2011 18:46:22 +0100
Message-ID: <1322156784-10402-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1322156784-10402-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1751670010725361335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/network-registration.c |   77 ++++++++++++++++++++++++++=
++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/drivers/cdmamodem/network-registration.c b/drivers/cdmamodem/n=
etwork-registration.c
index a34db91..b72295c 100644
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

@@ -108,6 +109,66 @@ static void sysinfo_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	ofono_cdma_netreg_status_notify(netreg, status);
 }
 =

+static gboolean parse_css(GAtResult *result, const char **sid)
+{
+	GAtResultIter iter;
+	/*
+	* According TIA/EIA/IS-707, CSS query returns <AB>,<SID> but
+	* according TIA/EIA/IS-707-A , it returns <Band_Class>,<Band>,<SID>.
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
+	if ((*sid[0] >=3D 'A' && *sid[0] <=3D 'F') || (*sid[0] =3D=3D 'Z'))
+		/* This is the band field, the next field is the SID*/
+		if (!g_at_result_iter_next_unquoted_string(&iter, sid))
+			return FALSE;
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
@@ -184,10 +245,26 @@ static void cdma_netreg_remove(struct ofono_cdma_netr=
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
-- =

1.7.1


--===============1751670010725361335==--

