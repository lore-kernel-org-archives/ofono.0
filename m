Content-Type: multipart/mixed; boundary="===============4012566930858152187=="
MIME-Version: 1.0
From: Santtu Lakkala <santtu.lakkala@link-motion.com>
Subject: [PATCH] huaweimodem: Fix DHCP parsing on 32-bit platforms
Date: Wed, 10 Aug 2016 13:04:07 +0300
Message-ID: <1470823447-24819-1-git-send-email-santtu.lakkala@link-motion.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4012566930858152187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

strtol clamps returned value between INT_MIN and INT_MAX, causing
invalid value (255.255.255.127) being reported for any address
if last octet > 127 when sizeof(long) =3D=3D 4.
---
 drivers/huaweimodem/gprs-context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/huaweimodem/gprs-context.c b/drivers/huaweimodem/gprs-=
context.c
index 3acd90c..dda5e32 100644
--- a/drivers/huaweimodem/gprs-context.c
+++ b/drivers/huaweimodem/gprs-context.c
@@ -80,7 +80,7 @@ static gboolean get_next_addr(GAtResultIter *iter, char *=
*addr)
 	if (g_at_result_iter_next_unquoted_string(iter, &str) =3D=3D FALSE)
 		return FALSE;
 =

-	val =3D strtol(str, NULL, 16);
+	val =3D strtoul(str, NULL, 16);
 =

 	if (addr)
 		*addr =3D g_strdup_printf("%u.%u.%u.%u",
-- =

2.5.0


--===============4012566930858152187==--

