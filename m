Content-Type: multipart/mixed; boundary="===============8098585841029097669=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] voicecall: fix voicecalls_release_queue
Date: Thu, 24 Mar 2011 18:43:22 +0100
Message-ID: <1300988602-12513-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8098585841029097669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

voicecalls_release_queue uses struct ofono_call instead of
struct voicecall (which is used in "calls" list parameter and
function voicecalls_release_next)
---
 src/voicecall.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 4932ffa..b1d5586 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1070,7 +1070,7 @@ static void voicecalls_emit_call_added(struct ofono_v=
oicecall *vc,
 static void voicecalls_release_queue(struct ofono_voicecall *vc, GSList *c=
alls)
 {
 	GSList *l;
-	struct ofono_call *call;
+	struct voicecall *call;
 =

 	g_slist_free(vc->release_list);
 	vc->release_list =3D NULL;
@@ -1078,7 +1078,7 @@ static void voicecalls_release_queue(struct ofono_voi=
cecall *vc, GSList *calls)
 	for (l =3D calls; l; l =3D l->next) {
 		call =3D l->data;
 =

-		if (call->status =3D=3D CALL_STATUS_WAITING)
+		if (call->call->status =3D=3D CALL_STATUS_WAITING)
 			continue;
 =

 		vc->release_list =3D g_slist_prepend(vc->release_list, l->data);
-- =

1.7.1


--===============8098585841029097669==--

