Content-Type: multipart/mixed; boundary="===============8755547538691954285=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 1/4] include: add method to query pin Retries
Date: Tue, 04 Jan 2011 20:22:56 -0200
Message-ID: <1294179779-4013-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294179779-4013-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8755547538691954285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 7860e24..830322a 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -108,6 +108,9 @@ typedef void (*ofono_sim_passwd_cb_t)(const struct ofon=
o_error *error,
 					enum ofono_sim_password_type type,
 					void *data);
 =

+typedef void (*ofono_sim_pin_retries_cb_t)(const struct ofono_error *error,
+			int retries[OFONO_SIM_PASSWORD_INVALID], void *data);
+
 typedef void (*ofono_sim_lock_unlock_cb_t)(const struct ofono_error *error,
 					void *data);
 =

@@ -144,6 +147,8 @@ struct ofono_sim_driver {
 			ofono_sim_passwd_cb_t cb, void *data);
 	void (*send_passwd)(struct ofono_sim *sim, const char *passwd,
 			ofono_sim_lock_unlock_cb_t cb, void *data);
+	void (*query_pin_retries)(struct ofono_sim *sim,
+				ofono_sim_pin_retries_cb_t cb, void *data);
 	void (*reset_passwd)(struct ofono_sim *sim, const char *puk,
 			const char *passwd,
 			ofono_sim_lock_unlock_cb_t cb, void *data);
-- =

1.7.3.4


--===============8755547538691954285==--

