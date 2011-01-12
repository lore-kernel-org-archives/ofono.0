Content-Type: multipart/mixed; boundary="===============3074606456899211910=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 13/16] atmodem: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:15 +0200
Message-ID: <1294829538-3893-14-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3074606456899211910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atmodem.h              |   68 ++++++++++++++++------------=
----
 drivers/atmodem/call-barring.c         |    4 +-
 drivers/atmodem/call-forwarding.c      |    4 +-
 drivers/atmodem/call-meter.c           |    4 +-
 drivers/atmodem/call-settings.c        |    4 +-
 drivers/atmodem/call-volume.c          |    4 +-
 drivers/atmodem/cbs.c                  |    4 +-
 drivers/atmodem/gprs-context.c         |    4 +-
 drivers/atmodem/gprs.c                 |    4 +-
 drivers/atmodem/network-registration.c |    4 +-
 drivers/atmodem/phonebook.c            |    6 +-
 drivers/atmodem/sim.c                  |    4 +-
 drivers/atmodem/sms.c                  |    4 +-
 drivers/atmodem/ssn.c                  |    4 +-
 drivers/atmodem/stk.c                  |    4 +-
 drivers/atmodem/ussd.c                 |    4 +-
 drivers/atmodem/voicecall.c            |    4 +-
 17 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/atmodem/atmodem.h b/drivers/atmodem/atmodem.h
index 2ee47f5..c7f0eed 100644
--- a/drivers/atmodem/atmodem.h
+++ b/drivers/atmodem/atmodem.h
@@ -21,53 +21,53 @@
 =

 #include "atutil.h"
 =

-extern void at_netreg_init();
-extern void at_netreg_exit();
+extern void at_netreg_init(void);
+extern void at_netreg_exit(void);
 =

-extern void at_call_forwarding_init();
-extern void at_call_forwarding_exit();
+extern void at_call_forwarding_init(void);
+extern void at_call_forwarding_exit(void);
 =

-extern void at_call_settings_init();
-extern void at_call_settings_exit();
+extern void at_call_settings_init(void);
+extern void at_call_settings_exit(void);
 =

-extern void at_ussd_init();
-extern void at_ussd_exit();
+extern void at_ussd_init(void);
+extern void at_ussd_exit(void);
 =

-extern void at_voicecall_init();
-extern void at_voicecall_exit();
+extern void at_voicecall_init(void);
+extern void at_voicecall_exit(void);
 =

-extern void at_call_meter_init();
-extern void at_call_meter_exit();
+extern void at_call_meter_init(void);
+extern void at_call_meter_exit(void);
 =

-extern void at_call_barring_init();
-extern void at_call_barring_exit();
+extern void at_call_barring_init(void);
+extern void at_call_barring_exit(void);
 =

-extern void at_sim_init();
-extern void at_sim_exit();
+extern void at_sim_init(void);
+extern void at_sim_exit(void);
 =

-extern void at_stk_init();
-extern void at_stk_exit();
+extern void at_stk_init(void);
+extern void at_stk_exit(void);
 =

-extern void at_sms_init();
-extern void at_sms_exit();
+extern void at_sms_init(void);
+extern void at_sms_exit(void);
 =

-extern void at_phonebook_init();
-extern void at_phonebook_exit();
+extern void at_phonebook_init(void);
+extern void at_phonebook_exit(void);
 =

-extern void at_ssn_init();
-extern void at_ssn_exit();
+extern void at_ssn_init(void);
+extern void at_ssn_exit(void);
 =

-extern void at_devinfo_init();
-extern void at_devinfo_exit();
+extern void at_devinfo_init(void);
+extern void at_devinfo_exit(void);
 =

-extern void at_cbs_init();
-extern void at_cbs_exit();
+extern void at_cbs_init(void);
+extern void at_cbs_exit(void);
 =

-extern void at_call_volume_init();
-extern void at_call_volume_exit();
+extern void at_call_volume_init(void);
+extern void at_call_volume_exit(void);
 =

-extern void at_gprs_init();
-extern void at_gprs_exit();
+extern void at_gprs_init(void);
+extern void at_gprs_exit(void);
 =

-extern void at_gprs_context_init();
-extern void at_gprs_context_exit();
+extern void at_gprs_context_init(void);
+extern void at_gprs_context_exit(void);
diff --git a/drivers/atmodem/call-barring.c b/drivers/atmodem/call-barring.c
index c0b1d11..516b470 100644
--- a/drivers/atmodem/call-barring.c
+++ b/drivers/atmodem/call-barring.c
@@ -217,12 +217,12 @@ static struct ofono_call_barring_driver driver =3D {
 	.set_passwd	=3D at_call_barring_set_passwd,
 };
 =

-void at_call_barring_init()
+void at_call_barring_init(void)
 {
 	ofono_call_barring_driver_register(&driver);
 }
 =

-void at_call_barring_exit()
+void at_call_barring_exit(void)
 {
 	ofono_call_barring_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/call-forwarding.c b/drivers/atmodem/call-forwa=
rding.c
index a74d4c3..f11a68e 100644
--- a/drivers/atmodem/call-forwarding.c
+++ b/drivers/atmodem/call-forwarding.c
@@ -282,12 +282,12 @@ static struct ofono_call_forwarding_driver driver =3D=
 {
 	.erasure	=3D at_ccfc_erasure
 };
 =

-void at_call_forwarding_init()
+void at_call_forwarding_init(void)
 {
 	ofono_call_forwarding_driver_register(&driver);
 }
 =

-void at_call_forwarding_exit()
+void at_call_forwarding_exit(void)
 {
 	ofono_call_forwarding_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/call-meter.c b/drivers/atmodem/call-meter.c
index 5c93397..3ab4706 100644
--- a/drivers/atmodem/call-meter.c
+++ b/drivers/atmodem/call-meter.c
@@ -372,12 +372,12 @@ static struct ofono_call_meter_driver driver =3D {
 	.puct_set =3D at_cpuc_set,
 };
 =

-void at_call_meter_init()
+void at_call_meter_init(void)
 {
 	ofono_call_meter_driver_register(&driver);
 }
 =

-void at_call_meter_exit()
+void at_call_meter_exit(void)
 {
 	ofono_call_meter_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/call-settings.c b/drivers/atmodem/call-setting=
s.c
index 3340d5a..7b00357 100644
--- a/drivers/atmodem/call-settings.c
+++ b/drivers/atmodem/call-settings.c
@@ -395,12 +395,12 @@ static struct ofono_call_settings_driver driver =3D {
 	.cw_set =3D at_ccwa_set,
 };
 =

-void at_call_settings_init()
+void at_call_settings_init(void)
 {
 	ofono_call_settings_driver_register(&driver);
 }
 =

-void at_call_settings_exit()
+void at_call_settings_exit(void)
 {
 	ofono_call_settings_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/call-volume.c b/drivers/atmodem/call-volume.c
index fbec668..d3910d4 100644
--- a/drivers/atmodem/call-volume.c
+++ b/drivers/atmodem/call-volume.c
@@ -222,12 +222,12 @@ static struct ofono_call_volume_driver driver =3D {
 	.mute =3D at_call_volume_mute,
 };
 =

-void at_call_volume_init()
+void at_call_volume_init(void)
 {
 	ofono_call_volume_driver_register(&driver);
 }
 =

-void at_call_volume_exit()
+void at_call_volume_exit(void)
 {
 	ofono_call_volume_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index 479bfea..44e154d 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -269,12 +269,12 @@ static struct ofono_cbs_driver driver =3D {
 	.clear_topics =3D at_cbs_clear_topics,
 };
 =

-void at_cbs_init()
+void at_cbs_init(void)
 {
 	ofono_cbs_driver_register(&driver);
 }
 =

-void at_cbs_exit()
+void at_cbs_exit(void)
 {
 	ofono_cbs_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 6b657f3..56d65d4 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -317,12 +317,12 @@ static struct ofono_gprs_context_driver driver =3D {
 	.deactivate_primary	=3D at_gprs_deactivate_primary,
 };
 =

-void at_gprs_context_init()
+void at_gprs_context_init(void)
 {
 	ofono_gprs_context_driver_register(&driver);
 }
 =

-void at_gprs_context_exit()
+void at_gprs_context_exit(void)
 {
 	ofono_gprs_context_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 8cff35b..defb154 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -382,12 +382,12 @@ static struct ofono_gprs_driver driver =3D {
 	.attached_status	=3D at_gprs_registration_status,
 };
 =

-void at_gprs_init()
+void at_gprs_init(void)
 {
 	ofono_gprs_driver_register(&driver);
 }
 =

-void at_gprs_exit()
+void at_gprs_exit(void)
 {
 	ofono_gprs_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index f18b9d7..0c77ba8 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1346,12 +1346,12 @@ static struct ofono_netreg_driver driver =3D {
 	.strength			=3D at_signal_strength,
 };
 =

-void at_netreg_init()
+void at_netreg_init(void)
 {
 	ofono_netreg_driver_register(&driver);
 }
 =

-void at_netreg_exit()
+void at_netreg_exit(void)
 {
 	ofono_netreg_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/phonebook.c b/drivers/atmodem/phonebook.c
index 731205e..64aa05e 100644
--- a/drivers/atmodem/phonebook.c
+++ b/drivers/atmodem/phonebook.c
@@ -63,7 +63,7 @@ struct pb_data {
 	guint ready_id;
 };
 =

-static void warn_bad()
+static void warn_bad(void)
 {
 	ofono_warn("Name field conversion to UTF8 failed, this can indicate a"
 			" problem with modem integration, as this field"
@@ -569,12 +569,12 @@ static struct ofono_phonebook_driver driver =3D {
 	.export_entries	=3D at_export_entries
 };
 =

-void at_phonebook_init()
+void at_phonebook_init(void)
 {
 	ofono_phonebook_driver_register(&driver);
 }
 =

-void at_phonebook_exit()
+void at_phonebook_exit(void)
 {
 	ofono_phonebook_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index b1d971d..c5f4a44 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -996,12 +996,12 @@ static struct ofono_sim_driver driver =3D {
 	.query_locked		=3D at_pin_query_enabled,
 };
 =

-void at_sim_init()
+void at_sim_init(void)
 {
 	ofono_sim_driver_register(&driver);
 }
 =

-void at_sim_exit()
+void at_sim_exit(void)
 {
 	ofono_sim_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 559b570..c570886 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -1256,12 +1256,12 @@ static struct ofono_sms_driver driver =3D {
 	.bearer_set	=3D at_cgsms_set,
 };
 =

-void at_sms_init()
+void at_sms_init(void)
 {
 	ofono_sms_driver_register(&driver);
 }
 =

-void at_sms_exit()
+void at_sms_exit(void)
 {
 	ofono_sms_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/ssn.c b/drivers/atmodem/ssn.c
index c0e2040..b7a9df4 100644
--- a/drivers/atmodem/ssn.c
+++ b/drivers/atmodem/ssn.c
@@ -136,12 +136,12 @@ static struct ofono_ssn_driver driver =3D {
 	.remove =3D at_ssn_remove,
 };
 =

-void at_ssn_init()
+void at_ssn_init(void)
 {
 	ofono_ssn_driver_register(&driver);
 }
 =

-void at_ssn_exit()
+void at_ssn_exit(void)
 {
 	ofono_ssn_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index fa8175a..4de3042 100644
--- a/drivers/atmodem/stk.c
+++ b/drivers/atmodem/stk.c
@@ -335,12 +335,12 @@ static struct ofono_stk_driver driver =3D {
 	.terminal_response	=3D at_stk_terminal_response,
 };
 =

-void at_stk_init()
+void at_stk_init(void)
 {
 	ofono_stk_driver_register(&driver);
 }
 =

-void at_stk_exit()
+void at_stk_exit(void)
 {
 	ofono_stk_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 78f6004..651b6af 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -340,12 +340,12 @@ static struct ofono_ussd_driver driver =3D {
 	.cancel		=3D at_ussd_cancel
 };
 =

-void at_ussd_init()
+void at_ussd_init(void)
 {
 	ofono_ussd_driver_register(&driver);
 }
 =

-void at_ussd_exit()
+void at_ussd_exit(void)
 {
 	ofono_ussd_driver_unregister(&driver);
 }
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 75e0c93..13862fb 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -1027,12 +1027,12 @@ static struct ofono_voicecall_driver driver =3D {
 	.send_tones		=3D at_send_dtmf
 };
 =

-void at_voicecall_init()
+void at_voicecall_init(void)
 {
 	ofono_voicecall_driver_register(&driver);
 }
 =

-void at_voicecall_exit()
+void at_voicecall_exit(void)
 {
 	ofono_voicecall_driver_unregister(&driver);
 }
-- =

1.7.0.4


--===============3074606456899211910==--

