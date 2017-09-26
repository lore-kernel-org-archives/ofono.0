Content-Type: multipart/mixed; boundary="===============6946046651940389448=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 5/7] phonesim: Added sim-auth to phonesim plugin
Date: Tue, 26 Sep 2017 09:26:07 -0700
Message-ID: <1506443169-19755-5-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1506443169-19755-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6946046651940389448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 16bccd5..0469b32 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -61,6 +61,7 @@
 #include <ofono/gnss.h>
 #include <ofono/handsfree.h>
 #include <ofono/siri.h>
+#include <ofono/sim-auth.h>
 =

 #include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/atutil.h>
@@ -84,6 +85,7 @@ struct phonesim_data {
 	unsigned int hfp_watch;
 	int batt_level;
 	struct ofono_sim *sim;
+	struct ofono_sim_auth *sim_auth;
 };
 =

 struct gprs_context_data {
@@ -835,10 +837,14 @@ static void phonesim_pre_sim(struct ofono_modem *mode=
m)
 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
 	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
 =

+	printf("PHONESIM SIM=3D%p\n", data->sim);
+
 	if (data->calypso)
 		ofono_voicecall_create(modem, 0, "calypsomodem", data->chat);
 	else
 		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
+
+	data->sim_auth =3D ofono_sim_auth_create(modem, 0, "atmodem", data->chat);
 }
 =

 static void phonesim_post_sim(struct ofono_modem *modem)
-- =

2.7.4


--===============6946046651940389448==--

