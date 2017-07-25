Content-Type: multipart/mixed; boundary="===============5583890972714085094=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH] plugins/allowed-apns: remove dbus interface when modem
 disappear
Date: Tue, 25 Jul 2017 19:42:09 +0200
Message-ID: <20170725174209.4919-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5583890972714085094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previous a disappeared modem still shows the following methods:
org.ofono.AllowedAccessPoints.GetAllowedAccessPoints
---
 plugins/allowed-apns.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/allowed-apns.c b/plugins/allowed-apns.c
index 532d17af..b222b91c 100644
--- a/plugins/allowed-apns.c
+++ b/plugins/allowed-apns.c
@@ -195,6 +195,7 @@ static void sim_watch(struct ofono_atom *atom,
 =

 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
 		if (ctx->simwatch_id) {
+			sim_state_watch(OFONO_SIM_STATE_NOT_PRESENT, data);
 			ofono_sim_remove_state_watch(ctx->sim, ctx->simwatch_id);
 			ctx->simwatch_id =3D 0;
 		}
-- =

2.13.3


--===============5583890972714085094==--

