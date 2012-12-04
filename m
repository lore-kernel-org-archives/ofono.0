Content-Type: multipart/mixed; boundary="===============5510206720033032551=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/1] atmodem: remove pending idle callbacks at device removal
Date: Tue, 04 Dec 2012 16:33:47 +0100
Message-ID: <1354635227-9344-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5510206720033032551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mingli Wu <mingli@southpole.se>

If device probe and removal happen in short succession, it's possible
that the idle handler registered in the probe function doesn't run before
the device is removed.  In this case, the idle handler needs to be
unregistered so that it does not run and try to access the data that's
destroyed during the removal.
---
 drivers/atmodem/call-barring.c    |    1 +
 drivers/atmodem/call-forwarding.c |    1 +
 drivers/atmodem/call-settings.c   |    1 +
 drivers/atmodem/sim-auth.c        |    1 +
 drivers/atmodem/sim.c             |    1 +
 drivers/atmodem/stk.c             |    1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/atmodem/call-barring.c b/drivers/atmodem/call-barring.c
index a2417c7..1239d05 100644
--- a/drivers/atmodem/call-barring.c
+++ b/drivers/atmodem/call-barring.c
@@ -207,6 +207,7 @@ static void at_call_barring_remove(struct ofono_call_ba=
rring *cb)
 {
 	GAtChat *chat =3D ofono_call_barring_get_data(cb);
 =

+	g_idle_remove_by_data(cb);
 	g_at_chat_unref(chat);
 	ofono_call_barring_set_data(cb, NULL);
 }
diff --git a/drivers/atmodem/call-forwarding.c b/drivers/atmodem/call-forwa=
rding.c
index cbe4b24..e2020d3 100644
--- a/drivers/atmodem/call-forwarding.c
+++ b/drivers/atmodem/call-forwarding.c
@@ -259,6 +259,7 @@ static void at_ccfc_remove(struct ofono_call_forwarding=
 *cf)
 {
 	GAtChat *chat =3D ofono_call_forwarding_get_data(cf);
 =

+	g_idle_remove_by_data(cf);
 	g_at_chat_unref(chat);
 	ofono_call_forwarding_set_data(cf, NULL);
 }
diff --git a/drivers/atmodem/call-settings.c b/drivers/atmodem/call-setting=
s.c
index 2dc16e4..f017ab5 100644
--- a/drivers/atmodem/call-settings.c
+++ b/drivers/atmodem/call-settings.c
@@ -393,6 +393,7 @@ static void at_call_settings_remove(struct ofono_call_s=
ettings *cs)
 {
 	GAtChat *chat =3D ofono_call_settings_get_data(cs);
 =

+	g_idle_remove_by_data(cs);
 	g_at_chat_unref(chat);
 	ofono_call_settings_set_data(cs, NULL);
 }
diff --git a/drivers/atmodem/sim-auth.c b/drivers/atmodem/sim-auth.c
index 9ce810f..271ceed 100644
--- a/drivers/atmodem/sim-auth.c
+++ b/drivers/atmodem/sim-auth.c
@@ -139,6 +139,7 @@ static void at_sim_auth_remove(struct ofono_sim_auth *s=
a)
 {
 	struct sim_auth_data *sad =3D ofono_sim_auth_get_data(sa);
 =

+	g_idle_remove_by_data(sa);
 	ofono_sim_auth_set_data(sa, NULL);
 =

 	g_at_chat_unref(sad->chat);
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index effc595..4095337 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1493,6 +1493,7 @@ static void at_sim_remove(struct ofono_sim *sim)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

+	g_idle_remove_by_data(sim);
 	/* Cleanup potential SIM state polling */
 	at_util_sim_state_query_free(sd->sim_state_query);
 =

diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index f0bd3a0..b4fb2f2 100644
--- a/drivers/atmodem/stk.c
+++ b/drivers/atmodem/stk.c
@@ -216,6 +216,7 @@ static void at_stk_remove(struct ofono_stk *stk)
 {
 	struct stk_data *sd =3D ofono_stk_get_data(stk);
 =

+	g_idle_remove_by_data(stk);
 	ofono_stk_set_data(stk, NULL);
 =

 	g_at_chat_unref(sd->chat);
-- =

1.7.10.4


--===============5510206720033032551==--

