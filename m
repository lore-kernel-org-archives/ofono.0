Content-Type: multipart/mixed; boundary="===============8265577598423185254=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 7/9] huaweimodme: prevent use of uninitialized variable
Date: Fri, 26 Oct 2018 12:13:17 +0200
Message-ID: <20181026101319.27709-8-jonas@norrbonn.se>
In-Reply-To: <20181026101319.27709-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8265577598423185254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jonas Bonn <jonas@southpole.se>

Move initialization of 'dcs' ahead of 'content' fetch to prevent
uninitialized use.
---
 drivers/huaweimodem/ussd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/huaweimodem/ussd.c b/drivers/huaweimodem/ussd.c
index fbed3cd0..f4001108 100644
--- a/drivers/huaweimodem/ussd.c
+++ b/drivers/huaweimodem/ussd.c
@@ -62,12 +62,12 @@ static void cusd_parse(GAtResult *result, struct ofono_=
ussd *ussd)
 	if (!g_at_result_iter_next_number(&iter, &status))
 		return;
 =

-	if (!g_at_result_iter_next_string(&iter, &content))
-		goto out;
-
 	if (!g_at_result_iter_next_number(&iter, &dcs))
 		dcs =3D 0;
 =

+	if (!g_at_result_iter_next_string(&iter, &content))
+		goto out;
+
 	msg_ptr =3D decode_hex_own_buf(content, -1, &msg_len, 0, msg);
 =

 out:
-- =

2.17.1


--===============8265577598423185254==--

