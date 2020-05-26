Content-Type: multipart/mixed; boundary="===============4833889453761997908=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 2/7] quectel: use lte atom on EC21
Date: Tue, 26 May 2020 12:16:20 +0200
Message-ID: <20200526101625.31871-3-poeschel@lemonage.de>
In-Reply-To: <20200526101625.31871-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4833889453761997908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

---
 plugins/quectel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 1a49a5b3..0f6896b1 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -1263,6 +1263,9 @@ static void quectel_post_sim(struct ofono_modem *mode=
m)
 	ofono_sms_create(modem, data->vendor, "atmodem", data->aux);
 	ofono_phonebook_create(modem, data->vendor, "atmodem", data->aux);
 	ofono_call_volume_create(modem, data->vendor, "atmodem", data->aux);
+
+	if (data->model =3D=3D QUECTEL_EC21)
+		ofono_lte_create(modem, data->vendor, "atmodem", data->aux);
 }
 =

 static void quectel_post_online(struct ofono_modem *modem)
-- =

2.26.2

--===============4833889453761997908==--

