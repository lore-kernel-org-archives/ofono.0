Content-Type: multipart/mixed; boundary="===============6371102747000679755=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] atmodem: coding style fix
Date: Tue, 18 Jan 2011 16:45:06 +0200
Message-ID: <1295361906-22559-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6371102747000679755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index c5f4a44..8d89d53 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -508,7 +508,7 @@ static void huawei_cpin_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		if (!g_at_result_iter_next_number(&iter, &val))
 			goto error;
 =

-		retries[password_types[i]]=3D val;
+		retries[password_types[i]] =3D val;
 =

 		DBG("retry counter id=3D%d, val=3D%d", password_types[i],
 						retries[password_types[i]]);
-- =

1.7.0.4


--===============6371102747000679755==--

