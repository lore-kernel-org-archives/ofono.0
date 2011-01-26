Content-Type: multipart/mixed; boundary="===============7182311346262691892=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] atmodem: rename parameter according to header
Date: Wed, 26 Jan 2011 14:17:01 -0200
Message-ID: <1296058621-10400-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296058621-10400-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7182311346262691892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index a9352d8..372d985 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -881,7 +881,7 @@ error:
 =

 static void at_change_passwd(struct ofono_sim *sim,
 			enum ofono_sim_password_type passwd_type,
-			const char *old, const char *new,
+			const char *old_passwd, const char *new_passwd,
 			ofono_sim_lock_unlock_cb_t cb, void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
@@ -898,7 +898,7 @@ static void at_change_passwd(struct ofono_sim *sim,
 		goto error;
 =

 	snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
-			at_clck_cpwd_fac[passwd_type], old, new);
+			at_clck_cpwd_fac[passwd_type], old_passwd, new_passwd);
 =

 	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
 				at_lock_unlock_cb, cbd, g_free);
-- =

1.7.3.5


--===============7182311346262691892==--

