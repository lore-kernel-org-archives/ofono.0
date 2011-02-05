Content-Type: multipart/mixed; boundary="===============0190705319590019822=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 2/5] hfpmodem: Use defined call_status enum
Date: Sat, 05 Feb 2011 05:03:00 -0800
Message-ID: <1296910983-20402-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296910983-20402-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0190705319590019822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/voicecall.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index a87ddbe..f247bea 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -33,7 +33,7 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/voicecall.h>
-#include <common.h>
+#include "common.h"
 #include "gatchat.h"
 #include "gatresult.h"
 =

@@ -337,7 +337,7 @@ static void atd_cb(gboolean ok, GAtResult *result, gpoi=
nter user_data)
 	for (l =3D vd->calls; l; l =3D l->next) {
 		call =3D l->data;
 =

-		if (call->status !=3D 0)
+		if (call->status !=3D CALL_STATUS_ACTIVE)
 			continue;
 =

 		call->status =3D CALL_STATUS_HELD;
@@ -436,7 +436,7 @@ static void hfp_release_all_held(struct ofono_voicecall=
 *vc,
 				ofono_voicecall_cb_t cb, void *data)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
-	unsigned int held_status =3D 0x1 << 1;
+	unsigned int held_status =3D 1 << CALL_STATUS_HELD;
 =

 	if (vd->ag_mpty_features & AG_CHLD_0) {
 		hfp_template("AT+CHLD=3D0", vc, generic_cb, held_status,
@@ -451,7 +451,8 @@ static void hfp_set_udub(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
-	unsigned int incoming_or_waiting =3D (0x1 << 4) | (0x1 << 5);
+	unsigned int incoming_or_waiting =3D
+		(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
 =

 	if (vd->ag_mpty_features & AG_CHLD_0) {
 		hfp_template("AT+CHLD=3D0", vc, generic_cb, incoming_or_waiting,
@@ -647,7 +648,8 @@ static void ccwa_notify(GAtResult *result, gpointer use=
r_data)
 =

 	DBG("ccwa_notify: %s %d %d", num, num_type, validity);
 =

-	call =3D create_call(vc, 0, 1, 5, num, num_type, validity);
+	call =3D create_call(vc, 0, 1, CALL_STATUS_WAITING, num, num_type,
+			    validity);
 =

 	if (call =3D=3D NULL) {
 		ofono_error("malloc call struct failed.  "
-- =

1.7.0.4


--===============0190705319590019822==--

