Content-Type: multipart/mixed; boundary="===============8177679605544375895=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/4] Reset the bit of local_release by call id
Date: Sat, 07 Nov 2009 15:22:28 +0800
Message-ID: <1257578549.2888.14.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8177679605544375895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Reset the bit of local_release instead of reset the whole. Because
in multi call, different bit is reset in differnet call.
---
 drivers/hfpmodem/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index e961d9a..2fed2f4 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -146,7 +146,7 @@ static void release_call(struct ofono_voicecall *vc,
struct ofono_call *call)
 	ofono_voicecall_disconnected(vc, call->id, reason, NULL);
 	at_util_release_id(&vd->id_list, call->id);
 =

-	vd->local_release =3D 0;
+	vd->local_release &=3D ~(1 << call->id);
 =

 	vd->calls =3D g_slist_remove(vd->calls, call);
 =

-- =

1.6.2.5




--===============8177679605544375895==--

