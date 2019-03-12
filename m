Content-Type: multipart/mixed; boundary="===============4013037572875209575=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 14/14] ublox: pass model id to LTE plugin
Date: Tue, 12 Mar 2019 12:10:08 +0100
Message-ID: <20190312111008.29258-15-jonas@norrbonn.se>
In-Reply-To: <20190312111008.29258-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4013037572875209575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ublox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 7a93adb2..bec0bf83 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -407,7 +407,8 @@ static void ublox_post_sim(struct ofono_modem *modem)
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


--===============4013037572875209575==--

