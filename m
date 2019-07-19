Content-Type: multipart/mixed; boundary="===============4437802060192415002=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 2/2] ublox: use custom netreg atom
Date: Fri, 19 Jul 2019 08:51:02 +0200
Message-ID: <20190719065102.32314-2-jonas@norrbonn.se>
In-Reply-To: <20190719065102.32314-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4437802060192415002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ublox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 231578fb..b65bc52a 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -406,7 +406,8 @@ static void ublox_post_online(struct ofono_modem *modem)
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


--===============4437802060192415002==--

