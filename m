Content-Type: multipart/mixed; boundary="===============1071275264158805801=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] plugins: quectel: Fix compiler warning
Date: Sun, 22 Sep 2019 22:53:21 +0200
Message-ID: <20190922205321.3438-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1071275264158805801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

plugins/quectel.c: In function =E2=80=98quectel_pre_sim=E2=80=99:
plugins/quectel.c:1150:20: error: unused variable =E2=80=98sim=E2=80=99 [-W=
error=3Dunused-variable]
  struct ofono_sim *sim;
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


--===============1071275264158805801==--

