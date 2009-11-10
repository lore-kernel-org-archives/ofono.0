Content-Type: multipart/mixed; boundary="===============8657876124130677316=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Fix +CGEV: parsing
Date: Tue, 10 Nov 2009 07:31:07 +0100
Message-ID: <1257834667-22526-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8657876124130677316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 242086c..7aaa51a 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -192,14 +192,16 @@ static void cgev_notify(GAtResult *result, gpointer u=
ser_data)
 	GAtResultIter iter;
 	const char *event;
 =

+	g_at_result_iter_init(&iter, result);
+
 	if (!g_at_result_iter_next(&iter, "+CGEV:"))
 		return;
 =

 	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
 		return;
 =

-	if (g_str_has_prefix(event, "NW DETACH ") ||
-			g_str_has_prefix(event, "ME DETACH ")) {
+	if (g_str_equal(event, "NW DETACH") ||
+			g_str_equal(event, "ME DETACH")) {
 		ofono_gprs_detached_notify(gprs);
 		return;
 	}
-- =

1.6.1


--===============8657876124130677316==--

