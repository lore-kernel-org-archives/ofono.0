Content-Type: multipart/mixed; boundary="===============0228632115206490865=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 1/2] quectel: Extend power-on timeout
Date: Thu, 24 Sep 2020 12:38:05 +0200
Message-ID: <20200924103806.2518502-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0228632115206490865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

More complicated modems emerge and they need longer start-up times. An
EC21 takes about 13 seconds to boot up. This is slightly longer than the
20 * 500 ms we have at the moment. This extends the retries to 30, so we
have 30 * 500 ms and this does successfully power up an EC21 modem.
---
 plugins/quectel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index c3343008..6456775d 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -1086,8 +1086,8 @@ static void init_timeout_cb(struct l_timeout *timeout=
, void *user_data)
 =

 	DBG("%p", modem);
 =

-	if (data->init_count++ >=3D 20) {
-		ofono_error("failed to init modem after 20 attempts");
+	if (data->init_count++ >=3D 30) {
+		ofono_error("failed to init modem after 30 attempts");
 		close_serial(modem);
 		return;
 	}
-- =

2.28.0

--===============0228632115206490865==--

