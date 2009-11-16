Content-Type: multipart/mixed; boundary="===============1644964898469792003=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/4] Fix: No need to put active call on hold
Date: Mon, 16 Nov 2009 22:11:44 +0800
Message-ID: <1258380704.5437.1.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1644964898469792003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First, call->status should be 1 stead of 2 in the loop. Second,
it's incorrect to set status to hold because later callheld=3D1
will swap call status back. So active->hold->active again is
not correct.
---
 drivers/hfpmodem/voicecall.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index ba4b4d5..d9c3c2a 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -285,7 +285,6 @@ static void atd_cb(gboolean ok, GAtResult *result,
gpointer user_data)
 	int validity =3D 2;
 	struct ofono_error error;
 	struct ofono_call *call;
-	GSList *l;
 =

 	dump_response("atd_cb", ok, result);
 =

@@ -294,17 +293,6 @@ static void atd_cb(gboolean ok, GAtResult *result,
gpointer user_data)
 	if (!ok)
 		goto out;
 =

-	/* On a success, make sure to put all active calls on hold */
-	for (l =3D vd->calls; l; l =3D l->next) {
-		call =3D l->data;
-
-		if (call->status !=3D 0)
-			continue;
-
-		call->status =3D 2;
-		ofono_voicecall_notify(vc, call);
-	}
-
 	call =3D create_call(vd, 0, 0, CALL_STATUS_DIALING, NULL, type,
validity);
 =

 	if (!call) {
-- =

1.6.2.5




--===============1644964898469792003==--

