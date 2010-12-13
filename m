Content-Type: multipart/mixed; boundary="===============0489194741691128355=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH] test-stkutil: Modify the check logic of time zone
Date: Mon, 13 Dec 2010 11:03:23 +0800
Message-ID: <1292209403-31387-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0489194741691128355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 868d54b..666f4eb 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -245,7 +245,11 @@ static void check_gsm_sms(const struct sms *command,
 			g_assert(ca->hour =3D=3D ta->hour);
 			g_assert(ca->minute =3D=3D ta->minute);
 			g_assert(ca->second =3D=3D ta->second);
-			g_assert(ca->timezone =3D=3D ta->timezone);
+			g_assert(ca->has_timezone =3D=3D ta->has_timezone);
+
+			if (ta->has_timezone)
+				g_assert(ca->timezone =3D=3D ta->timezone);
+			=

 			break;
 		}
 		case SMS_VALIDITY_PERIOD_FORMAT_ENHANCED:
-- =

1.7.2.3


--===============0489194741691128355==--

