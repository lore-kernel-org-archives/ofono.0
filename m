Content-Type: multipart/mixed; boundary="===============1476445188373059328=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 05/10] ublox: use custom netreg atom
Date: Thu, 18 Jul 2019 12:23:09 +0200
Message-ID: <20190718102314.28094-5-jonas@norrbonn.se>
In-Reply-To: <20190718102314.28094-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1476445188373059328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ublox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index ff08a6a1..918bd3ec 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -399,7 +399,8 @@ static void ublox_post_online(struct ofono_modem *modem)
 {
 	struct ublox_data *data =3D ofono_modem_get_data(modem);
 =

-	ofono_netreg_create(modem, data->vendor_family, "atmodem", data->aux);
+	ofono_netreg_create(modem,
+		ublox_model_to_id(data->model), "ubloxmodem", data->aux);
 =

 	ofono_netmon_create(modem, data->vendor_family, "ubloxmodem", data->aux);
 }
-- =

2.20.1


--===============1476445188373059328==--

