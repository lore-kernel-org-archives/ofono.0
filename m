Content-Type: multipart/mixed; boundary="===============2571771334952343173=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] mbm: Register sim toolkit atom in mbm plugin.
Date: Wed, 12 May 2010 03:22:03 +0200
Message-ID: <1273627323-7378-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2571771334952343173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index c67c7a5..3a87f79 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -37,6 +37,7 @@
 #include <ofono/devinfo.h>
 #include <ofono/netreg.h>
 #include <ofono/sim.h>
+#include <ofono/stk.h>
 #include <ofono/sms.h>
 #include <ofono/cbs.h>
 #include <ofono/ssn.h>
@@ -290,6 +291,7 @@ static void mbm_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "atmodem", data->modem_port);
 	sim =3D ofono_sim_create(modem, 0, "atmodem", data->modem_port);
 	ofono_voicecall_create(modem, 0, "atmodem", data->modem_port);
+	ofono_stk_create(modem, 0, "mbmmodem", data->modem_port);
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

1.6.1


--===============2571771334952343173==--

