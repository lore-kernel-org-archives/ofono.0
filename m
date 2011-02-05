Content-Type: multipart/mixed; boundary="===============1018952768578112771=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/7] atmodem: M16 coding style fix
Date: Sat, 05 Feb 2011 06:29:06 -0800
Message-ID: <1296916151-21778-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296916151-21778-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1018952768578112771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/voicecall.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 56fd858..ee055da 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -168,7 +168,7 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 		if (oc && (nc =3D=3D NULL || (nc->id > oc->id))) {
 			enum ofono_disconnect_reason reason;
 =

-			if (vd->local_release & (0x1 << oc->id))
+			if (vd->local_release & (1 << oc->id))
 				reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
 			else
 				reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
@@ -271,8 +271,8 @@ static void generic_cb(gboolean ok, GAtResult *result, =
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

@@ -293,7 +293,7 @@ static void release_id_cb(gboolean ok, GAtResult *resul=
t,
 	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (ok)
-		vd->local_release =3D 0x1 << req->id;
+		vd->local_release =3D 1 << req->id;
 =

 	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
 			clcc_poll_cb, req->vc, NULL);
-- =

1.7.0.4


--===============1018952768578112771==--

