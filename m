Content-Type: multipart/mixed; boundary="===============5504606004384698664=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 2/2] huawei: Create sim atom for cdma modems
Date: Wed, 11 Jan 2012 17:28:34 +0100
Message-ID: <1326299314-13617-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1326299314-13617-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5504606004384698664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Don't create atom if sim is embedded.
Atom will use "atmodem-noef" drivers to support PIN management
and IMSI retrieval.
---
 plugins/huawei.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 5030e00..bcec467 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -748,6 +748,18 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 			ofono_sim_inserted_notify(sim, TRUE);
 	} else if (data->have_cdma =3D=3D TRUE) {
 		ofono_devinfo_create(modem, 0, "cdmamodem", data->pcui);
+
+		/* Create SIM atom only if SIM is not embedded */
+		if (data->sim_state !=3D SIM_STATE_ROMSIM) {
+			struct ofono_sim *sim;
+
+			/* Use sim drivers without Elementary File entries */
+			sim =3D ofono_sim_create(modem, OFONO_VENDOR_HUAWEI,
+						"atmodem-noef", data->pcui);
+
+			if (sim && data->have_sim =3D=3D TRUE)
+				ofono_sim_inserted_notify(sim, TRUE);
+		}
 	}
 }
 =

-- =

1.7.1


--===============5504606004384698664==--

