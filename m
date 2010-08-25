Content-Type: multipart/mixed; boundary="===============1339441490772641369=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH] sim: Ensure to call sim_pin_check
Date: Wed, 25 Aug 2010 18:28:56 +0800
Message-ID: <1282732136-7468-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1339441490772641369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In current code, sim_pin_check() is called inside sim_efpl_read_cb().
However, there may be a chance it would never be called, thus the modem
won't be initialized correctly.
---
 src/sim.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index a450b30..9bc9906 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1380,8 +1380,6 @@ skip_efpl:
 						"PreferredLanguages",
 						DBUS_TYPE_STRING,
 						&sim->language_prefs);
-
-	sim_pin_check(sim);
 }
 =

 static void sim_iccid_read_cb(int ok, int length, int record,
@@ -1454,6 +1452,8 @@ static void sim_initialize(struct ofono_sim *sim)
 	ofono_sim_read(sim, SIM_EFPL_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_efpl_read_cb, sim);
+
+	sim_pin_check(sim);
 }
 =

 static void sim_op_error(struct ofono_sim *sim)
-- =

1.7.0.4


--===============1339441490772641369==--

