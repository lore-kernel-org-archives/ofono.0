Content-Type: multipart/mixed; boundary="===============1296126931466966697=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 4/7] ifxmodem: M16 coding style fix
Date: Sat, 05 Feb 2011 06:29:08 -0800
Message-ID: <1296916151-21778-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296916151-21778-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1296126931466966697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index 5ff3bcc..f66815a 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -160,7 +160,7 @@ static void xcallstat_notify(GAtResult *result, gpointe=
r user_data)
 	if (status =3D=3D CALL_STATUS_DISCONNECTED) {
 		enum ofono_disconnect_reason r;
 =

-		if (vd->local_release & (0x1 << call->id))
+		if (vd->local_release & (1 << call->id))
 			r =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
 		else
 			r =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
@@ -168,7 +168,7 @@ static void xcallstat_notify(GAtResult *result, gpointe=
r user_data)
 		if (call->type =3D=3D 0)
 			ofono_voicecall_disconnected(vc, call->id, r, NULL);
 =

-		vd->local_release &=3D ~(0x1 << call->id);
+		vd->local_release &=3D ~(1 << call->id);
 		vd->calls =3D g_slist_remove(vd->calls, call);
 		g_free(call);
 =

@@ -227,8 +227,8 @@ static void generic_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
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

@@ -245,7 +245,7 @@ static void release_id_cb(gboolean ok, GAtResult *resul=
t,
 	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (ok)
-		vd->local_release |=3D 0x1 << req->id;
+		vd->local_release |=3D 1 << req->id;
 =

 	req->cb(&error, req->data);
 }
-- =

1.7.0.4


--===============1296126931466966697==--

