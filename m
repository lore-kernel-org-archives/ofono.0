Content-Type: multipart/mixed; boundary="===============1142181977102383204=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] sim: check pins even if language checks fails
Date: Wed, 25 Aug 2010 16:44:01 +0300
Message-ID: <1282743841-25151-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1142181977102383204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/sim.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index a450b30..be2793b 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1373,7 +1373,7 @@ skip_efpl:
 	}
 =

 	if (sim->language_prefs =3D=3D NULL)
-		return;
+		goto done;
 =

 	ofono_dbus_signal_array_property_changed(conn, path,
 						OFONO_SIM_MANAGER_INTERFACE,
@@ -1381,6 +1381,7 @@ skip_efpl:
 						DBUS_TYPE_STRING,
 						&sim->language_prefs);
 =

+done:
 	sim_pin_check(sim);
 }
 =

-- =

1.7.0.4


--===============1142181977102383204==--

