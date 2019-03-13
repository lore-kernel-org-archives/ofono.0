Content-Type: multipart/mixed; boundary="===============0990041972447374841=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v4 6/6] ublox: pass model id to LTE plugin
Date: Wed, 13 Mar 2019 22:36:01 +0100
Message-ID: <20190313213601.24971-6-jonas@norrbonn.se>
In-Reply-To: <20190313213601.24971-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0990041972447374841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ublox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 10660ff0..1c74fe09 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -408,7 +408,8 @@ static void ublox_post_sim(struct ofono_modem *modem)
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


--===============0990041972447374841==--

