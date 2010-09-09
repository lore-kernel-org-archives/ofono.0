Content-Type: multipart/mixed; boundary="===============4683860186155011729=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] Fix port number handling
Date: Thu, 09 Sep 2010 11:03:47 +0300
Message-ID: <1284019427-11659-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4683860186155011729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove unnecessary bit shift.
---
 src/sms.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 088119d..461606d 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -804,8 +804,6 @@ static void sms_dispatch(struct ofono_sms *sms, GSList =
*sms_list)
 		}
 =

 		if (sms_extract_app_port(s, &cdst, &csrc, &is_8bit)) {
-			csrc =3D is_8bit ? csrc : (csrc << 8);
-			cdst =3D is_8bit ? cdst : (cdst << 8);
 =

 			if (l =3D=3D sms_list) {
 				srcport =3D csrc;
-- =

1.7.0.4


--===============4683860186155011729==--

