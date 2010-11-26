Content-Type: multipart/mixed; boundary="===============8154718786775091849=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCHv4] voicecall: fix dial result handling
Date: Fri, 26 Nov 2010 17:14:49 +0200
Message-ID: <1290784489-20426-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8154718786775091849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The existing call will be automatically put on hold if there is an
existing active call when dialing. On some modems the dial request
returns only after the dialed call is active and the existing call has
been put on hold.

However, on isimodem driver the dial request returns immediately before
the existing call has changed its status. With isimodem driver the
dial_handle_result() selected the existing call from the list when it
should have created a new one.

The dial result handling now guards againt returning a previously dialed
active call as result.
---
 src/voicecall.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 52baec3..d03ac2e 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -68,6 +68,7 @@ struct voicecall {
 	char *message;
 	uint8_t icon_id;
 	gboolean untracked;
+	gboolean dial_result_handled;
 };
 =

 struct dial_request {
@@ -1096,9 +1097,18 @@ static struct voicecall *dial_handle_result(struct o=
fono_voicecall *vc,
 		v =3D l->data;
 =

 		if (v->call->status =3D=3D CALL_STATUS_DIALING ||
-				v->call->status =3D=3D CALL_STATUS_ALERTING ||
-				v->call->status =3D=3D CALL_STATUS_ACTIVE)
-			return v;
+				v->call->status =3D=3D CALL_STATUS_ALERTING)
+			goto handled;
+
+		/*
+		 * Dial request may return before existing active call
+		 * is put on hold or after dialed call has got active
+		 */
+		if (v->call->status =3D=3D CALL_STATUS_ACTIVE &&
+				v->call->direction =3D=3D
+				CALL_DIRECTION_MOBILE_ORIGINATED &&
+				!v->dial_result_handled)
+			goto handled;
 	}
 =

 	call =3D synthesize_outgoing_call(vc, number);
@@ -1119,6 +1129,9 @@ static struct voicecall *dial_handle_result(struct of=
ono_voicecall *vc,
 =

 	*need_to_emit =3D TRUE;
 =

+handled:
+	v->dial_result_handled =3D TRUE;
+
 	return v;
 }
 =

-- =

1.7.1


--===============8154718786775091849==--

