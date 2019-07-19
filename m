Content-Type: multipart/mixed; boundary="===============6912122101880792726=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 1/2] atmodem: gprs-context: parse list-less CGDATA response
Date: Fri, 19 Jul 2019 12:27:45 +0200
Message-ID: <20190719102746.122911-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6912122101880792726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Quectel M95 and MC60 modems respond to AT+CGDATA=3D? with a single
+CGDATA=3D"PPP", but the callback in gprs-context expects a list of
protocols.

Avoid falling back to the old-style ATD*99 by not expecting a list of
protocols for serial quectel modems.
---
 drivers/atmodem/gprs-context.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 4e623a63..f9f3c0ab 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -409,9 +409,11 @@ static void at_cgdata_test_cb(gboolean ok, GAtResult *=
result,
 		goto error;
 	}
 =

-	if (!g_at_result_iter_open_list(&iter)) {
-		DBG("no list found");
-		goto error;
+	if (gcd->vendor !=3D OFONO_VENDOR_QUECTEL_SERIAL) {
+		if (!g_at_result_iter_open_list(&iter)) {
+			DBG("no list found");
+			goto error;
+		}
 	}
 =

 	while (!found && g_at_result_iter_next_string(&iter, &data_type)) {
-- =

2.22.0


--===============6912122101880792726==--

