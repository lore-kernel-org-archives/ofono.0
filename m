Content-Type: multipart/mixed; boundary="===============9141981335950331976=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH] string_to_phone_number: remove redumdant predicate
Date: Tue, 23 Nov 2010 14:40:38 +0200
Message-ID: <1290516038-7926-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9141981335950331976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the first character is a plus sign, then it is not a nul, then
the string length is true anyway.
---
 src/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/common.c b/src/common.c
index 22bf1c2..1088b5d 100644
--- a/src/common.c
+++ b/src/common.c
@@ -396,7 +396,7 @@ const char *phone_number_to_string(const struct ofono_p=
hone_number *ph)
 =

 void string_to_phone_number(const char *str, struct ofono_phone_number *ph)
 {
-	if (strlen(str) && str[0] =3D=3D '+') {
+	if (str[0] =3D=3D '+') {
 		strcpy(ph->number, str+1);
 		ph->type =3D 145;	/* International */
 	} else {
-- =

1.7.1


--===============9141981335950331976==--

