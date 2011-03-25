Content-Type: multipart/mixed; boundary="===============6395806072388314700=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/2] ifxmodem: add support for emergency number list
Date: Fri, 25 Mar 2011 07:08:03 -0700
Message-ID: <1301062083-20416-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301062083-20416-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6395806072388314700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c |   98 ++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index 87a48e6..a92ac11 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -42,11 +42,13 @@
 #include "ifxmodem.h"
 =

 static const char *none_prefix[] =3D { NULL };
+static const char *xlema_prefix[] =3D { "+XLEMA:", NULL };
 =

 struct voicecall_data {
 	GSList *calls;
 	unsigned int local_release;
 	GAtChat *chat;
+	GSList *en_list;
 };
 =

 struct release_id_req {
@@ -786,6 +788,95 @@ static void xcolp_notify(GAtResult *result, gpointer u=
ser_data)
 	ofono_voicecall_notify(vc, call);
 }
 =

+static gint number_compare(gconstpointer a, gconstpointer b)
+{
+	const char *s1 =3D a, *s2 =3D b;
+	return strcmp(s1, s2);
+}
+
+static void xlema_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GAtResultIter iter;
+	int index, total_cnt;
+	const char *number;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XLEMA:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &index))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &total_cnt))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &number))
+		return;
+
+	// Skip the category, EN valid with simpresence and mcc fields
+
+	if (!g_slist_find_custom(vd->en_list, number, number_compare))
+		vd->en_list =3D g_slist_prepend(vd->en_list, g_strdup(number));
+
+	if (index !=3D total_cnt)
+		return;
+
+	vd->en_list =3D g_slist_reverse(vd->en_list);
+
+	ofono_voicecall_en_list_notify(vc, vd->en_list);
+
+	g_slist_foreach(vd->en_list, (GFunc) g_free, NULL);
+	g_slist_free(vd->en_list);
+	vd->en_list =3D NULL;
+}
+
+static void xlema_read(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GAtResultIter iter;
+	int index, total_cnt;
+	const char *number;
+
+	if (!ok) {
+		DBG("Emergency number list read failed");
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+XLEMA:")) {
+		if (!g_at_result_iter_next_number(&iter, &index))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &total_cnt))
+			continue;
+
+		if (!g_at_result_iter_next_string(&iter, &number))
+			continue;
+
+		// Skip the category, EN valid with simpresence and mcc fields
+		g_at_result_iter_skip_next(&iter);
+		g_at_result_iter_skip_next(&iter);
+		g_at_result_iter_skip_next(&iter);
+
+		if (!g_slist_find_custom(vd->en_list, number, number_compare))
+			vd->en_list =3D g_slist_prepend(vd->en_list,
+							g_strdup(number));
+	}
+
+	vd->en_list =3D g_slist_reverse(vd->en_list);
+
+	ofono_voicecall_en_list_notify(vc, vd->en_list);
+
+	g_slist_foreach(vd->en_list, (GFunc) g_free, NULL);
+	g_slist_free(vd->en_list);
+	vd->en_list =3D NULL;
+}
+
 static void ifx_voicecall_initialized(gboolean ok, GAtResult *result,
 					gpointer user_data)
 {
@@ -803,7 +894,14 @@ static void ifx_voicecall_initialized(gboolean ok, GAt=
Result *result,
 							FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+XCOLP:", xcolp_notify, FALSE, vc, NULL);
 =

+	g_at_chat_register(vd->chat, "+XLEMA:", xlema_notify, FALSE, vc, NULL);
+	/* Enable emergency number list notification */
+	g_at_chat_send(vd->chat, "AT+XLEMA=3D1", none_prefix, NULL, NULL, NULL);
+
 	ofono_voicecall_register(vc);
+
+	g_at_chat_send(vd->chat, "AT+XLEMA?", xlema_prefix, xlema_read, vc,
+									NULL);
 }
 =

 static int ifx_voicecall_probe(struct ofono_voicecall *vc, unsigned int ve=
ndor,
-- =

1.7.0.4


--===============6395806072388314700==--

