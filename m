Content-Type: multipart/mixed; boundary="===============3899182276474389856=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/4] Fix style issue of bit left-shifting
Date: Sat, 07 Nov 2009 15:22:59 +0800
Message-ID: <1257578579.2888.15.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3899182276474389856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change from 0x1 to 1
---
 drivers/hfpmodem/voicecall.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 2fed2f4..b1d144b 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -138,7 +138,7 @@ static void release_call(struct ofono_voicecall *vc,
struct ofono_call *call)
 	if (call =3D=3D NULL)
 		return;
 =

-	if (vd->local_release & (0x1 << call->id))
+	if (vd->local_release & (1 << call->id))
 		reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
 	else
 		reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
@@ -227,8 +227,8 @@ static void generic_cb(gboolean ok, GAtResult
*result, gpointer user_data)
 		for (l =3D vd->calls; l; l =3D l->next) {
 			call =3D l->data;
 =

-			if (req->affected_types & (0x1 << call->status))
-				vd->local_release |=3D (0x1 << call->id);
+			if (req->affected_types & (1 << call->status))
+				vd->local_release |=3D (1 << call->id);
 		}
 	}
 =

-- =

1.6.2.5




--===============3899182276474389856==--

