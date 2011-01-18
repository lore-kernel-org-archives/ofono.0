Content-Type: multipart/mixed; boundary="===============0603266256269446883=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] atmodem: fix signal strength issue with ifx
Date: Tue, 18 Jan 2011 17:00:31 +0200
Message-ID: <1295362831-23684-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0603266256269446883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/network-registration.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 0c77ba8..e11c974 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -662,13 +662,13 @@ static void ifx_xciev_notify(GAtResult *result, gpoin=
ter user_data)
 		return;
 =

 	if (ind =3D=3D 0)
-		strength =3D 0;
+		strength =3D -1;
 	else if (ind =3D=3D 7)
 		strength =3D 100;
 	else
 		strength =3D (ind * 15);
 =

-	ofono_netreg_strength_notify(netreg, ind);
+	ofono_netreg_strength_notify(netreg, strength);
 }
 =

 static void ciev_notify(GAtResult *result, gpointer user_data)
-- =

1.7.0.4


--===============0603266256269446883==--

