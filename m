Content-Type: multipart/mixed; boundary="===============1635966554168129815=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/2] Refactor code order and remove unusable variables
Date: Fri, 13 Nov 2009 22:14:43 +0800
Message-ID: <1258121683.5426.1.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1635966554168129815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No impact to code correctness for voicecall.
---
 drivers/hfpmodem/voicecall.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 60ac45d..4b75904 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -99,10 +99,10 @@ static struct ofono_call *create_call(struct
voicecall_data *d, int type,
 		call->phone_number.type =3D num_type;
 	}
 =

-	d->calls =3D g_slist_insert_sorted(d->calls, call,
at_util_call_compare);
-
 	call->clip_validity =3D clip;
 =

+	d->calls =3D g_slist_insert_sorted(d->calls, call,
at_util_call_compare);
+
 	d->active_call =3D call;
 =

 	return call;
@@ -138,8 +138,6 @@ static void atd_cb(gboolean ok, GAtResult *result,
gpointer user_data)
 	struct ofono_voicecall *vc =3D cbd->user;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	ofono_voicecall_cb_t cb =3D cbd->cb;
-	int type =3D 128;
-	int validity =3D 2;
 	struct ofono_error error;
 	struct ofono_call *call;
 =

@@ -150,7 +148,7 @@ static void atd_cb(gboolean ok, GAtResult *result,
gpointer user_data)
 	if (!ok)
 		goto out;
 =

-	call =3D create_call(vd, 0, 0, CALL_STATUS_DIALING, NULL, type,
validity);
+	call =3D create_call(vd, 0, 0, CALL_STATUS_DIALING, NULL, 128, 2);
 =

 	if (!call) {
 		ofono_error("Unable to allocate call, "
@@ -404,8 +402,7 @@ static void ciev_notify(GAtResult *result, gpointer
user_data)
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	struct ofono_call *call =3D vd->active_call;
-	int index;
-	int value;
+	int index, value;
 	GAtResultIter iter;
 =

 	g_at_result_iter_init(&iter, result);
-- =

1.6.2.5




--===============1635966554168129815==--

