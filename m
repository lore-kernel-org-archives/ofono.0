Content-Type: multipart/mixed; boundary="===============4218370458129640243=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 7/7] quectel: EC21 add ussd with atmodem driver
Date: Tue, 26 May 2020 12:16:25 +0200
Message-ID: <20200526101625.31871-8-poeschel@lemonage.de>
In-Reply-To: <20200526101625.31871-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4218370458129640243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

---
 plugins/quectel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 574de44e..a8fbc75a 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -1295,8 +1295,10 @@ static void quectel_post_sim(struct ofono_modem *mod=
em)
 	ofono_phonebook_create(modem, data->vendor, "atmodem", data->aux);
 	ofono_call_volume_create(modem, data->vendor, "atmodem", data->aux);
 =

-	if (data->model =3D=3D QUECTEL_EC21)
+	if (data->model =3D=3D QUECTEL_EC21) {
+		ofono_ussd_create(modem, data->vendor, "atmodem", data->aux);
 		ofono_lte_create(modem, data->vendor, "atmodem", data->aux);
+	}
 }
 =

 static void quectel_post_online(struct ofono_modem *modem)
-- =

2.26.2

--===============4218370458129640243==--

