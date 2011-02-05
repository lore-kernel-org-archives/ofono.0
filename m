Content-Type: multipart/mixed; boundary="===============7106610310469006674=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 5/7] stemodem: M16 coding style fix
Date: Sat, 05 Feb 2011 06:29:09 -0800
Message-ID: <1296916151-21778-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296916151-21778-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7106610310469006674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/voicecall.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index b8fcf5b..ca275cd 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -148,8 +148,8 @@ static void ste_generic_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
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

@@ -166,7 +166,7 @@ static void release_id_cb(gboolean ok, GAtResult *resul=
t,
 	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (ok)
-		vd->local_release =3D 0x1 << req->id;
+		vd->local_release =3D 1 << req->id;
 =

 	req->cb(&error, req->data);
 }
@@ -481,7 +481,7 @@ static void ecav_notify(GAtResult *result, gpointer use=
r_data)
 =

 		existing_call->status =3D status;
 =

-		if (vd->local_release & (0x1 << existing_call->id))
+		if (vd->local_release & (1 << existing_call->id))
 			reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
 		else
 			reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
-- =

1.7.0.4


--===============7106610310469006674==--

