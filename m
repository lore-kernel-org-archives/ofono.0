Content-Type: multipart/mixed; boundary="===============2356003531556830739=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/2] Fix: Remove released call from call lists
Date: Mon, 16 Nov 2009 18:20:45 +0800
Message-ID: <1258366845.24193.1.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2356003531556830739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We should remove the released call from the list to avoid
potiential double free problem.
---
 drivers/hfpmodem/voicecall.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 689597d..d12cd4c 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -137,6 +137,8 @@ static void release_call(struct ofono_voicecall *vc,
struct ofono_call *call)
 	at_util_release_id(&vd->id_list, call->id);
 	vd->local_release &=3D ~(1 << call->id);
 =

+	vd->calls =3D g_slist_remove(vd->calls, call);
+
 	g_free(call);
 }
 =

-- =

1.6.2.5




--===============2356003531556830739==--

