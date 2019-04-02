Content-Type: multipart/mixed; boundary="===============7252777289379053558=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 3/3] sim: added error handling in set slot callback
Date: Tue, 02 Apr 2019 11:55:25 +0530
Message-ID: <1554186325-31643-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7252777289379053558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding the handling of error when the driver returns
CME ERROR:4.

This error will be returned for non xmm vendor modems
using ifxmodem driver for sim.
---
 src/sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sim.c b/src/sim.c
index 9f0183f..a178cb8 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -680,7 +680,7 @@ static void sim_set_slot_callback(const struct ofono_er=
ror *error, void *data)
 =

 		sim->pending_active_card_slot =3D sim->active_card_slot;
 =

-		reply =3D __ofono_error_failed(sim->pending);
+		reply =3D __ofono_error_from_error(error, sim->pending);
 		__ofono_dbus_pending_reply(&sim->pending, reply);
 =

 		return;
-- =

1.9.1


--===============7252777289379053558==--

