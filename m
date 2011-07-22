Content-Type: multipart/mixed; boundary="===============6536958473255888704=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/4] speedup: Create SIM atom with SpeedUp vendor to handle
 proprietary commands
Date: Fri, 22 Jul 2011 18:15:27 +0200
Message-ID: <1311351329-1241-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1311351329-1241-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6536958473255888704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |    1 +
 plugins/speedup.c     |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 2690ab4..a4a09f5 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -151,6 +151,7 @@ static void at_sim_read_info(struct ofono_sim *sim, int=
 fileid,
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_SIERRA:
 	case OFONO_VENDOR_QUALCOMM_MSM:
+	case OFONO_VENDOR_SPEEDUP:
 		strcat(buf, ",0,0,255"); /* Maximum possible length */
 		break;
 	}
diff --git a/plugins/speedup.c b/plugins/speedup.c
index 23ba173..9302dcc 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -330,7 +330,7 @@ static void speedup_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
-	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_SPEEDUP,
 				"atmodem", data->aux);
 =

 	if (sim)
-- =

1.7.1


--===============6536958473255888704==--

