Content-Type: multipart/mixed; boundary="===============4124127318772710037=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/2] atmodem: Create new sim driver without EF entries
Date: Wed, 11 Jan 2012 17:23:31 +0100
Message-ID: <1326299012-13084-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1326299012-13084-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4124127318772710037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This driver will be used by CDMA modems to support PIN
management and IMSI retreival.
EF entries for CDMA modems cannot be implemented without
manufacturers specifications.
---
 drivers/atmodem/sim.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 297914d..8edd582 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1269,12 +1269,28 @@ static struct ofono_sim_driver driver =3D {
 	.query_locked		=3D at_pin_query_enabled,
 };
 =

+static struct ofono_sim_driver driver_noef =3D {
+	.name			=3D "atmodem-noef",
+	.probe			=3D at_sim_probe,
+	.remove			=3D at_sim_remove,
+	.read_imsi		=3D at_read_imsi,
+	.query_passwd_state	=3D at_pin_query,
+	.query_pin_retries	=3D at_pin_retries_query,
+	.send_passwd		=3D at_pin_send,
+	.reset_passwd		=3D at_pin_send_puk,
+	.lock			=3D at_pin_enable,
+	.change_passwd		=3D at_change_passwd,
+	.query_locked		=3D at_pin_query_enabled,
+};
+
 void at_sim_init(void)
 {
 	ofono_sim_driver_register(&driver);
+	ofono_sim_driver_register(&driver_noef);
 }
 =

 void at_sim_exit(void)
 {
 	ofono_sim_driver_unregister(&driver);
+	ofono_sim_driver_unregister(&driver_noef);
 }
-- =

1.7.1


--===============4124127318772710037==--

