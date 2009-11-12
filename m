Content-Type: multipart/mixed; boundary="===============3905313400729013992=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/3] Replace parse_clcc by at_util_parse_clcc in atmodem
 voicecall
Date: Fri, 13 Nov 2009 00:32:19 +0800
Message-ID: <1258043539.6363.3.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3905313400729013992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace parse_clcc by at_util_parse_clcc in atmodem voicecall.
---
 drivers/atmodem/voicecall.c |   59
+-----------------------------------------
 1 files changed, 2 insertions(+), 57 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 9ed3696..9dae1c8 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -119,61 +119,6 @@ static struct ofono_call *create_call(struct
voicecall_data *d, int type,
 	return call;
 }
 =

-static GSList *parse_clcc(GAtResult *result)
-{
-	GAtResultIter iter;
-	GSList *l =3D NULL;
-	int id, dir, status, type;
-	struct ofono_call *call;
-
-	g_at_result_iter_init(&iter, result);
-
-	while (g_at_result_iter_next(&iter, "+CLCC:")) {
-		const char *str =3D "";
-		int number_type =3D 129;
-
-		if (!g_at_result_iter_next_number(&iter, &id))
-			continue;
-
-		if (!g_at_result_iter_next_number(&iter, &dir))
-			continue;
-
-		if (!g_at_result_iter_next_number(&iter, &status))
-			continue;
-
-		if (!g_at_result_iter_next_number(&iter, &type))
-			continue;
-
-		if (!g_at_result_iter_skip_next(&iter))
-			continue;
-
-		if (g_at_result_iter_next_string(&iter, &str))
-			g_at_result_iter_next_number(&iter, &number_type);
-
-		call =3D g_try_new0(struct ofono_call, 1);
-
-		if (!call)
-			break;
-
-		call->id =3D id;
-		call->direction =3D dir;
-		call->status =3D status;
-		call->type =3D type;
-		strncpy(call->phone_number.number, str,
-				OFONO_MAX_PHONE_NUMBER_LENGTH);
-		call->phone_number.type =3D number_type;
-
-		if (strlen(call->phone_number.number) > 0)
-			call->clip_validity =3D 0;
-		else
-			call->clip_validity =3D 2;
-
-		l =3D g_slist_insert_sorted(l, call, at_util_call_compare);
-	}
-
-	return l;
-}
-
 static void clcc_poll_cb(gboolean ok, GAtResult *result, gpointer
user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
@@ -191,7 +136,7 @@ static void clcc_poll_cb(gboolean ok, GAtResult
*result, gpointer user_data)
 		return;
 	}
 =

-	calls =3D parse_clcc(result);
+	calls =3D at_util_parse_clcc(result);
 =

 	n =3D calls;
 	o =3D vd->calls;
@@ -482,7 +427,7 @@ static void clcc_cb(gboolean ok, GAtResult *result,
gpointer user_data)
 		goto out;
 	}
 =

-	calls =3D parse_clcc(result);
+	calls =3D at_util_parse_clcc(result);
 =

 	if (calls =3D=3D NULL) {
 		CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
-- =

1.6.2.5




--===============3905313400729013992==--

