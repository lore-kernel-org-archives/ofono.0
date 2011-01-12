Content-Type: multipart/mixed; boundary="===============6659323961593904542=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 12/16] isimodem: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:14 +0200
Message-ID: <1294829538-3893-13-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6659323961593904542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/audio-settings.c       |    4 +-
 drivers/isimodem/call-barring.c         |    4 +-
 drivers/isimodem/call-forwarding.c      |    4 +-
 drivers/isimodem/call-meter.c           |    4 +-
 drivers/isimodem/call-settings.c        |    4 +-
 drivers/isimodem/cbs.c                  |    4 +-
 drivers/isimodem/devinfo.c              |    4 +-
 drivers/isimodem/gprs-context.c         |    4 +-
 drivers/isimodem/isimodem.h             |   68 +++++++++++++++------------=
---
 drivers/isimodem/network-registration.c |    4 +-
 drivers/isimodem/phonebook.c            |    4 +-
 drivers/isimodem/radio-settings.c       |    4 +-
 drivers/isimodem/sim.c                  |    4 +-
 drivers/isimodem/sms.c                  |    4 +-
 drivers/isimodem/ssn.c                  |    4 +-
 drivers/isimodem/ussd.c                 |    4 +-
 drivers/isimodem/voicecall.c            |    4 +-
 17 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/isimodem/audio-settings.c b/drivers/isimodem/audio-set=
tings.c
index fa17747..65c596b 100644
--- a/drivers/isimodem/audio-settings.c
+++ b/drivers/isimodem/audio-settings.c
@@ -121,12 +121,12 @@ static struct ofono_audio_settings_driver driver =3D {
 	.remove		=3D isi_audio_settings_remove,
 };
 =

-void isi_audio_settings_init()
+void isi_audio_settings_init(void)
 {
 	ofono_audio_settings_driver_register(&driver);
 }
 =

-void isi_audio_settings_exit()
+void isi_audio_settings_exit(void)
 {
 	ofono_audio_settings_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/call-barring.c b/drivers/isimodem/call-barrin=
g.c
index 26ca545..a78b762 100644
--- a/drivers/isimodem/call-barring.c
+++ b/drivers/isimodem/call-barring.c
@@ -388,12 +388,12 @@ static struct ofono_call_barring_driver driver =3D {
 	.set_passwd		=3D isi_set_passwd
 };
 =

-void isi_call_barring_init()
+void isi_call_barring_init(void)
 {
 	ofono_call_barring_driver_register(&driver);
 }
 =

-void isi_call_barring_exit()
+void isi_call_barring_exit(void)
 {
 	ofono_call_barring_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-for=
warding.c
index 3a98449..2fafb26 100644
--- a/drivers/isimodem/call-forwarding.c
+++ b/drivers/isimodem/call-forwarding.c
@@ -480,12 +480,12 @@ static struct ofono_call_forwarding_driver driver =3D=
 {
 	.query			=3D isi_query
 };
 =

-void isi_call_forwarding_init()
+void isi_call_forwarding_init(void)
 {
 	ofono_call_forwarding_driver_register(&driver);
 }
 =

-void isi_call_forwarding_exit()
+void isi_call_forwarding_exit(void)
 {
 	ofono_call_forwarding_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/call-meter.c b/drivers/isimodem/call-meter.c
index 66dae47..04a3c10 100644
--- a/drivers/isimodem/call-meter.c
+++ b/drivers/isimodem/call-meter.c
@@ -131,12 +131,12 @@ static struct ofono_call_meter_driver driver =3D {
 	.puct_set		=3D isi_puct_set
 };
 =

-void isi_call_meter_init()
+void isi_call_meter_init(void)
 {
 	ofono_call_meter_driver_register(&driver);
 }
 =

-void isi_call_meter_exit()
+void isi_call_meter_exit(void)
 {
 	ofono_call_meter_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/call-settings.c b/drivers/isimodem/call-setti=
ngs.c
index 51a761f..89270e9 100644
--- a/drivers/isimodem/call-settings.c
+++ b/drivers/isimodem/call-settings.c
@@ -311,12 +311,12 @@ static struct ofono_call_settings_driver driver =3D {
 	.cw_set			=3D isi_cw_set
 };
 =

-void isi_call_settings_init()
+void isi_call_settings_init(void)
 {
 	ofono_call_settings_driver_register(&driver);
 }
 =

-void isi_call_settings_exit()
+void isi_call_settings_exit(void)
 {
 	ofono_call_settings_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/cbs.c b/drivers/isimodem/cbs.c
index 871e0ea..b969c1f 100644
--- a/drivers/isimodem/cbs.c
+++ b/drivers/isimodem/cbs.c
@@ -219,12 +219,12 @@ static struct ofono_cbs_driver driver =3D {
 	.clear_topics		=3D isi_clear_topics
 };
 =

-void isi_cbs_init()
+void isi_cbs_init(void)
 {
 	ofono_cbs_driver_register(&driver);
 }
 =

-void isi_cbs_exit()
+void isi_cbs_exit(void)
 {
 	ofono_cbs_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/devinfo.c b/drivers/isimodem/devinfo.c
index bb30730..3bf05f4 100644
--- a/drivers/isimodem/devinfo.c
+++ b/drivers/isimodem/devinfo.c
@@ -260,12 +260,12 @@ static struct ofono_devinfo_driver driver =3D {
 	.query_serial		=3D isi_query_serial
 };
 =

-void isi_devinfo_init()
+void isi_devinfo_init(void)
 {
 	ofono_devinfo_driver_register(&driver);
 }
 =

-void isi_devinfo_exit()
+void isi_devinfo_exit(void)
 {
 	ofono_devinfo_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index bfb496c..6d579d8 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -622,12 +622,12 @@ static struct ofono_gprs_context_driver driver =3D {
 	.deactivate_primary	=3D isi_gprs_deactivate_primary,
 };
 =

-void isi_gprs_context_init()
+void isi_gprs_context_init(void)
 {
 	ofono_gprs_context_driver_register(&driver);
 }
 =

-void isi_gprs_context_exit()
+void isi_gprs_context_exit(void)
 {
 	ofono_gprs_context_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/isimodem.h b/drivers/isimodem/isimodem.h
index 545a6dc..37191c7 100644
--- a/drivers/isimodem/isimodem.h
+++ b/drivers/isimodem/isimodem.h
@@ -21,53 +21,53 @@
 =

 extern struct ofono_modem *isi_modem_by_interface(char const *ifname);
 =

-extern void isi_phonebook_init();
-extern void isi_phonebook_exit();
+extern void isi_phonebook_init(void);
+extern void isi_phonebook_exit(void);
 =

-extern void isi_devinfo_init();
-extern void isi_devinfo_exit();
+extern void isi_devinfo_init(void);
+extern void isi_devinfo_exit(void);
 =

-extern void isi_netreg_init();
-extern void isi_netreg_exit();
+extern void isi_netreg_init(void);
+extern void isi_netreg_exit(void);
 =

-extern void isi_voicecall_init();
-extern void isi_voicecall_exit();
+extern void isi_voicecall_init(void);
+extern void isi_voicecall_exit(void);
 =

-extern void isi_sms_init();
-extern void isi_sms_exit();
+extern void isi_sms_init(void);
+extern void isi_sms_exit(void);
 =

-extern void isi_cbs_init();
-extern void isi_cbs_exit();
+extern void isi_cbs_init(void);
+extern void isi_cbs_exit(void);
 =

-extern void isi_sim_init();
-extern void isi_sim_exit();
+extern void isi_sim_init(void);
+extern void isi_sim_exit(void);
 =

-extern void isi_ussd_init();
-extern void isi_ussd_exit();
+extern void isi_ussd_init(void);
+extern void isi_ussd_exit(void);
 =

-extern void isi_ssn_init();
-extern void isi_ssn_exit();
+extern void isi_ssn_init(void);
+extern void isi_ssn_exit(void);
 =

-extern void isi_call_forwarding_init();
-extern void isi_call_forwarding_exit();
+extern void isi_call_forwarding_init(void);
+extern void isi_call_forwarding_exit(void);
 =

-extern void isi_call_settings_init();
-extern void isi_call_settings_exit();
+extern void isi_call_settings_init(void);
+extern void isi_call_settings_exit(void);
 =

-extern void isi_call_barring_init();
-extern void isi_call_barring_exit();
+extern void isi_call_barring_init(void);
+extern void isi_call_barring_exit(void);
 =

-extern void isi_call_meter_init();
-extern void isi_call_meter_exit();
+extern void isi_call_meter_init(void);
+extern void isi_call_meter_exit(void);
 =

-extern void isi_radio_settings_init();
-extern void isi_radio_settings_exit();
+extern void isi_radio_settings_init(void);
+extern void isi_radio_settings_exit(void);
 =

-extern void isi_gprs_init();
-extern void isi_gprs_exit();
+extern void isi_gprs_init(void);
+extern void isi_gprs_exit(void);
 =

-extern void isi_gprs_context_init();
-extern void isi_gprs_context_exit();
+extern void isi_gprs_context_init(void);
+extern void isi_gprs_context_exit(void);
 =

-extern void isi_audio_settings_init();
-extern void isi_audio_settings_exit();
+extern void isi_audio_settings_init(void);
+extern void isi_audio_settings_exit(void);
diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/net=
work-registration.c
index 3799b7f..47aaeb1 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -863,12 +863,12 @@ static struct ofono_netreg_driver driver =3D {
 	.strength		=3D isi_strength,
 };
 =

-void isi_netreg_init()
+void isi_netreg_init(void)
 {
 	ofono_netreg_driver_register(&driver);
 }
 =

-void isi_netreg_exit()
+void isi_netreg_exit(void)
 {
 	ofono_netreg_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/phonebook.c b/drivers/isimodem/phonebook.c
index 234b708..1f92d37 100644
--- a/drivers/isimodem/phonebook.c
+++ b/drivers/isimodem/phonebook.c
@@ -345,12 +345,12 @@ static struct ofono_phonebook_driver driver =3D {
 	.export_entries		=3D isi_export_entries
 };
 =

-void isi_phonebook_init()
+void isi_phonebook_init(void)
 {
 	ofono_phonebook_driver_register(&driver);
 }
 =

-void isi_phonebook_exit()
+void isi_phonebook_exit(void)
 {
 	ofono_phonebook_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/radio-settings.c b/drivers/isimodem/radio-set=
tings.c
index 21e3da5..5d99213 100644
--- a/drivers/isimodem/radio-settings.c
+++ b/drivers/isimodem/radio-settings.c
@@ -373,12 +373,12 @@ static struct ofono_radio_settings_driver driver =3D {
 	.set_fast_dormancy	=3D isi_set_fast_dormancy,
 };
 =

-void isi_radio_settings_init()
+void isi_radio_settings_init(void)
 {
 	ofono_radio_settings_driver_register(&driver);
 }
 =

-void isi_radio_settings_exit()
+void isi_radio_settings_exit(void)
 {
 	ofono_radio_settings_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index b45e166..991d8b7 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -497,12 +497,12 @@ static struct ofono_sim_driver driver =3D {
 	.read_imsi		=3D isi_read_imsi,
 };
 =

-void isi_sim_init()
+void isi_sim_init(void)
 {
 	ofono_sim_driver_register(&driver);
 }
 =

-void isi_sim_exit()
+void isi_sim_exit(void)
 {
 	ofono_sim_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index 15e37a3..ded7d9c 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -732,12 +732,12 @@ static struct ofono_sms_driver driver =3D {
 	.bearer_set		=3D isi_bearer_set,
 };
 =

-void isi_sms_init()
+void isi_sms_init(void)
 {
 	ofono_sms_driver_register(&driver);
 }
 =

-void isi_sms_exit()
+void isi_sms_exit(void)
 {
 	ofono_sms_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/ssn.c b/drivers/isimodem/ssn.c
index 747a894..068e5e8 100644
--- a/drivers/isimodem/ssn.c
+++ b/drivers/isimodem/ssn.c
@@ -84,12 +84,12 @@ static struct ofono_ssn_driver driver =3D {
 	.remove			=3D isi_ssn_remove
 };
 =

-void isi_ssn_init()
+void isi_ssn_init(void)
 {
 	ofono_ssn_driver_register(&driver);
 }
 =

-void isi_ssn_exit()
+void isi_ssn_exit(void)
 {
 	ofono_ssn_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index 355b6db..d649484 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -278,12 +278,12 @@ static struct ofono_ussd_driver driver =3D {
 	.cancel			=3D isi_cancel
 };
 =

-void isi_ussd_init()
+void isi_ussd_init(void)
 {
 	ofono_ussd_driver_register(&driver);
 }
 =

-void isi_ussd_exit()
+void isi_ussd_exit(void)
 {
 	ofono_ussd_driver_unregister(&driver);
 }
diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index c19e64d..8a52b9a 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -1328,12 +1328,12 @@ static struct ofono_voicecall_driver driver =3D {
 	.send_tones		=3D isi_send_tones,
 };
 =

-void isi_voicecall_init()
+void isi_voicecall_init(void)
 {
 	ofono_voicecall_driver_register(&driver);
 }
 =

-void isi_voicecall_exit()
+void isi_voicecall_exit(void)
 {
 	ofono_voicecall_driver_unregister(&driver);
 }
-- =

1.7.0.4


--===============6659323961593904542==--

