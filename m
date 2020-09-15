Content-Type: multipart/mixed; boundary="===============8307453770568834127=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/3] droid 4: add special handling required for voice calls
 and SIM
Date: Tue, 15 Sep 2020 15:23:01 +0200
Message-ID: <20200915132300.GA13208@duo.ucw.cz>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8307453770568834127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Droid 4 modem is "special" (aka broken) so it seems to need a bit of
error handling.
---
 drivers/atmodem/sim.c       | 1 +
 drivers/atmodem/vendor.h    | 1 +
 drivers/atmodem/voicecall.c | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index e750a139..f46cd3a2 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -199,6 +199,7 @@ static void at_sim_read_info(struct ofono_sim *sim, int=
 fileid,
 	case OFONO_VENDOR_SPEEDUP:
 	case OFONO_VENDOR_QUALCOMM_MSM:
 	case OFONO_VENDOR_SIMCOM:
+	case OFONO_VENDOR_DROID:
 		/* Maximum possible length */
 		len +=3D sprintf(buf + len, ",0,0,255");
 		break;
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index d839d1e0..2bfd3eb8 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -27,6 +27,7 @@ enum ofono_vendor {
 	OFONO_VENDOR_MBM,
 	OFONO_VENDOR_GOBI,
 	OFONO_VENDOR_QUALCOMM_MSM,
+	OFONO_VENDOR_DROID,
 	OFONO_VENDOR_OPTION_HSO,
 	OFONO_VENDOR_ZTE,
 	OFONO_VENDOR_HUAWEI,
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 7ab6567f..6c80bd4e 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -160,6 +160,10 @@ static void clcc_poll_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 			poll_again =3D TRUE;
 			goto poll_again;
 		}
+		if (vd->vendor =3D=3D OFONO_VENDOR_DROID) {
+			poll_again =3D TRUE;
+			goto poll_again;
+		}
 =

 		ofono_error("We are polling CLCC and received an error");
 		ofono_error("All bets are off for call management");
-- =

2.11.0

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============8307453770568834127==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlGMEVBQkVDQUIwV0lRUlBmUE83cjBlQWhr
MDEwdjB3NS9CcWxkdjY4Z1VDWDJEQU5BQUtDUkF3NS9CcWxkdjYKOG9QWEFLQ3RNWkhMRkpSYW9K
SCtLKzM3azBCcjQzYm9SUUNncUlua3Z3MExrOXRvQ0VDM0ExNm1NYVlFRndvPQo9T1JFZAotLS0t
LUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============8307453770568834127==--

