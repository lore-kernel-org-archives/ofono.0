Content-Type: multipart/mixed; boundary="===============4418820138696204118=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH] voicecall: limit g_drivers variable exposure
Date: Fri, 22 Apr 2016 13:06:11 +0000
Message-ID: <1461330367-19383-2-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330367-19383-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4418820138696204118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/voicecall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index c9b1b43..2d15d12 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -47,7 +47,7 @@
 #define SETTINGS_STORE "voicecall"
 #define SETTINGS_GROUP "Settings"
 =

-GSList *g_drivers =3D NULL;
+static GSList *g_drivers =3D NULL;
 =

 struct ofono_voicecall {
 	GSList *call_list;
-- =

1.9.1

--===============4418820138696204118==--

