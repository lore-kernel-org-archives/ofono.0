Content-Type: multipart/mixed; boundary="===============8057604886161735440=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 06/12] rilmodem: Use new voicecall enums
Date: Thu, 21 Jun 2018 20:20:55 +0300
Message-ID: <1529601661-4856-6-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8057604886161735440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/voicecall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rilmodem/voicecall.c b/drivers/rilmodem/voicecall.c
index b7180b9..585f216 100644
--- a/drivers/rilmodem/voicecall.c
+++ b/drivers/rilmodem/voicecall.c
@@ -288,7 +288,7 @@ no_calls:
 			 * arrives, or RING is used, then signal the call
 			 * here
 			 */
-			if (nc->status =3D=3D CALL_STATUS_INCOMING &&
+			if (nc->status =3D=3D OFONO_CALL_STATUS_INCOMING &&
 					(vd->flags & FLAG_NEED_CLIP)) {
 				if (nc->type)
 					ofono_voicecall_notify(vc, nc);
@@ -490,7 +490,7 @@ void ril_dial(struct ofono_voicecall *vc, const struct =
ofono_phone_number *ph,
 	for (l =3D vd->calls; l; l =3D l->next) {
 		call =3D l->data;
 =

-		if (call->status =3D=3D CALL_STATUS_ACTIVE) {
+		if (call->status =3D=3D OFONO_CALL_STATUS_ACTIVE) {
 			current_active =3D 1;
 			break;
 		}
@@ -536,7 +536,7 @@ void ril_hangup_all(struct ofono_voicecall *vc, ofono_v=
oicecall_cb_t cb,
 	for (l =3D vd->calls; l; l =3D l->next) {
 		call =3D l->data;
 =

-		if (call->status =3D=3D CALL_STATUS_INCOMING) {
+		if (call->status =3D=3D OFONO_CALL_STATUS_INCOMING) {
 			/*
 			 * Need to use this request so that declined
 			 * calls in this state, are properly forwarded
-- =

1.9.1


--===============8057604886161735440==--

