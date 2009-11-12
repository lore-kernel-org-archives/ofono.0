Content-Type: multipart/mixed; boundary="===============3588674987983468642=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/3] Add parse_clcc into atutil.c
Date: Fri, 13 Nov 2009 00:31:38 +0800
Message-ID: <1258043498.6363.2.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3588674987983468642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that it could be shared by atmodem and hfpmodem.
---
 drivers/atmodem/atutil.c |   55
++++++++++++++++++++++++++++++++++++++++++++++
 drivers/atmodem/atutil.h |    1 +
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 687a466..3a365f4 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -110,3 +110,58 @@ void at_util_release_id(unsigned int *id_list,
unsigned int id)
 	*id_list &=3D ~(1 << id);
 }
 =

+GSList *at_util_parse_clcc(GAtResult *result)
+{
+	GAtResultIter iter;
+	GSList *l =3D NULL;
+	int id, dir, status, type;
+	struct ofono_call *call;
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CLCC:")) {
+		const char *str =3D "";
+		int number_type =3D 129;
+
+		if (!g_at_result_iter_next_number(&iter, &id))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &dir))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &status))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &type))
+			continue;
+
+		if (!g_at_result_iter_skip_next(&iter))
+			continue;
+
+		if (g_at_result_iter_next_string(&iter, &str))
+			g_at_result_iter_next_number(&iter, &number_type);
+
+		call =3D g_try_new0(struct ofono_call, 1);
+
+		if (!call)
+			break;
+
+		call->id =3D id;
+		call->direction =3D dir;
+		call->status =3D status;
+		call->type =3D type;
+		strncpy(call->phone_number.number, str,
+				OFONO_MAX_PHONE_NUMBER_LENGTH);
+		call->phone_number.type =3D number_type;
+
+		if (strlen(call->phone_number.number) > 0)
+			call->clip_validity =3D 0;
+		else
+			call->clip_validity =3D 2;
+
+		l =3D g_slist_insert_sorted(l, call, at_util_call_compare);
+	}
+
+	return l;
+}
+
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 4ae1a27..82c3f3b 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -26,6 +26,7 @@ gint
at_util_call_compare_by_phone_number(gconstpointer a, gconstpointer b);
 gint at_util_call_compare(gconstpointer a, gconstpointer b);
 unsigned int at_util_alloc_next_id(unsigned int *id_list);
 void at_util_release_id(unsigned int *id_list, unsigned int id);
+GSList *at_util_parse_clcc(GAtResult *result);
 =

 struct cb_data {
 	void *cb;
-- =

1.6.2.5




--===============3588674987983468642==--

