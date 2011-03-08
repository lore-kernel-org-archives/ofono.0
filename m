Content-Type: multipart/mixed; boundary="===============8906647534178274393=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH] atmodem: Enable network time for AT modem
Date: Tue, 08 Mar 2011 10:43:04 +0200
Message-ID: <1299573784-21478-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8906647534178274393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/network-registration.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 4913611..2d589f0 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -722,6 +722,8 @@ static void ifx_ctzv_notify(GAtResult *result, gpointer=
 user_data)
 	nd->time.mday =3D mday;
 	nd->time.mon =3D mon;
 	nd->time.year =3D 2000 + year;
+
+	ofono_netreg_time_notify(netreg, &nd->time);
 }
 =

 static void ifx_ctzdst_notify(GAtResult *result, gpointer user_data)
-- =

1.7.1


--===============8906647534178274393==--

