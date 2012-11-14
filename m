Content-Type: multipart/mixed; boundary="===============6173288990311434635=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: [PATCH] alcatel: create sim atom with vendor alcatel
Date: Wed, 14 Nov 2012 12:08:40 +0100
Message-ID: <1352891320-29766-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6173288990311434635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Cedric Jehasse <cedric.jehasse@softathome.com>

---
 plugins/alcatel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/alcatel.c b/plugins/alcatel.c
index 8005170..e3e7086 100644
--- a/plugins/alcatel.c
+++ b/plugins/alcatel.c
@@ -230,7 +230,7 @@ static void alcatel_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->aux);
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_ALCATEL, "atmodem", data->au=
x);
 =

 	if (sim && data->have_sim =3D=3D TRUE)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

1.7.1


--===============6173288990311434635==--

