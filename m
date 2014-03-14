Content-Type: multipart/mixed; boundary="===============2199598493715686136=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 2/2] unit: Fix test to use valid EF_PNN
Date: Fri, 14 Mar 2014 17:23:44 +0100
Message-ID: <1394814224-30014-2-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1394814224-30014-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2199598493715686136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

test-simutil was not using EF_PNN files with a valid format.
---
 unit/test-simutil.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index cf76a37..69dd81e 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -345,10 +345,12 @@ const unsigned char valid_efopl[] =3D {
 };
 =

 const unsigned char valid_efpnn[][28] =3D {
-	{ 0x43, 0x0a, 0x00, 0x54, 0x75, 0x78, 0x20, 0x43, 0x6f, 0x6d,
-	  0x6d, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, },
-	{ 0x43, 0x05, 0x00, 0x4C, 0x6F, 0x6E, 0x67, 0x45, 0x06, 0x00,
-	  0x53, 0x68, 0x6F, 0x72, 0x74, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, }
+	/* Solavei */
+	{ 0x43, 0x08, 0x87, 0xD3, 0x37, 0x3B, 0x6C, 0x2F, 0xA7, 0x01 },
+	/* T-Mobile / T-Mobile */
+	{ 0x43, 0x08, 0x80, 0xD4, 0x56, 0xF3, 0x2D, 0x4E, 0xB3, 0xCB,
+	  0x45, 0x08, 0x80, 0xD4, 0x56, 0xF3, 0x2D, 0x4E, 0xB3, 0xCB,
+	  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF }
 };
 =

 static void test_eons(void)
@@ -376,7 +378,7 @@ static void test_eons(void)
 	op_info =3D sim_eons_lookup(eons_info, "246", "81");
 	g_assert(op_info);
 =

-	g_assert(!strcmp(op_info->longname, "Tux Comm"));
+	g_assert(!strcmp(op_info->longname, "Solavei"));
 	g_assert(!op_info->shortname);
 	g_assert(!op_info->info);
 =

-- =

1.8.3.2


--===============2199598493715686136==--

