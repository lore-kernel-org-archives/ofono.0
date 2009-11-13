Content-Type: multipart/mixed; boundary="===============2009440763241861009=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/2] Rename call to active_call to be more meanful
Date: Fri, 13 Nov 2009 22:14:14 +0800
Message-ID: <1258121654.5426.0.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2009440763241861009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rename vd->call to vd->active_call in hfpmodem voicecall.c
---
 drivers/hfpmodem/voicecall.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 9ba72e4..60ac45d 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -53,7 +53,7 @@ static const char *chld_prefix[] =3D { "+CHLD:", NULL };
 struct voicecall_data {
 	GAtChat *chat;
 	GSList *calls;
-	struct ofono_call *call;
+	struct ofono_call *active_call;
 	unsigned int ag_features;
 	unsigned int ag_mpty_features;
 	unsigned char cind_pos[HFP_INDICATOR_LAST];
@@ -103,7 +103,7 @@ static struct ofono_call *create_call(struct
voicecall_data *d, int type,
 =

 	call->clip_validity =3D clip;
 =

-	d->call =3D call;
+	d->active_call =3D call;
 =

 	return call;
 }
@@ -339,8 +339,8 @@ static void release_call(struct ofono_voicecall *vc,
struct ofono_call *call)
 =

 	vd->calls =3D g_slist_remove(vd->calls, call);
 =

-	if (call =3D=3D vd->call)
-		vd->call =3D NULL;
+	if (call =3D=3D vd->active_call)
+		vd->active_call =3D NULL;
 =

 	g_free(call);
 }
@@ -403,7 +403,7 @@ static void ciev_notify(GAtResult *result, gpointer
user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
-	struct ofono_call *call =3D vd->call;
+	struct ofono_call *call =3D vd->active_call;
 	int index;
 	int value;
 	GAtResultIter iter;
@@ -491,7 +491,7 @@ static int hfp_voicecall_probe(struct
ofono_voicecall *vc, unsigned int vendor,
 =

 	vd->chat =3D data->chat;
 	vd->ag_features =3D data->ag_features;
-	vd->call =3D NULL;
+	vd->active_call =3D NULL;
 =

 	memcpy(vd->cind_pos, data->cind_pos, HFP_INDICATOR_LAST);
 	memcpy(vd->cind_val, data->cind_val, HFP_INDICATOR_LAST);
-- =

1.6.2.5




--===============2009440763241861009==--

