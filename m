Content-Type: multipart/mixed; boundary="===============7975971874572898522=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: [PATCH 5/6] sim: give access to the driver
Date: Mon, 12 Mar 2018 13:57:12 +0100
Message-ID: <1520859433-14112-6-git-send-email-gabriel.lucas@smile.fr>
In-Reply-To: <1520859433-14112-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7975971874572898522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h | 2 ++
 src/sim.c     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index fad4c0d..cf679db 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -217,6 +217,8 @@ struct ofono_sim *ofono_sim_create(struct ofono_modem *=
modem,
 void ofono_sim_register(struct ofono_sim *sim);
 void ofono_sim_remove(struct ofono_sim *sim);
 =

+const struct ofono_sim_driver* ofono_sim_get_driver(struct ofono_sim *sim);
+
 void ofono_sim_set_data(struct ofono_sim *sim, void *data);
 void *ofono_sim_get_data(struct ofono_sim *sim);
 =

diff --git a/src/sim.c b/src/sim.c
index eb9f56a..f56706f 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -3305,6 +3305,11 @@ void ofono_sim_remove(struct ofono_sim *sim)
 	__ofono_atom_free(sim->atom);
 }
 =

+const struct ofono_sim_driver* ofono_sim_get_driver(struct ofono_sim *sim)
+{
+	return sim->driver;
+}
+
 void ofono_sim_set_data(struct ofono_sim *sim, void *data)
 {
 	sim->driver_data =3D data;
-- =

1.9.1


--===============7975971874572898522==--

