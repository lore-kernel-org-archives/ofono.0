Content-Type: multipart/mixed; boundary="===============5302957914358886443=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 4/4] sim: mnclength plugin is called in case no MNC lenght is
 found in the SIM
Date: Thu, 24 Oct 2013 13:03:43 +0200
Message-ID: <1382612623-29678-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5302957914358886443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |  4 ++++
 src/sim.c   | 18 +++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/ofono.h b/src/ofono.h
index 8abaf1e..b0d12d0 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -519,3 +519,7 @@ ofono_bool_t __ofono_cdma_provision_get_name(const char=
 *sid, char **name);
 void __ofono_private_network_release(int id);
 ofono_bool_t __ofono_private_network_request(ofono_private_network_cb_t cb,
 						int *id, void *data);
+
+#include <ofono/sim-mnclength.h>
+
+int __ofono_sim_mnclength_get_mnclength(const char *imsi);
diff --git a/src/sim.c b/src/sim.c
index edae5eb..beec74e 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1435,6 +1435,18 @@ static void sim_imsi_obtained(struct ofono_sim *sim,=
 const char *imsi)
 						"SubscriberIdentity",
 						DBUS_TYPE_STRING, &sim->imsi);
 =

+	/*
+	 * sim->mnc_length =3D 0 means that EFad was not present or that EFad did
+	 * not contain the MNC length field (MNC length is not mandatory for
+	 * SIMs (non-USIM) - see TS 51.011).
+	 *
+	 * MNC can have either 2 or 3 digits depending on the MCC: we will try
+	 * to find a correspondence in an MCC-MNC length database
+	 */
+	if (sim->mnc_length =3D=3D 0)
+		sim->mnc_length =3D
+			__ofono_sim_mnclength_get_mnclength(sim->imsi);
+
 	if (sim->mnc_length) {
 		const char *str;
 =

@@ -1772,8 +1784,12 @@ static void sim_ad_read_cb(int ok, int length, int r=
ecord,
 	if (!ok)
 		return;
 =

+	if (length < 3) {
+		ofono_error("EFad should contain at least three bytes");
+		return;
+	}
 	if (length < 4) {
-		ofono_error("EFad should contain@least four bytes");
+		ofono_info("EFad does not contain MNC length");
 		return;
 	}
 =

-- =

1.8.3.2


--===============5302957914358886443==--

