Content-Type: multipart/mixed; boundary="===============8990779657869732660=="
MIME-Version: 1.0
From: Vincent Cesson <cesson.vincent@gmail.com>
Subject: [RFC 1/1] atmodem: Fix CGDCONT result parsing.
Date: Thu, 12 Jan 2017 18:09:30 +0100
Message-ID: <1484240970-3406-2-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <1484240970-3406-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8990779657869732660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: vcesson <vincent.cesson@smile.fr>

CGDCONT result parsing fails if first list contains several ranges.
Solution: read first range and jump to second list.
---
 drivers/atmodem/gprs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 5ee757a..5724f86 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -522,7 +522,7 @@ static void at_cgdcont_test_cb(gboolean ok, GAtResult *=
result,
 		if (g_at_result_iter_next_range(&iter, &min, &max) =3D=3D FALSE)
 			continue;
 =

-		if (!g_at_result_iter_close_list(&iter))
+		if (!g_at_result_iter_skip_next(&iter))
 			continue;
 =

 		if (g_at_result_iter_open_list(&iter))
-- =

1.9.1


--===============8990779657869732660==--

