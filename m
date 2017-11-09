Content-Type: multipart/mixed; boundary="===============5805765516798568040=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 1/3] simauth: remove driver API definitions from simauth
 include
Date: Thu, 09 Nov 2017 09:52:15 -0800
Message-ID: <1510249937-22427-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5805765516798568040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/sim-auth.h | 38 +-------------------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/include/sim-auth.h b/include/sim-auth.h
index ccaa7f2..9f25cfa 100644
--- a/include/sim-auth.h
+++ b/include/sim-auth.h
@@ -32,44 +32,8 @@ extern "C" {
 =

 struct ofono_sim_auth;
 =

-typedef void (*ofono_sim_list_apps_cb_t)(const struct ofono_error *error,
-					const unsigned char *dataobj,
-					int len, void *data);
+struct ofono_sim_auth *ofono_sim_auth_create(struct ofono_modem *modem);
 =

-typedef void (*ofono_sim_open_channel_cb_t)(const struct ofono_error *erro=
r,
-		int session_id, void *data);
-
-typedef void (*ofono_sim_close_channel_cb_t)(const struct ofono_error *err=
or,
-		void *data);
-
-typedef void (*ofono_logical_access_cb_t)(const struct ofono_error *error,
-		const uint8_t *resp, uint16_t len, void *data);
-
-struct ofono_sim_auth_driver {
-	const char *name;
-	int (*probe)(struct ofono_sim_auth *sa, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_sim_auth *sa);
-
-	void (*list_apps)(struct ofono_sim_auth *sa,
-			ofono_sim_list_apps_cb_t cb, void *data);
-	void (*open_channel)(struct ofono_sim_auth *sa, const uint8_t *aid,
-			ofono_sim_open_channel_cb_t cb, void *data);
-	void (*close_channel)(struct ofono_sim_auth *sa, int session_id,
-			ofono_sim_close_channel_cb_t cb, void *data);
-	void (*logical_access)(struct ofono_sim_auth *sa,
-			int session_id, const uint8_t *pdu, uint16_t len,
-			ofono_logical_access_cb_t cb, void *data);
-};
-
-int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *d);
-void ofono_sim_auth_driver_unregister(const struct ofono_sim_auth_driver *=
d);
-
-struct ofono_sim_auth *ofono_sim_auth_create(struct ofono_modem *modem,
-						unsigned int vendor,
-						const char *driver, void *data);
-
-void ofono_sim_auth_register(struct ofono_sim_auth *sa);
 void ofono_sim_auth_remove(struct ofono_sim_auth *sa);
 =

 void ofono_sim_auth_set_data(struct ofono_sim_auth *sa, void *data);
-- =

2.7.4


--===============5805765516798568040==--

