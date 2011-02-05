Content-Type: multipart/mixed; boundary="===============0399720196378304598=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 5/5] stemodem: Use defined call_status enum
Date: Sat, 05 Feb 2011 05:03:03 -0800
Message-ID: <1296910983-20402-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296910983-20402-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0399720196378304598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/voicecall.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 4a3a83d..b8fcf5b 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -255,8 +255,10 @@ static void ste_hangup(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	unsigned int active_dial_alert_or_incoming =3D
-			(0x1 << CALL_STATUS_ACTIVE) | (0x1 << CALL_STATUS_DIALING) |
-			(0x1 << CALL_STATUS_ALERTING) | (0x1 << CALL_STATUS_INCOMING);
+			(1 << CALL_STATUS_ACTIVE) |
+			(1 << CALL_STATUS_DIALING) |
+			(1 << CALL_STATUS_ALERTING) |
+			(1 << CALL_STATUS_INCOMING);
 =

 	ste_template("AT+CHUP", vc, ste_generic_cb,
 			active_dial_alert_or_incoming, cb, data);
@@ -271,7 +273,7 @@ static void ste_hold_all_active(struct ofono_voicecall =
*vc,
 static void ste_release_all_held(struct ofono_voicecall *vc,
 				ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int held =3D 0x1 << CALL_STATUS_HELD;
+	unsigned int held =3D 1 << CALL_STATUS_HELD;
 =

 	ste_template("AT+CHLD=3D0", vc, ste_generic_cb, held, cb, data);
 }
@@ -280,7 +282,7 @@ static void ste_set_udub(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	unsigned int incoming_or_waiting =3D
-			(0x1 << CALL_STATUS_INCOMING) | (0x1 << CALL_STATUS_WAITING);
+			(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
 =

 	ste_template("AT+CHLD=3D0", vc, ste_generic_cb, incoming_or_waiting,
 			cb, data);
@@ -289,7 +291,7 @@ static void ste_set_udub(struct ofono_voicecall *vc,
 static void ste_release_all_active(struct ofono_voicecall *vc,
 					ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int active =3D 0x1 << CALL_STATUS_ACTIVE;
+	unsigned int active =3D 1 << CALL_STATUS_ACTIVE;
 =

 	ste_template("AT+CHLD=3D1", vc, ste_generic_cb, active, cb, data);
 }
@@ -356,7 +358,8 @@ static void ste_deflect(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	char buf[128];
-	unsigned int incoming_or_waiting =3D (0x1 << 4) | (0x1 << 5);
+	unsigned int incoming_or_waiting =3D
+		(1 << CALL_STATUS_INCOMING) | (1 << CALL_STATUS_WAITING);
 =

 	snprintf(buf, sizeof(buf), "AT+CTFR=3D\"%s\",%d", ph->number, ph->type);
 	ste_template(buf, vc, ste_generic_cb, incoming_or_waiting, cb, data);
-- =

1.7.0.4


--===============0399720196378304598==--

