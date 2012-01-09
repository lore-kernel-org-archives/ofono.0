Content-Type: multipart/mixed; boundary="===============1433399113285393673=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 4/5] speedup: Create CDMA atoms if support has been detected
Date: Mon, 09 Jan 2012 14:10:59 +0100
Message-ID: <1326114660-10111-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1326114660-10111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1433399113285393673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/speedup.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/plugins/speedup.c b/plugins/speedup.c
index 02b6f61..7c475a1 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -43,6 +43,8 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/phonebook.h>
+#include <ofono/cdma-netreg.h>
+#include <ofono/cdma-connman.h>
 #include <ofono/log.h>
 =

 #include <drivers/atmodem/atutil.h>
@@ -276,6 +278,8 @@ static void speedup_pre_sim(struct ofono_modem *modem)
 =

 		if (sim && data->have_sim =3D=3D TRUE)
 			ofono_sim_inserted_notify(sim, TRUE);
+	} else if (data->have_cdma =3D=3D TRUE) {
+		ofono_devinfo_create(modem, 0, "cdmamodem", data->aux);
 	}
 }
 =

@@ -315,6 +319,11 @@ static void speedup_post_online(struct ofono_modem *mo=
dem)
 							"atmodem", data->aux);
 		ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 							"atmodem", data->aux);
+	} else if (data->have_cdma =3D=3D TRUE) {
+		ofono_cdma_netreg_create(modem, 0, "huaweimodem", data->aux);
+
+		ofono_cdma_connman_create(modem, OFONO_VENDOR_HUAWEI,
+						"cdmamodem", data->modem);
 	}
 }
 =

-- =

1.7.1


--===============1433399113285393673==--

