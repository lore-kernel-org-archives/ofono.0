Content-Type: multipart/mixed; boundary="===============2864953055359213339=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH] stemodem: Added handling of ECAV status Released.
Date: Thu, 03 Feb 2011 14:19:16 +0100
Message-ID: <1296739156-23761-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2864953055359213339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

- *ECAV UR code has been extended with a new state Released,
  sent immediately when MO call is released.
- Apply rule M11 of coding style.
---
 drivers/stemodem/voicecall.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 1c7c0bd..abd60fc 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -43,14 +43,15 @@
 #include "stemodem.h"
 =

 enum call_status_ste {
-	STE_CALL_STATUS_IDLE =3D 0,
-	STE_CALL_STATUS_CALLING =3D 1,
-	STE_CALL_STATUS_CONNECTING =3D 2,
-	STE_CALL_STATUS_ACTIVE =3D 3,
-	STE_CALL_STATUS_HOLD =3D 4,
-	STE_CALL_STATUS_WAITING =3D 5,
-	STE_CALL_STATUS_ALERTING =3D 6,
-	STE_CALL_STATUS_BUSY =3D 7
+	STE_CALL_STATUS_IDLE =3D		0,
+	STE_CALL_STATUS_CALLING =3D	1,
+	STE_CALL_STATUS_CONNECTING =3D	2,
+	STE_CALL_STATUS_ACTIVE =3D	3,
+	STE_CALL_STATUS_HOLD =3D		4,
+	STE_CALL_STATUS_WAITING =3D	5,
+	STE_CALL_STATUS_ALERTING =3D	6,
+	STE_CALL_STATUS_BUSY =3D		7,
+	STE_CALL_STATUS_RELEASED =3D	8,
 };
 =

 static const char *none_prefix[] =3D { NULL };
@@ -80,6 +81,7 @@ static int call_status_ste_to_ofono(enum call_status_ste =
status)
 {
 	switch (status) {
 	case STE_CALL_STATUS_IDLE:
+	case STE_CALL_STATUS_RELEASED:
 		return CALL_STATUS_DISCONNECTED;
 	case STE_CALL_STATUS_CALLING:
 		return CALL_STATUS_DIALING;
@@ -538,7 +540,7 @@ static int ste_voicecall_probe(struct ofono_voicecall *=
vc, unsigned int vendor,
 =

 	ofono_voicecall_set_data(vc, vd);
 =

-	g_at_chat_send(vd->chat, "AT*ECAM=3D1", none_prefix,
+	g_at_chat_send(vd->chat, "AT*ECAM=3D2", none_prefix,
 			ste_voicecall_initialized, vc, NULL);
 =

 	return 0;
-- =

1.7.1


--===============2864953055359213339==--

