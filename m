Content-Type: multipart/mixed; boundary="===============7286986561904051721=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 1/3] quectel: remove unused variable
Date: Tue, 24 Sep 2019 13:33:30 +0200
Message-ID: <20190924113332.31729-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7286986561904051721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/quectel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index d4947489..1d21d6dd 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -1147,7 +1147,6 @@ static void quectel_set_online(struct ofono_modem *mo=
dem, ofono_bool_t online,
 static void quectel_pre_sim(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

-- =

2.20.1


--===============7286986561904051721==--

