Content-Type: multipart/mixed; boundary="===============5540157189812522036=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] emulator: fix notify_ring
Date: Thu, 08 Mar 2012 16:02:30 +0100
Message-ID: <1331218950-6344-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5540157189812522036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

notify_ring should not use information from waiting call
---
 src/emulator.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 262e782..0f1ceca 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -421,13 +421,6 @@ static gboolean notify_ring(void *user_data)
 =

 	c =3D find_call_with_status(em, CALL_STATUS_INCOMING);
 =

-	/*
-	 * In case of waiting call becoming an incoming call, call status
-	 * change may not have been done yet, so try to find waiting call too
-	 */
-	if (c =3D=3D NULL)
-		c =3D find_call_with_status(em, CALL_STATUS_WAITING);
-
 	if (c =3D=3D NULL)
 		return TRUE;
 =

-- =

1.7.1


--===============5540157189812522036==--

