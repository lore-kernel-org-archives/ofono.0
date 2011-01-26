Content-Type: multipart/mixed; boundary="===============1287534812530529860=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/2] include: don't use c++ keyword in public header
Date: Wed, 26 Jan 2011 14:17:00 -0200
Message-ID: <1296058621-10400-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1287534812530529860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 81df60e..5e3ba5b 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -154,7 +154,7 @@ struct ofono_sim_driver {
 			ofono_sim_lock_unlock_cb_t cb, void *data);
 	void (*change_passwd)(struct ofono_sim *sim,
 			enum ofono_sim_password_type type,
-			const char *old, const char *new,
+			const char *old_passwd, const char *new_passwd,
 			ofono_sim_lock_unlock_cb_t cb, void *data);
 	void (*lock)(struct ofono_sim *sim, enum ofono_sim_password_type type,
 			int enable, const char *passwd,
-- =

1.7.3.5


--===============1287534812530529860==--

