Content-Type: multipart/mixed; boundary="===============8404229199026828812=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] Don't use c++ keyword in public header files
Date: Tue, 25 Jan 2011 09:47:12 -0200
Message-ID: <1295956032-27028-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8404229199026828812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 81df60e..6e93769 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -154,7 +154,7 @@ struct ofono_sim_driver {
 			ofono_sim_lock_unlock_cb_t cb, void *data);
 	void (*change_passwd)(struct ofono_sim *sim,
 			enum ofono_sim_password_type type,
-			const char *old, const char *new,
+			const char *p_old, const char *p_new,
 			ofono_sim_lock_unlock_cb_t cb, void *data);
 	void (*lock)(struct ofono_sim *sim, enum ofono_sim_password_type type,
 			int enable, const char *passwd,
-- =

1.7.3.5


--===============8404229199026828812==--

