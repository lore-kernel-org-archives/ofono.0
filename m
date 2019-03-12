Content-Type: multipart/mixed; boundary="===============1960312540897775008=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 08/14] udevng: ublox: Model string no longer used
Date: Tue, 12 Mar 2019 12:10:02 +0100
Message-ID: <20190312111008.29258-9-jonas@norrbonn.se>
In-Reply-To: <20190312111008.29258-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1960312540897775008==
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


--===============1960312540897775008==--

