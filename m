Content-Type: multipart/mixed; boundary="===============0850810055370304266=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] ublox: Correct the USBCONF reply prefix
Date: Sun, 31 Mar 2019 22:18:46 +0200
Message-ID: <20190331201846.6645-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0850810055370304266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

According to the u-blox AT Commands Manual and my tests
the response prefix of AT+UUSBCONF is "+UUSBCONF:", including
a colon. The colon was missing in the code, causing next step
to parse a number to fail, since a colon is not a number.
---
 plugins/ublox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index dc001765..142a5af7 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -164,7 +164,7 @@ static void query_usbconf_cb(gboolean ok,
 	g_at_result_iter_init(&iter, result);
 =

 retry:
-	if (!g_at_result_iter_next(&iter, "+UUSBCONF")) {
+	if (!g_at_result_iter_next(&iter, "+UUSBCONF:")) {
 		ofono_error("Unable to query USB configuration");
 		goto error;
 	}
-- =

2.19.1


--===============0850810055370304266==--

