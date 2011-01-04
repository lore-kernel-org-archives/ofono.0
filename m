Content-Type: multipart/mixed; boundary="===============5097218399020361838=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 1/4] include: add method to query pin Retries
Date: Tue, 04 Jan 2011 11:06:16 -0200
Message-ID: <1294146379-30854-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294146379-30854-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5097218399020361838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/sim.h b/include/sim.h
index 7860e24..bf4aaf9 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -77,6 +77,11 @@ enum ofono_sim_state {
 	OFONO_SIM_STATE_READY,
 };
 =

+struct ofono_sim_pin_retry {
+	enum ofono_sim_password_type id;
+	int val;
+};
+
 typedef void (*ofono_sim_file_info_cb_t)(const struct ofono_error *error,
 					int filelength,
 					enum ofono_sim_file_structure structure,
@@ -108,6 +113,10 @@ typedef void (*ofono_sim_passwd_cb_t)(const struct ofo=
no_error *error,
 					enum ofono_sim_password_type type,
 					void *data);
 =

+typedef void (*ofono_sim_pin_retries_cb_t)(const struct ofono_error *error,
+						GSList *pin_retries,
+						void *data);
+
 typedef void (*ofono_sim_lock_unlock_cb_t)(const struct ofono_error *error,
 					void *data);
 =

@@ -144,6 +153,8 @@ struct ofono_sim_driver {
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


--===============5097218399020361838==--

