Content-Type: multipart/mixed; boundary="===============7778148416764844507=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/4] Move up release_call to avoid forward declaration
Date: Sat, 07 Nov 2009 15:21:57 +0800
Message-ID: <1257578517.2888.13.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7778148416764844507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Function body has no change.
---
 drivers/hfpmodem/voicecall.c |   52
+++++++++++++++++++++---------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 5104afa..e961d9a 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -130,6 +130,32 @@ static struct ofono_call *new_call_notify(struct
ofono_voicecall *vc, int type,
 	return c;
 }
 =

+static void release_call(struct ofono_voicecall *vc, struct ofono_call
*call)
+{
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	enum ofono_disconnect_reason reason;
+
+	if (call =3D=3D NULL)
+		return;
+
+	if (vd->local_release & (0x1 << call->id))
+		reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
+	else
+		reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
+
+	ofono_voicecall_disconnected(vc, call->id, reason, NULL);
+	at_util_release_id(&vd->id_list, call->id);
+
+	vd->local_release =3D 0;
+
+	vd->calls =3D g_slist_remove(vd->calls, call);
+
+	if (call =3D=3D vd->call)
+		vd->call =3D NULL;
+
+	g_free(call);
+}
+
 static GSList *parse_clcc(GAtResult *result)
 {
 	GAtResultIter iter;
@@ -405,32 +431,6 @@ static void clip_notify(GAtResult *result, gpointer
user_data)
 	ofono_voicecall_notify(vc, call);
 }
 =

-static void release_call(struct ofono_voicecall *vc, struct ofono_call
*call)
-{
-	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
-	enum ofono_disconnect_reason reason;
-
-	if (call =3D=3D NULL)
-		return;
-
-	if (vd->local_release & (0x1 << call->id))
-		reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
-	else
-		reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
-
-	ofono_voicecall_disconnected(vc, call->id, reason, NULL);
-	at_util_release_id(&vd->id_list, call->id);
-
-	vd->local_release =3D 0;
-
-	vd->calls =3D g_slist_remove(vd->calls, call);
-
-	if (call =3D=3D vd->call)
-		vd->call =3D NULL;
-
-	g_free(call);
-}
-
 static void ciev_call_notify(struct ofono_voicecall *vc,
 				struct ofono_call *call,
 				unsigned int value)
-- =

1.6.2.5




--===============7778148416764844507==--

