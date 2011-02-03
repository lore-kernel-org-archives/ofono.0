Content-Type: multipart/mixed; boundary="===============1793963882779367418=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH] stemodem: Fix handling of local_release.
Date: Thu, 03 Feb 2011 14:15:45 +0100
Message-ID: <1296738945-23696-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1793963882779367418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

- Reset local_release when call is disconnected.
- Change bitmap for affected types, ste_hangup is only called when
  call state is Incoming, Dialing, Alerting or Active.
- Used macros instead of numbers when creating bitmaps.
---
 drivers/stemodem/voicecall.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 1c7c0bd..d8c296e 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -250,7 +250,12 @@ static void ste_answer(struct ofono_voicecall *vc,
 static void ste_hangup(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
-	ste_template("AT+CHUP", vc, ste_generic_cb, 0x3f, cb, data);
+	unsigned int active_dial_alert_or_incoming =3D
+			(0x1 << CALL_STATUS_ACTIVE) | (0x1 << CALL_STATUS_DIALING) |
+			(0x1 << CALL_STATUS_ALERTING) | (0x1 << CALL_STATUS_INCOMING);
+
+	ste_template("AT+CHUP", vc, ste_generic_cb,
+			active_dial_alert_or_incoming, cb, data);
 }
 =

 static void ste_hold_all_active(struct ofono_voicecall *vc,
@@ -262,14 +267,17 @@ static void ste_hold_all_active(struct ofono_voicecal=
l *vc,
 static void ste_release_all_held(struct ofono_voicecall *vc,
 				ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int held_status =3D 0x1 << 1;
-	ste_template("AT+CHLD=3D0", vc, ste_generic_cb, held_status, cb, data);
+	unsigned int held =3D 0x1 << CALL_STATUS_HELD;
+
+	ste_template("AT+CHLD=3D0", vc, ste_generic_cb, held, cb, data);
 }
 =

 static void ste_set_udub(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
-	unsigned int incoming_or_waiting =3D (0x1 << 4) | (0x1 << 5);
+	unsigned int incoming_or_waiting =3D
+			(0x1 << CALL_STATUS_INCOMING) | (0x1 << CALL_STATUS_WAITING);
+
 	ste_template("AT+CHLD=3D0", vc, ste_generic_cb, incoming_or_waiting,
 			cb, data);
 }
@@ -277,7 +285,9 @@ static void ste_set_udub(struct ofono_voicecall *vc,
 static void ste_release_all_active(struct ofono_voicecall *vc,
 					ofono_voicecall_cb_t cb, void *data)
 {
-	ste_template("AT+CHLD=3D1", vc, ste_generic_cb, 0x1, cb, data);
+	unsigned int active =3D 0x1 << CALL_STATUS_ACTIVE;
+
+	ste_template("AT+CHLD=3D1", vc, ste_generic_cb, active, cb, data);
 }
 =

 static void ste_release_specific(struct ofono_voicecall *vc, int id,
@@ -472,6 +482,7 @@ static void ecav_notify(GAtResult *result, gpointer use=
r_data)
 		ofono_voicecall_disconnected(vc, existing_call->id,
 						reason, NULL);
 =

+		vd->local_release &=3D ~(1 << existing_call->id);
 		vd->calls =3D g_slist_remove(vd->calls, l->data);
 		break;
 	}
-- =

1.7.1


--===============1793963882779367418==--

