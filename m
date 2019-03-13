Content-Type: multipart/mixed; boundary="===============4358431834526823405=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v2 10/10] ublox: pass model id to LTE plugin
Date: Wed, 13 Mar 2019 21:23:24 +0100
Message-ID: <20190313202324.16369-10-jonas@norrbonn.se>
In-Reply-To: <20190313202324.16369-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4358431834526823405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ublox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index ad1b6ec7..7cb12f7f 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -409,7 +409,8 @@ static void ublox_post_sim(struct ofono_modem *modem)
 		--ncontexts;
 	}
 =

-	ofono_lte_create(modem, 0, "ubloxmodem", data->aux);
+	ofono_lte_create(modem,
+		ublox_model_to_id(data->model), "ubloxmodem", data->aux);
 }
 =

 static void ublox_post_online(struct ofono_modem *modem)
-- =

2.19.1


--===============4358431834526823405==--

