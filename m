Content-Type: multipart/mixed; boundary="===============4480989084257839877=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 01/11] atutil: use g_new0 for callback data memory
Date: Sat, 29 Jan 2011 05:34:34 -0800
Message-ID: <1296308084-3726-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296308084-3726-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4480989084257839877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.h |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 3d13b84..a27de86 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -84,10 +84,7 @@ static inline struct cb_data *cb_data_new(void *cb, void=
 *data)
 {
 	struct cb_data *ret;
 =

-	ret =3D g_try_new0(struct cb_data, 1);
-	if (ret =3D=3D NULL)
-		return ret;
-
+	ret =3D g_new0(struct cb_data, 1);
 	ret->cb =3D cb;
 	ret->data =3D data;
 =

-- =

1.7.0.4


--===============4480989084257839877==--

