Content-Type: multipart/mixed; boundary="===============6369503698002609408=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/2] atmodem: convert dst from hours to seconds
Date: Tue, 01 Feb 2011 13:44:04 +0200
Message-ID: <1296560645-19062-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296560645-19062-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6369503698002609408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/network-registration.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 4913611..3df72af 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -741,7 +741,7 @@ static void ifx_ctzdst_notify(GAtResult *result, gpoint=
er user_data)
 =

 	DBG("dst %d", dst);
 =

-	nd->time.dst =3D dst;
+	nd->time.dst =3D dst * 60 * 60;
 =

 	ofono_netreg_time_notify(netreg, &nd->time);
 }
-- =

1.7.0.4


--===============6369503698002609408==--

