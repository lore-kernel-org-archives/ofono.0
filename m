Content-Type: multipart/mixed; boundary="===============7573657669071650633=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 1/2] gprs: netreg_status_changed: output the status as human
 readable string
Date: Sun, 28 Apr 2019 13:28:14 +0200
Message-ID: <20190428112815.1407-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7573657669071650633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index 148cbc979dfb..5f66cad591c1 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1700,7 +1700,7 @@ static void netreg_status_changed(int status, int lac=
, int ci, int tech,
 {
 	struct ofono_gprs *gprs =3D data;
 =

-	DBG("%d", status);
+	DBG("%d (%s)", status, registration_status_to_string(status));
 =

 	gprs->netreg_status =3D status;
 =

-- =

2.21.0


--===============7573657669071650633==--

