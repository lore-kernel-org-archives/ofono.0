Content-Type: multipart/mixed; boundary="===============1982364925579478704=="
MIME-Version: 1.0
From: Anthony Viallard <viallard@syscom-instruments.com>
Subject: [PATCH 4/6] SIMCOM: add a quirk to fix crsm request
Date: Fri, 19 Jul 2013 15:35:38 +0200
Message-ID: <1374240940-30892-4-git-send-email-viallard@syscom-instruments.com>
In-Reply-To: <1374240940-30892-1-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1982364925579478704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index f97f5b8..f8e0472 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -167,6 +167,7 @@ static void at_sim_read_info(struct ofono_sim *sim, int=
 fileid,
 	case OFONO_VENDOR_SIERRA:
 	case OFONO_VENDOR_SPEEDUP:
 	case OFONO_VENDOR_QUALCOMM_MSM:
+	case OFONO_VENDOR_SIMCOM:
 		/* Maximum possible length */
 		len +=3D sprintf(buf + len, ",0,0,255");
 		break;
-- =

1.8.3.1


--===============1982364925579478704==--

