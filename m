Content-Type: multipart/mixed; boundary="===============9203768959870999767=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/3] sim: added error handling in set slot callback
Date: Mon, 01 Apr 2019 17:17:50 +0530
Message-ID: <1554119270-19388-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9203768959870999767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding the handling of error when the driver returns
CME ERROR:4.

This error will be returned for non xmm vendor modems
using ifxmodem driver for sim.
---
 src/sim.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 9f0183f..1943989 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -680,8 +680,13 @@ static void sim_set_slot_callback(const struct ofono_e=
rror *error, void *data)
 =

 		sim->pending_active_card_slot =3D sim->active_card_slot;
 =

-		reply =3D __ofono_error_failed(sim->pending);
-		__ofono_dbus_pending_reply(&sim->pending, reply);
+		if (error->type =3D=3D OFONO_ERROR_TYPE_CME && error->error =3D=3D 4) {
+			reply =3D __ofono_error_not_implemented(sim->pending);
+			__ofono_dbus_pending_reply(&sim->pending, reply);
+		} else {
+			reply =3D __ofono_error_failed(sim->pending);
+			__ofono_dbus_pending_reply(&sim->pending, reply);
+		}
 =

 		return;
 	}
-- =

1.9.1


--===============9203768959870999767==--

