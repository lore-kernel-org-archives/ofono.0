Content-Type: multipart/mixed; boundary="===============5833631667530714960=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] common: APN with a dot in second position are not invalid
Date: Mon, 28 Sep 2020 09:38:09 +0200
Message-ID: <1601278689-6876-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5833631667530714960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

APN with a dot in second position (example: "t.est") are wrongly
considered invalid.
---
 src/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common.c b/src/common.c
index 4dcbc83..f955a76 100644
--- a/src/common.c
+++ b/src/common.c
@@ -709,7 +709,7 @@ const char *registration_tech_to_string(int tech)
 gboolean is_valid_apn(const char *apn)
 {
 	int i;
-	int last_period =3D 0;
+	int last_period =3D -1;
 =

 	if (apn =3D=3D NULL)
 		return FALSE;
-- =

2.7.4

--===============5833631667530714960==--

