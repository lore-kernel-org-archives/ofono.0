Content-Type: multipart/mixed; boundary="===============0913538225782186439=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: [PATCH 1/3] Move and rename call_compare and call_compare_by_status
 to atutil.c
Date: Wed, 28 Oct 2009 08:41:53 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E089B924EEC@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0913538225782186439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Below patch is to rename call_compare and call_compare_by_status into atuti=
l.c
so that they could be shared by atmodem and hfpmodem drivers.

---
 drivers/atmodem/atutil.c    |   27 +++++++++++++++++++++++++++
 drivers/atmodem/atutil.h    |    2 ++
 drivers/atmodem/voicecall.c |   39 +++++++--------------------------------
 3 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 5d9ceb8..465d258 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -33,6 +33,7 @@
 #include <ofono/types.h>
 =

 #include "atutil.h"
+#include "types.h"
 =

 void dump_response(const char *func, gboolean ok, GAtResult *result)
 {
@@ -55,3 +56,29 @@ void decode_at_error(struct ofono_error *error, const ch=
ar *final)
 		error->error =3D 0;
 	}
 }
+
+gint at_util_call_compare_by_status(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_call *call =3D a;
+	int status =3D GPOINTER_TO_INT(b);
+
+	if (status !=3D call->status)
+		return 1;
+
+	return 0;
+}
+
+gint at_util_call_compare(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_call *ca =3D a;
+	const struct ofono_call *cb =3D b;
+
+	if (ca->id < cb->id)
+		return -1;
+
+	if (ca->id > cb->id)
+		return 1;
+
+	return 0;
+}
+
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index c30c70b..ab9db05 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -21,6 +21,8 @@
 =

 void decode_at_error(struct ofono_error *error, const char *final);
 void dump_response(const char *func, gboolean ok, GAtResult *result);
+gint at_util_call_compare_by_status(gconstpointer a, gconstpointer b);
+gint at_util_call_compare(gconstpointer a, gconstpointer b);
 =

 struct cb_data {
 	void *cb;
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 22a802f..f0c8d93 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -109,31 +109,6 @@ static void release_id(struct voicecall_data *d, unsig=
ned int id)
 	d->id_list &=3D ~(0x1 << id);
 }
 =

-static gint call_compare_by_status(gconstpointer a, gconstpointer b)
-{
-	const struct ofono_call *call =3D a;
-	int status =3D GPOINTER_TO_INT(b);
-
-	if (status !=3D call->status)
-		return 1;
-
-	return 0;
-}
-
-static gint call_compare(gconstpointer a, gconstpointer b)
-{
-	const struct ofono_call *ca =3D a;
-	const struct ofono_call *cb =3D b;
-
-	if (ca->id < cb->id)
-		return -1;
-
-	if (ca->id > cb->id)
-		return 1;
-
-	return 0;
-}
-
 static struct ofono_call *create_call(struct voicecall_data *d, int type,
 					int direction, int status,
 					const char *num, int num_type, int clip)
@@ -159,7 +134,7 @@ static struct ofono_call *create_call(struct voicecall_=
data *d, int type,
 =

 	call->clip_validity =3D clip;
 =

-	d->calls =3D g_slist_insert_sorted(d->calls, call, call_compare);
+	d->calls =3D g_slist_insert_sorted(d->calls, call, at_util_call_compare);
 =

 	return call;
 }
@@ -213,7 +188,7 @@ static GSList *parse_clcc(GAtResult *result)
 		else
 			call->clip_validity =3D 2;
 =

-		l =3D g_slist_insert_sorted(l, call, call_compare);
+		l =3D g_slist_insert_sorted(l, call, at_util_call_compare);
 	}
 =

 	return l;
@@ -729,12 +704,12 @@ static void ring_notify(GAtResult *result, gpointer u=
ser_data)
 =

 	/* See comment in CRING */
 	if (g_slist_find_custom(vd->calls, GINT_TO_POINTER(5),
-				call_compare_by_status))
+				at_util_call_compare_by_status))
 		return;
 =

 	/* RING can repeat, ignore if we already have an incoming call */
 	if (g_slist_find_custom(vd->calls, GINT_TO_POINTER(4),
-				call_compare_by_status))
+				at_util_call_compare_by_status))
 		return;
 =

 	/* Generate an incoming call of unknown type */
@@ -768,12 +743,12 @@ static void cring_notify(GAtResult *result, gpointer =
user_data)
 	 * when a waiting call exists (cannot have waiting + incoming in GSM)
 	 */
 	if (g_slist_find_custom(vd->calls, GINT_TO_POINTER(5),
-				call_compare_by_status))
+				at_util_call_compare_by_status))
 		return;
 =

 	/* CRING can repeat, ignore if we already have an incoming call */
 	if (g_slist_find_custom(vd->calls, GINT_TO_POINTER(4),
-				call_compare_by_status))
+				at_util_call_compare_by_status))
 		return;
 =

 	g_at_result_iter_init(&iter, result);
@@ -818,7 +793,7 @@ static void clip_notify(GAtResult *result, gpointer use=
r_data)
 	dump_response("clip_notify", TRUE, result);
 =

 	l =3D g_slist_find_custom(vd->calls, GINT_TO_POINTER(4),
-				call_compare_by_status);
+				at_util_call_compare_by_status);
 =

 	if (l =3D=3D NULL) {
 		ofono_error("CLIP for unknown call");
-- =

1.6.2.5


Regards,
Zhenhua
=20

--===============0913538225782186439==--

