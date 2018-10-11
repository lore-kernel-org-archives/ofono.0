Content-Type: multipart/mixed; boundary="===============8570119729807588792=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] sms:fix a missing entry in single shift table
Date: Thu, 11 Oct 2018 16:53:32 +0530
Message-ID: <1539257012-19328-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8570119729807588792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a missing char in the nation language set in single shift table
for a special character. Character set again validated.

Future language table to carry this fix.
---
 src/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/util.c b/src/util.c
index 2f01cec..70d72d7 100644
--- a/src/util.c
+++ b/src/util.c
@@ -376,6 +376,7 @@ static const struct codepoint ben_ext_gsm[] =3D {
 };
 =

 static const struct codepoint ben_ext_unicode[] =3D {
+	{ 0x000C, 0x1B0A },
 	{ 0x0022, 0x1B05 },
 	{ 0X0023, 0x1B17 },
 	{ 0x0024, 0x1B02 },
@@ -535,6 +536,7 @@ static const struct codepoint guj_ext_gsm[] =3D {
 };
 =

 static const struct codepoint guj_ext_unicode[] =3D {
+	{ 0x000C, 0x1B0A },
 	{ 0x0022, 0x1B05 },
 	{ 0x0023, 0x1B17 },
 	{ 0x0024, 0x1B02 },
-- =

2.7.4


--===============8570119729807588792==--

