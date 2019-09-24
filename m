Content-Type: multipart/mixed; boundary="===============8756523685893349692=="
MIME-Version: 1.0
From: Nicola Lunghi <nick83ola@gmail.com>
Subject: [PATCH] quectel: remove unused variable in quectel_pre_sim
Date: Tue, 24 Sep 2019 08:15:15 +0100
Message-ID: <20190924071514.6072-1-nicola.lunghi@jci.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8756523685893349692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Nicola Lunghi <nick83ola@gmail.com>

This variable was left over by a previous commit and in gcc 9.1
was throwing an error an error (unused variable)
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


--===============8756523685893349692==--

