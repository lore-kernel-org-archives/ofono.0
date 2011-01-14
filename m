Content-Type: multipart/mixed; boundary="===============3667565121707173790=="
MIME-Version: 1.0
From: Helen Clemson <clemson.helen@gmail.com>
Subject: [PATCH] stemodem: Fix spelling mistake in error message.
Date: Fri, 14 Jan 2011 11:29:35 +0100
Message-ID: <1295000975-10862-1-git-send-email-clemson.helen@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3667565121707173790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Helen Clemson <helen.clemson@stericsson.com>

---
 drivers/stemodem/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index ea3d48f..68caa81 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -469,7 +469,7 @@ static void ecav_notify(GAtResult *result, gpointer use=
r_data)
 	if (l =3D=3D NULL && status !=3D CALL_STATUS_DIALING &&
 				status !=3D CALL_STATUS_WAITING &&
 				status !=3D CALL_STATUS_INCOMING) {
-		ofono_error("ECAV notification for unknow call."
+		ofono_error("ECAV notification for unknown call."
 				" id: %d, status: %d", id, status);
 		return;
 	}
-- =

1.7.1


--===============3667565121707173790==--

