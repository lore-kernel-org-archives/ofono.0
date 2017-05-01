Content-Type: multipart/mixed; boundary="===============2437664592712021622=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 7/7] plugins/gobi: add the qmi type to the debug output of
 discover_cb()
Date: Mon, 01 May 2017 22:52:56 +0200
Message-ID: <20170501205256.4205-7-lynxis@fe80.eu>
In-Reply-To: <20170501205256.4205-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2437664592712021622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/gobi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index df35f943..a4985990 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -262,7 +262,8 @@ static void discover_cb(uint8_t count, const struct qmi=
_version *list,
 	DBG("");
 =

 	for (i =3D 0; i < count; i++) {
-		DBG("%s %d.%d", list[i].name, list[i].major, list[i].minor);
+		DBG("%s %d.%d - %d", list[i].name, list[i].major, list[i].minor,
+				list[i].type);
 =

 		switch (list[i].type) {
 		case QMI_SERVICE_DMS:
-- =

2.12.2


--===============2437664592712021622==--

