Content-Type: multipart/mixed; boundary="===============4112333453200425389=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/4] MC7430: use qmimodem sim driver
Date: Wed, 28 Dec 2016 16:03:59 +0100
Message-ID: <20161228150402.15660-2-c.ronco@kerlink.fr>
In-Reply-To: <20161228150402.15660-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4112333453200425389==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

QMI modem sim-legacy driver uses a command not supported by MC7430 (QMI_DMS=
_GET_PIN_STATUS)

plugins/udevng.c
 QMI Sierra modems use sim driver.
drivers/qmimodem/sim.c
 In get_card_status_cb, call ofono_sim_register after ofono_sim_inserted_no=
tify (as it is done in sim_legacy).
 Otherwise process crash (sim->driver->query_facility_lock called and not d=
efined in this driver) with  MC7430 modem using this driver.
---
 drivers/qmimodem/sim.c | 3 +--
 plugins/udevng.c       | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 197da509..fa7bef58 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -403,8 +403,6 @@ static void get_card_status_cb(struct qmi_result *resul=
t, void *user_data)
 	}
 =

 done:
-	ofono_sim_register(sim);
-
 	switch (data->card_state) {
 	case 0x00:	/* Absent */
 	case 0x02:	/* Error */
@@ -413,6 +411,7 @@ done:
 		ofono_sim_inserted_notify(sim, TRUE);
 		break;
 	}
+	ofono_sim_register(sim);
 }
 =

 static void event_registration_cb(struct qmi_result *result, void *user_da=
ta)
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 933bf4fa..a2866b64 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -252,8 +252,6 @@ static gboolean setup_sierra(struct modem_info *modem)
 =

 	if (qmi !=3D NULL && net !=3D NULL) {
 		ofono_modem_set_driver(modem->modem, "gobi");
-		/* Fixup SIM interface for Sierra QMI devices */
-		ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
 		goto done;
 	}
 =

-- =

2.11.0


--===============4112333453200425389==--

