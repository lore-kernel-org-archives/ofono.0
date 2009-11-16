Content-Type: multipart/mixed; boundary="===============1102492452585361705=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/2] Refactor release_with_status
Date: Mon, 16 Nov 2009 18:21:08 +0800
Message-ID: <1258366868.24193.2.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1102492452585361705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

release_with_status is rewritten based on previous patch to remove
the released call from the list.
---
 drivers/hfpmodem/voicecall.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index d12cd4c..2f52f51 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -161,27 +161,18 @@ static void release_all_calls(struct
ofono_voicecall *vc)
 static void release_with_status(struct ofono_voicecall *vc, int status)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
-	GSList *p =3D NULL;
 	GSList *c =3D vd->calls;
 	struct ofono_call *call;
 =

 	while (c) {
 		call =3D c->data;
 =

-		if (call->status !=3D status) {
-			p =3D c;
-			c =3D c->next;
-			continue;
-		}
-
-		release_call(vc, call);
+		if (call->status =3D=3D status) {
+			release_call(vc, call);
 =

-		if (p)
-			p->next =3D c->next;
-		else
-			vd->calls =3D c->next;
-
-			g_slist_free_1(c);
+			c =3D vd->calls;
+		} else
+			c =3D c->next;
 	}
 }
 =

-- =

1.6.2.5




--===============1102492452585361705==--

