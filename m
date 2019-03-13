Content-Type: multipart/mixed; boundary="===============8370067463828209112=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v2 04/10] udevng: ublox: Model string no longer used
Date: Wed, 13 Mar 2019 21:23:18 +0100
Message-ID: <20190313202324.16369-4-jonas@norrbonn.se>
In-Reply-To: <20190313202324.16369-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8370067463828209112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index ce8cdee1..4473c0a6 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1111,7 +1111,6 @@ static gboolean setup_ublox(struct modem_info *modem)
 =

 	ofono_modem_set_string(modem->modem, "Aux", aux);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
-	ofono_modem_set_string(modem->modem, "Model", modem->model);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
 =

 	return TRUE;
-- =

2.19.1


--===============8370067463828209112==--

