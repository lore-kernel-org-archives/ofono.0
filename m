Content-Type: multipart/mixed; boundary="===============0887445045136127692=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH] Enable some atoms for hso modem
Date: Sun, 19 Sep 2010 15:36:12 +0800
Message-ID: <1284881772-17271-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0887445045136127692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hso.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/plugins/hso.c b/plugins/hso.c
index 25ca157..bfc5c47 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -36,6 +36,7 @@
 #include <ofono/modem.h>
 #include <ofono/devinfo.h>
 #include <ofono/netreg.h>
+#include <ofono/phonebook.h>
 #include <ofono/sim.h>
 #include <ofono/cbs.h>
 #include <ofono/sms.h>
@@ -262,6 +263,15 @@ static void hso_pre_sim(struct ofono_modem *modem)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

+static void hso_post_sim(struct ofono_modem *modem)
+{
+	struct hso_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_phonebook_create(modem, 0, "atmodem", data->app);
+}
+
 static void hso_post_online(struct ofono_modem *modem)
 {
 	struct hso_data *data =3D ofono_modem_get_data(modem);
@@ -296,6 +306,7 @@ static struct ofono_modem_driver hso_driver =3D {
 	.disable	=3D hso_disable,
 	.set_online     =3D hso_set_online,
 	.pre_sim	=3D hso_pre_sim,
+	.post_sim	=3D hso_post_sim,
 	.post_online	=3D hso_post_online,
 };
 =

-- =

1.7.0.4


--===============0887445045136127692==--

