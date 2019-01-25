Content-Type: multipart/mixed; boundary="===============9221171745038857606=="
MIME-Version: 1.0
From: Nicolas Serafini <nicolas.serafini@sensefly.com>
Subject: [PATCH] qmimodem: Notify when SIM is initialized
Date: Fri, 25 Jan 2019 13:15:02 +0000
Message-ID: <20190125131436.982-1-nicolas.serafini@sensefly.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9221171745038857606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the commit that introduced the notification API of a SIM inserted
and initialized I can not unlock the SIM card on a WP7607 modem.

The previously mentioned commit: 54d56d763e40bc44c99a9b24aa0477bd373ea085

Signed-off-by: Nicolas Serafini <nicolas.serafini@sensefly.com>
---
 drivers/qmimodem/sim-legacy.c | 1 +
 drivers/qmimodem/sim.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index af857693..30eb4613 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -250,6 +250,7 @@ static void process_uim_state(struct ofono_sim *sim, ui=
nt8_t state)
 	switch (state) {
 	case QMI_DMS_UIM_STATE_INIT_COMPLETE:
 		ofono_sim_inserted_notify(sim, TRUE);
+		ofono_sim_initialized_notify(sim);
 		break;
 	case QMI_DMS_UIM_STATE_INIT_FAILED:
 	case QMI_DMS_UIM_STATE_NOT_PRESENT:
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 8edabb80..e91c6578 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -791,6 +791,7 @@ static void get_card_status_cb(struct qmi_result *resul=
t, void *user_data)
 		break;
 	case 0x01:	/* Present */
 		ofono_sim_inserted_notify(sim, TRUE);
+		ofono_sim_initialized_notify(sim);
 		break;
 	}
 }
-- =

2.20.1


--===============9221171745038857606==--

