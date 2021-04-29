Content-Type: multipart/mixed; boundary="===============2075197621464440150=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] simutil: Fill unused part of AID with FFs
Date: Thu, 29 Apr 2021 19:09:21 +0300
Message-ID: <20210429160921.3153725-1-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2075197621464440150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Correct handling of short AIDs will take more than that, but
leaving part of the array uninitialized is wrong in any case.
---
 src/simutil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/simutil.c b/src/simutil.c
index 5d2aa6a2..e648c918 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1588,6 +1588,7 @@ GSList *sim_parse_app_template_entries(const unsigned=
 char *buffer, int len)
 			goto error;
 =

 		memcpy(app.aid, aid, app.aid_len);
+		memset(app.aid + app.aid_len, 0xff, 16 - app.aid_len);
 =

 		app.type =3D (app.aid[5] << 8) | app.aid[6];
 =

-- =

2.25.1

--===============2075197621464440150==--

