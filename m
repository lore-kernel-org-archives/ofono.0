Content-Type: multipart/mixed; boundary="===============6296039388060713101=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv2] quectel: swap cmuxed ports
Date: Mon, 02 Sep 2019 23:17:59 +0200
Message-ID: <20190902211759.61961-1-martin@geanix.com>
In-Reply-To: <20190812205010.21575-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6296039388060713101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to the manual, when using CMUX on the UC15, it outputs
unsolicited indications on port 2 (i.e. /dev/gsmtty2), so the quectel
plugin must use this when registering for such.
---
 plugins/quectel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index ccfc6c5f..dea23bdd 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -849,8 +849,8 @@ static void cmux_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 	 * the kernel does not yet support mapping the underlying serial device
 	 * to its virtual gsm ttys, so hard-code gsmtty1 gsmtty2 for now
 	 */
-	ofono_modem_set_string(modem, "Aux", "/dev/gsmtty1");
-	ofono_modem_set_string(modem, "Modem", "/dev/gsmtty2");
+	ofono_modem_set_string(modem, "Modem", "/dev/gsmtty1");
+	ofono_modem_set_string(modem, "Aux", "/dev/gsmtty2");
 =

 	/* wait for gsmtty devices to appear */
 	if (!l_timeout_create_ms(100, mux_ready_cb, modem, NULL)) {
-- =

2.22.1


--===============6296039388060713101==--

