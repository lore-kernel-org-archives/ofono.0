Content-Type: multipart/mixed; boundary="===============0492115420533280567=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH 1/1] atmodem: Fix CGDCONT result parsing.
Date: Fri, 13 Jan 2017 14:27:53 +0100
Message-ID: <1484314073-4009-1-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <968f5e44-fce5-bfb0-1560-e9626f62f5a5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0492115420533280567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

CGDCONT result parsing fails if first list contains several ranges. For
example with modem Cinterion PHS8:

 AT+CGDCONT=3D?
 +CGDCONT: (1-17,101-116),"IP",,,(0),(0-4)

Solution: read first range and jump to second list instead of trying to
close the brackets.
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


--===============0492115420533280567==--

