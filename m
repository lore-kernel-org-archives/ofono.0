Content-Type: multipart/mixed; boundary="===============5612495356502983410=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 7/9] quectel: configure flow control when enabled
Date: Wed, 10 Jul 2019 23:51:46 +0200
Message-ID: <20190710215148.78083-8-martin@geanix.com>
In-Reply-To: <20190710215148.78083-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5612495356502983410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/quectel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 3f9c93f8..bfae31c0 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -495,7 +495,13 @@ static int open_serial(struct ofono_modem *modem)
 	 * at which point the modem is ready.
 	 */
 	g_at_chat_set_wakeup_command(data->uart, "AT\r", 500, 10000);
-	g_at_chat_send(data->uart, "ATE0", none_prefix, ate_cb, modem, NULL);
+
+	if (strcmp(rts_cts, "on") =3D=3D 0)
+		g_at_chat_send(data->uart, "AT+IFC=3D2,2; E0", none_prefix,
+				ate_cb, modem, NULL);
+	else
+		g_at_chat_send(data->uart, "ATE0", none_prefix, ate_cb, modem,
+				NULL);
 =

 	return -EINPROGRESS;
 }
-- =

2.22.0


--===============5612495356502983410==--

