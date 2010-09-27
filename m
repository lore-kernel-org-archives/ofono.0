Content-Type: multipart/mixed; boundary="===============1902510541046413679=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCHv2] Fix 8bit port handling
Date: Mon, 27 Sep 2010 18:45:06 +0300
Message-ID: <1285602306-24259-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1902510541046413679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 303d673..99b0812 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1333,8 +1333,8 @@ static void sms_dispatch(struct ofono_sms *sms, GSLis=
t *sms_list)
 		}
 =

 		if (sms_extract_app_port(s, &cdst, &csrc, &is_8bit)) {
-			csrc =3D is_8bit ? csrc : (csrc << 8);
-			cdst =3D is_8bit ? cdst : (cdst << 8);
+			csrc =3D is_8bit ? (csrc << 8) : csrc;
+			cdst =3D is_8bit ? (cdst << 8) : cdst;
 =

 			if (l =3D=3D sms_list) {
 				srcport =3D csrc;
-- =

1.7.0.4


--===============1902510541046413679==--

