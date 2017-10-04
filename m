Content-Type: multipart/mixed; boundary="===============6498771079334907357=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: [PATCH] ublox: Disable DCD to avoid HUP when leaving data mode.
Date: Wed, 04 Oct 2017 20:49:30 +0200
Message-ID: <1507142970.10910.2.camel@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6498771079334907357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The HUP results in errors in gatio which will deref parts
of the AT channel. This makes it impossible to recover and
send further AT commands after the HUP.
---
 plugins/ublox.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 250a5be4..5611ef5c 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -200,6 +200,8 @@ static int ublox_enable(struct ofono_modem *modem)
 =

 		g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", none_prefix,
 						NULL, NULL, NULL);
+
+		g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
 	}
 =

 	/* The modem can take a while to wake up if just powered on. */
-- =

2.11.0

--===============6498771079334907357==--

