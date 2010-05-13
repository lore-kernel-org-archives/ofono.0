Content-Type: multipart/mixed; boundary="===============3498640138191909106=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 08/16] emulator: Add ofono_emulator in phonesim
Date: Thu, 13 May 2010 18:02:31 +0800
Message-ID: <1273744959-3711-9-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-8-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3498640138191909106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index d0cd7f3..49d3af3 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -57,6 +57,7 @@
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/emulator.h>
 =

 #include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/sim-poll.h>
@@ -278,6 +279,7 @@ static void phonesim_pre_sim(struct ofono_modem *modem)
 {
 	struct phonesim_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_sim *sim;
+	struct ofono_emulator *emulator;
 =

 	DBG("%p", modem);
 =

@@ -293,6 +295,10 @@ static void phonesim_pre_sim(struct ofono_modem *modem)
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
+
+	emulator =3D ofono_emulator_create(modem);
+	if (emulator)
+		ofono_emulator_register(emulator);
 }
 =

 static void phonesim_post_sim(struct ofono_modem *modem)
-- =

1.6.3.3


--===============3498640138191909106==--

