Content-Type: multipart/mixed; boundary="===============7273006954324733353=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 8/8][RFC] Enable SIM polling in atgen and phonesim drivers.
Date: Mon, 15 Mar 2010 22:22:27 +0100
Message-ID: <1268688147-4286-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7273006954324733353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/atgen.c    |    6 +++++-
 plugins/phonesim.c |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/plugins/atgen.c b/plugins/atgen.c
index 7e760bc..ea322fb 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -156,12 +156,16 @@ static int atgen_disable(struct ofono_modem *modem)
 static void atgen_pre_sim(struct ofono_modem *modem)
 {
 	GAtChat *chat =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", chat);
-	ofono_sim_create(modem, 0, "atmodem", chat);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", chat);
 	ofono_voicecall_create(modem, 0, "atmodem", chat);
+
+	if (sim)
+		ofono_sim_poll_enable(sim);
 }
 =

 static void atgen_post_sim(struct ofono_modem *modem)
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 523f5a9..f6ee212 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -277,16 +277,20 @@ static int phonesim_disable(struct ofono_modem *modem)
 static void phonesim_pre_sim(struct ofono_modem *modem)
 {
 	struct phonesim_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_sim *sim;
 =

 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	ofono_sim_create(modem, 0, "atmodem", data->chat);
+	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
 =

 	if (data->calypso)
 		ofono_voicecall_create(modem, 0, "calypsomodem", data->chat);
 	else
 		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+
+	if (sim && !data->calypso)
+		ofono_sim_poll_enable(sim);
 }
 =

 static void phonesim_post_sim(struct ofono_modem *modem)
-- =

1.6.1


--===============7273006954324733353==--

