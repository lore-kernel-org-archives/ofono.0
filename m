Content-Type: multipart/mixed; boundary="===============1472102530217465428=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 1/1] drivers: constify vtables
Date: Wed, 17 Oct 2018 15:36:10 +0200
Message-ID: <20181017133610.12217-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1472102530217465428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The driver vtables are read-only structures.  This patch declares them as
'const' allowing the compiler to (optionally) put them in the RELRO
section.  RELRO pages may be marked as read-only by the linker after
the relocations have been done ensuring that they aren't inadvertently
or maliciously altered at runtime.
---

I've had this patch sitting around in my tree for a couple of months.
Constification of the driver vtables is mostly for correctness and
doesn't provide any noticeable difference in performance.

I have another couple of patches that take care of plugins/ and core
ofono, but I thought I'd gauge the response on this first...

/Jonas


 drivers/atmodem/call-barring.c            | 2 +-
 drivers/atmodem/call-forwarding.c         | 2 +-
 drivers/atmodem/call-meter.c              | 2 +-
 drivers/atmodem/call-settings.c           | 2 +-
 drivers/atmodem/call-volume.c             | 2 +-
 drivers/atmodem/cbs.c                     | 2 +-
 drivers/atmodem/devinfo.c                 | 2 +-
 drivers/atmodem/gnss.c                    | 2 +-
 drivers/atmodem/gprs-context.c            | 2 +-
 drivers/atmodem/gprs.c                    | 2 +-
 drivers/atmodem/lte.c                     | 2 +-
 drivers/atmodem/network-registration.c    | 2 +-
 drivers/atmodem/phonebook.c               | 2 +-
 drivers/atmodem/sim.c                     | 4 ++--
 drivers/atmodem/sms.c                     | 2 +-
 drivers/atmodem/stk.c                     | 2 +-
 drivers/atmodem/ussd.c                    | 2 +-
 drivers/atmodem/voicecall.c               | 2 +-
 drivers/calypsomodem/stk.c                | 2 +-
 drivers/calypsomodem/voicecall.c          | 2 +-
 drivers/cdmamodem/connman.c               | 2 +-
 drivers/cdmamodem/devinfo.c               | 2 +-
 drivers/cdmamodem/voicecall.c             | 2 +-
 drivers/dunmodem/gprs.c                   | 2 +-
 drivers/dunmodem/network-registration.c   | 2 +-
 drivers/gemaltomodem/location-reporting.c | 2 +-
 drivers/hfpmodem/call-volume.c            | 2 +-
 drivers/hfpmodem/devinfo.c                | 2 +-
 drivers/hfpmodem/handsfree.c              | 2 +-
 drivers/hfpmodem/network-registration.c   | 2 +-
 drivers/hfpmodem/siri.c                   | 2 +-
 drivers/hfpmodem/voicecall.c              | 2 +-
 drivers/hsomodem/gprs-context.c           | 2 +-
 drivers/hsomodem/radio-settings.c         | 2 +-
 drivers/huaweimodem/audio-settings.c      | 2 +-
 drivers/huaweimodem/cdma-netreg.c         | 2 +-
 drivers/huaweimodem/gprs-context.c        | 2 +-
 drivers/huaweimodem/radio-settings.c      | 2 +-
 drivers/huaweimodem/ussd.c                | 2 +-
 drivers/huaweimodem/voicecall.c           | 2 +-
 drivers/iceramodem/gprs-context.c         | 2 +-
 drivers/iceramodem/radio-settings.c       | 2 +-
 drivers/ifxmodem/audio-settings.c         | 2 +-
 drivers/ifxmodem/ctm.c                    | 2 +-
 drivers/ifxmodem/gprs-context.c           | 2 +-
 drivers/ifxmodem/radio-settings.c         | 2 +-
 drivers/ifxmodem/stk.c                    | 2 +-
 drivers/ifxmodem/voicecall.c              | 2 +-
 drivers/isimodem/audio-settings.c         | 2 +-
 drivers/isimodem/call-barring.c           | 2 +-
 drivers/isimodem/call-forwarding.c        | 2 +-
 drivers/isimodem/call-meter.c             | 2 +-
 drivers/isimodem/call-settings.c          | 2 +-
 drivers/isimodem/cbs.c                    | 2 +-
 drivers/isimodem/devinfo.c                | 2 +-
 drivers/isimodem/gprs-context.c           | 2 +-
 drivers/isimodem/gprs.c                   | 2 +-
 drivers/isimodem/network-registration.c   | 2 +-
 drivers/isimodem/phonebook.c              | 2 +-
 drivers/isimodem/radio-settings.c         | 2 +-
 drivers/isimodem/sim.c                    | 2 +-
 drivers/isimodem/sms.c                    | 2 +-
 drivers/isimodem/uicc.c                   | 2 +-
 drivers/isimodem/ussd.c                   | 2 +-
 drivers/isimodem/voicecall.c              | 2 +-
 drivers/mbimmodem/devinfo.c               | 2 +-
 drivers/mbimmodem/gprs-context.c          | 2 +-
 drivers/mbimmodem/gprs.c                  | 2 +-
 drivers/mbimmodem/network-registration.c  | 2 +-
 drivers/mbimmodem/sim.c                   | 2 +-
 drivers/mbimmodem/sms.c                   | 2 +-
 drivers/mbmmodem/gprs-context.c           | 2 +-
 drivers/mbmmodem/location-reporting.c     | 2 +-
 drivers/mbmmodem/stk.c                    | 2 +-
 drivers/nwmodem/radio-settings.c          | 2 +-
 drivers/qmimodem/devinfo.c                | 2 +-
 drivers/qmimodem/gprs-context.c           | 2 +-
 drivers/qmimodem/gprs.c                   | 2 +-
 drivers/qmimodem/location-reporting.c     | 2 +-
 drivers/qmimodem/lte.c                    | 2 +-
 drivers/qmimodem/netmon.c                 | 2 +-
 drivers/qmimodem/network-registration.c   | 2 +-
 drivers/qmimodem/radio-settings.c         | 2 +-
 drivers/qmimodem/sim-legacy.c             | 2 +-
 drivers/qmimodem/sim.c                    | 2 +-
 drivers/qmimodem/sms.c                    | 2 +-
 drivers/qmimodem/ussd.c                   | 2 +-
 drivers/qmimodem/voicecall.c              | 2 +-
 drivers/rilmodem/call-barring.c           | 2 +-
 drivers/rilmodem/call-forwarding.c        | 2 +-
 drivers/rilmodem/call-settings.c          | 2 +-
 drivers/rilmodem/call-volume.c            | 2 +-
 drivers/rilmodem/cbs.c                    | 2 +-
 drivers/rilmodem/devinfo.c                | 2 +-
 drivers/rilmodem/gprs-context.c           | 2 +-
 drivers/rilmodem/gprs.c                   | 2 +-
 drivers/rilmodem/lte.c                    | 2 +-
 drivers/rilmodem/netmon.c                 | 2 +-
 drivers/rilmodem/network-registration.c   | 2 +-
 drivers/rilmodem/phonebook.c              | 2 +-
 drivers/rilmodem/radio-settings.c         | 2 +-
 drivers/rilmodem/sim.c                    | 2 +-
 drivers/rilmodem/sms.c                    | 2 +-
 drivers/rilmodem/stk.c                    | 2 +-
 drivers/rilmodem/ussd.c                   | 2 +-
 drivers/rilmodem/voicecall.c              | 2 +-
 drivers/speedupmodem/ussd.c               | 2 +-
 drivers/stemodem/gprs-context.c           | 2 +-
 drivers/stemodem/radio-settings.c         | 2 +-
 drivers/stemodem/voicecall.c              | 2 +-
 drivers/swmodem/gprs-context.c            | 2 +-
 drivers/telitmodem/gprs-context-ncm.c     | 2 +-
 drivers/telitmodem/location-reporting.c   | 2 +-
 drivers/ubloxmodem/gprs-context.c         | 2 +-
 drivers/ubloxmodem/lte.c                  | 2 +-
 drivers/ubloxmodem/netmon.c               | 2 +-
 drivers/xmm7modem/ims.c                   | 2 +-
 drivers/xmm7modem/netmon.c                | 2 +-
 drivers/xmm7modem/radio-settings.c        | 2 +-
 drivers/ztemodem/radio-settings.c         | 2 +-
 120 files changed, 121 insertions(+), 121 deletions(-)

diff --git a/drivers/atmodem/call-barring.c b/drivers/atmodem/call-barring.c
index ab34638a..bb9c60f2 100644
--- a/drivers/atmodem/call-barring.c
+++ b/drivers/atmodem/call-barring.c
@@ -211,7 +211,7 @@ static void at_call_barring_remove(struct ofono_call_ba=
rring *cb)
 	ofono_call_barring_set_data(cb, NULL);
 }
 =

-static struct ofono_call_barring_driver driver =3D {
+static const struct ofono_call_barring_driver driver =3D {
 	.name		=3D "atmodem",
 	.probe		=3D at_call_barring_probe,
 	.remove		=3D at_call_barring_remove,
diff --git a/drivers/atmodem/call-forwarding.c b/drivers/atmodem/call-forwa=
rding.c
index 764deb92..b44c7ebe 100644
--- a/drivers/atmodem/call-forwarding.c
+++ b/drivers/atmodem/call-forwarding.c
@@ -263,7 +263,7 @@ static void at_ccfc_remove(struct ofono_call_forwarding=
 *cf)
 	ofono_call_forwarding_set_data(cf, NULL);
 }
 =

-static struct ofono_call_forwarding_driver driver =3D {
+static const struct ofono_call_forwarding_driver driver =3D {
 	.name		=3D "atmodem",
 	.probe		=3D at_ccfc_probe,
 	.remove		=3D at_ccfc_remove,
diff --git a/drivers/atmodem/call-meter.c b/drivers/atmodem/call-meter.c
index ef43ea28..3766f459 100644
--- a/drivers/atmodem/call-meter.c
+++ b/drivers/atmodem/call-meter.c
@@ -330,7 +330,7 @@ static void at_caoc_remove(struct ofono_call_meter *cm)
 	ofono_call_meter_set_data(cm, NULL);
 }
 =

-static struct ofono_call_meter_driver driver =3D {
+static const struct ofono_call_meter_driver driver =3D {
 	.name =3D "atmodem",
 	.probe =3D at_caoc_probe,
 	.remove =3D at_caoc_remove,
diff --git a/drivers/atmodem/call-settings.c b/drivers/atmodem/call-setting=
s.c
index 994f528e..67c8c9d5 100644
--- a/drivers/atmodem/call-settings.c
+++ b/drivers/atmodem/call-settings.c
@@ -397,7 +397,7 @@ static void at_call_settings_remove(struct ofono_call_s=
ettings *cs)
 	ofono_call_settings_set_data(cs, NULL);
 }
 =

-static struct ofono_call_settings_driver driver =3D {
+static const struct ofono_call_settings_driver driver =3D {
 	.name =3D "atmodem",
 	.probe =3D at_call_settings_probe,
 	.remove =3D at_call_settings_remove,
diff --git a/drivers/atmodem/call-volume.c b/drivers/atmodem/call-volume.c
index af3af319..001e5a9a 100644
--- a/drivers/atmodem/call-volume.c
+++ b/drivers/atmodem/call-volume.c
@@ -206,7 +206,7 @@ static void at_call_volume_remove(struct ofono_call_vol=
ume *cv)
 	g_free(cvd);
 }
 =

-static struct ofono_call_volume_driver driver =3D {
+static const struct ofono_call_volume_driver driver =3D {
 	.name =3D "atmodem",
 	.probe =3D at_call_volume_probe,
 	.remove =3D at_call_volume_remove,
diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index 2423ec1f..c69f0bd0 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -303,7 +303,7 @@ static void at_cbs_remove(struct ofono_cbs *cbs)
 	g_free(data);
 }
 =

-static struct ofono_cbs_driver driver =3D {
+static const struct ofono_cbs_driver driver =3D {
 	.name =3D "atmodem",
 	.probe =3D at_cbs_probe,
 	.remove =3D at_cbs_remove,
diff --git a/drivers/atmodem/devinfo.c b/drivers/atmodem/devinfo.c
index c886835a..ff7386cd 100644
--- a/drivers/atmodem/devinfo.c
+++ b/drivers/atmodem/devinfo.c
@@ -153,7 +153,7 @@ static void at_devinfo_remove(struct ofono_devinfo *inf=
o)
 	g_at_chat_unref(chat);
 }
 =

-static struct ofono_devinfo_driver driver =3D {
+static const struct ofono_devinfo_driver driver =3D {
 	.name			=3D "atmodem",
 	.probe			=3D at_devinfo_probe,
 	.remove			=3D at_devinfo_remove,
diff --git a/drivers/atmodem/gnss.c b/drivers/atmodem/gnss.c
index 447911bd..80c96f31 100644
--- a/drivers/atmodem/gnss.c
+++ b/drivers/atmodem/gnss.c
@@ -262,7 +262,7 @@ static void at_gnss_remove(struct ofono_gnss *gnss)
 	g_free(gd);
 }
 =

-static struct ofono_gnss_driver driver =3D {
+static const struct ofono_gnss_driver driver =3D {
 	.name			=3D "atmodem",
 	.probe			=3D at_gnss_probe,
 	.remove			=3D at_gnss_remove,
diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index c8841cf9..93894efd 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -493,7 +493,7 @@ static void at_gprs_context_remove(struct ofono_gprs_co=
ntext *gc)
 	g_free(gcd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "atmodem",
 	.probe			=3D at_gprs_context_probe,
 	.remove			=3D at_gprs_context_remove,
diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 11e51906..de7c7864 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -641,7 +641,7 @@ static void at_gprs_remove(struct ofono_gprs *gprs)
 	g_free(gd);
 }
 =

-static struct ofono_gprs_driver driver =3D {
+static const struct ofono_gprs_driver driver =3D {
 	.name			=3D "atmodem",
 	.probe			=3D at_gprs_probe,
 	.remove			=3D at_gprs_remove,
diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
index 5a249a4a..c4866623 100644
--- a/drivers/atmodem/lte.c
+++ b/drivers/atmodem/lte.c
@@ -123,7 +123,7 @@ static void at_lte_remove(struct ofono_lte *lte)
 	g_free(ldd);
 }
 =

-static struct ofono_lte_driver driver =3D {
+static const struct ofono_lte_driver driver =3D {
 	.name				=3D "atmodem",
 	.probe				=3D at_lte_probe,
 	.remove				=3D at_lte_remove,
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index e8e4278d..55960c03 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -2154,7 +2154,7 @@ static void at_netreg_remove(struct ofono_netreg *net=
reg)
 	g_free(nd);
 }
 =

-static struct ofono_netreg_driver driver =3D {
+static const struct ofono_netreg_driver driver =3D {
 	.name				=3D "atmodem",
 	.probe				=3D at_netreg_probe,
 	.remove				=3D at_netreg_remove,
diff --git a/drivers/atmodem/phonebook.c b/drivers/atmodem/phonebook.c
index 183eed15..57b23b02 100644
--- a/drivers/atmodem/phonebook.c
+++ b/drivers/atmodem/phonebook.c
@@ -592,7 +592,7 @@ static void at_phonebook_remove(struct ofono_phonebook =
*pb)
 	g_free(pbd);
 }
 =

-static struct ofono_phonebook_driver driver =3D {
+static const struct ofono_phonebook_driver driver =3D {
 	.name		=3D "atmodem",
 	.probe		=3D at_phonebook_probe,
 	.remove		=3D at_phonebook_remove,
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 8f47f4ac..51f84818 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1958,7 +1958,7 @@ static void at_sim_remove(struct ofono_sim *sim)
 	g_free(sd);
 }
 =

-static struct ofono_sim_driver driver =3D {
+static const struct ofono_sim_driver driver =3D {
 	.name			=3D "atmodem",
 	.probe			=3D at_sim_probe,
 	.remove			=3D at_sim_remove,
@@ -1986,7 +1986,7 @@ static struct ofono_sim_driver driver =3D {
 	.logical_access		=3D at_logical_access
 };
 =

-static struct ofono_sim_driver driver_noef =3D {
+static const struct ofono_sim_driver driver_noef =3D {
 	.name			=3D "atmodem-noef",
 	.probe			=3D at_sim_probe,
 	.remove			=3D at_sim_remove,
diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index c9c2378f..7638885e 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -1319,7 +1319,7 @@ static void at_sms_remove(struct ofono_sms *sms)
 	ofono_sms_set_data(sms, NULL);
 }
 =

-static struct ofono_sms_driver driver =3D {
+static const struct ofono_sms_driver driver =3D {
 	.name		=3D "atmodem",
 	.probe		=3D at_sms_probe,
 	.remove		=3D at_sms_remove,
diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index 08fb8b12..f0dc5c03 100644
--- a/drivers/atmodem/stk.c
+++ b/drivers/atmodem/stk.c
@@ -222,7 +222,7 @@ static void at_stk_remove(struct ofono_stk *stk)
 	g_free(sd);
 }
 =

-static struct ofono_stk_driver driver =3D {
+static const struct ofono_stk_driver driver =3D {
 	.name			=3D "atmodem",
 	.probe			=3D at_stk_probe,
 	.remove			=3D at_stk_remove,
diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index cc17d0a9..f1907a00 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -326,7 +326,7 @@ static void at_ussd_remove(struct ofono_ussd *ussd)
 	g_free(data);
 }
 =

-static struct ofono_ussd_driver driver =3D {
+static const struct ofono_ussd_driver driver =3D {
 	.name		=3D "atmodem",
 	.probe		=3D at_ussd_probe,
 	.remove		=3D at_ussd_remove,
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 03b69971..d55cf008 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -1154,7 +1154,7 @@ static void at_voicecall_remove(struct ofono_voicecal=
l *vc)
 	g_free(vd);
 }
 =

-static struct ofono_voicecall_driver driver =3D {
+static const struct ofono_voicecall_driver driver =3D {
 	.name			=3D "atmodem",
 	.probe			=3D at_voicecall_probe,
 	.remove			=3D at_voicecall_remove,
diff --git a/drivers/calypsomodem/stk.c b/drivers/calypsomodem/stk.c
index 1eeb3a2d..35297b43 100644
--- a/drivers/calypsomodem/stk.c
+++ b/drivers/calypsomodem/stk.c
@@ -291,7 +291,7 @@ static void calypso_stk_remove(struct ofono_stk *stk)
 	g_free(sd);
 }
 =

-static struct ofono_stk_driver driver =3D {
+static const struct ofono_stk_driver driver =3D {
 	.name			=3D "calypsomodem",
 	.probe			=3D calypso_stk_probe,
 	.remove			=3D calypso_stk_remove,
diff --git a/drivers/calypsomodem/voicecall.c b/drivers/calypsomodem/voicec=
all.c
index 62f973fe..1fc95e2d 100644
--- a/drivers/calypsomodem/voicecall.c
+++ b/drivers/calypsomodem/voicecall.c
@@ -401,7 +401,7 @@ static void calypso_voicecall_remove(struct ofono_voice=
call *vc)
 	g_free(vd);
 }
 =

-static struct ofono_voicecall_driver driver =3D {
+static const struct ofono_voicecall_driver driver =3D {
 	.name			=3D "calypsomodem",
 	.probe			=3D calypso_voicecall_probe,
 	.remove			=3D calypso_voicecall_remove,
diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index ddb586a2..77eeea0e 100644
--- a/drivers/cdmamodem/connman.c
+++ b/drivers/cdmamodem/connman.c
@@ -322,7 +322,7 @@ static void cdma_connman_remove(struct ofono_cdma_connm=
an *cm)
 	g_free(cd);
 }
 =

-static struct ofono_cdma_connman_driver driver =3D {
+static const struct ofono_cdma_connman_driver driver =3D {
 	.name			=3D "cdmamodem",
 	.probe			=3D cdma_connman_probe,
 	.remove			=3D cdma_connman_remove,
diff --git a/drivers/cdmamodem/devinfo.c b/drivers/cdmamodem/devinfo.c
index f8818ae6..2f4963d9 100644
--- a/drivers/cdmamodem/devinfo.c
+++ b/drivers/cdmamodem/devinfo.c
@@ -153,7 +153,7 @@ static void cdma_devinfo_remove(struct ofono_devinfo *i=
nfo)
 	ofono_devinfo_set_data(info, NULL);
 }
 =

-static struct ofono_devinfo_driver driver =3D {
+static const struct ofono_devinfo_driver driver =3D {
 	.name			=3D "cdmamodem",
 	.probe			=3D cdma_devinfo_probe,
 	.remove			=3D cdma_devinfo_remove,
diff --git a/drivers/cdmamodem/voicecall.c b/drivers/cdmamodem/voicecall.c
index 0f1359d1..c9660641 100644
--- a/drivers/cdmamodem/voicecall.c
+++ b/drivers/cdmamodem/voicecall.c
@@ -142,7 +142,7 @@ static void cdma_voicecall_remove(struct ofono_cdma_voi=
cecall *vc)
 	g_free(vd);
 }
 =

-static struct ofono_cdma_voicecall_driver driver =3D {
+static const struct ofono_cdma_voicecall_driver driver =3D {
 	.name			=3D "cdmamodem",
 	.probe			=3D cdma_voicecall_probe,
 	.remove			=3D cdma_voicecall_remove,
diff --git a/drivers/dunmodem/gprs.c b/drivers/dunmodem/gprs.c
index edfe803f..751d640b 100644
--- a/drivers/dunmodem/gprs.c
+++ b/drivers/dunmodem/gprs.c
@@ -73,7 +73,7 @@ static void dun_gprs_attached_status(struct ofono_gprs *g=
prs,
 	CALLBACK_WITH_SUCCESS(cb, 1, data);
 }
 =

-static struct ofono_gprs_driver driver =3D {
+static const struct ofono_gprs_driver driver =3D {
 	.name			=3D "dunmodem",
 	.probe			=3D dun_gprs_probe,
 	.remove			=3D dun_gprs_remove,
diff --git a/drivers/dunmodem/network-registration.c b/drivers/dunmodem/net=
work-registration.c
index df24b5cb..71cbe356 100644
--- a/drivers/dunmodem/network-registration.c
+++ b/drivers/dunmodem/network-registration.c
@@ -107,7 +107,7 @@ static void dun_netreg_remove(struct ofono_netreg *netr=
eg)
 	g_free(nd);
 }
 =

-static struct ofono_netreg_driver driver =3D {
+static const struct ofono_netreg_driver driver =3D {
 	.name			=3D "dunmodem",
 	.probe			=3D dun_netreg_probe,
 	.remove			=3D dun_netreg_remove,
diff --git a/drivers/gemaltomodem/location-reporting.c b/drivers/gemaltomod=
em/location-reporting.c
index 66296cb4..cb9a1fe7 100644
--- a/drivers/gemaltomodem/location-reporting.c
+++ b/drivers/gemaltomodem/location-reporting.c
@@ -216,7 +216,7 @@ static void gemalto_location_reporting_remove(struct of=
ono_location_reporting *l
 	g_free(gd);
 }
 =

-static struct ofono_location_reporting_driver driver =3D {
+static const struct ofono_location_reporting_driver driver =3D {
 	.name			=3D "gemaltomodem",
 	.type			=3D OFONO_LOCATION_REPORTING_TYPE_NMEA,
 	.probe			=3D gemalto_location_reporting_probe,
diff --git a/drivers/hfpmodem/call-volume.c b/drivers/hfpmodem/call-volume.c
index 1077ffcd..8134eace 100644
--- a/drivers/hfpmodem/call-volume.c
+++ b/drivers/hfpmodem/call-volume.c
@@ -217,7 +217,7 @@ static void hfp_call_volume_remove(struct ofono_call_vo=
lume *cv)
 	g_free(vd);
 }
 =

-static struct ofono_call_volume_driver driver =3D {
+static const struct ofono_call_volume_driver driver =3D {
 	.name			=3D "hfpmodem",
 	.probe			=3D hfp_call_volume_probe,
 	.remove			=3D hfp_call_volume_remove,
diff --git a/drivers/hfpmodem/devinfo.c b/drivers/hfpmodem/devinfo.c
index 04929c92..9629160b 100644
--- a/drivers/hfpmodem/devinfo.c
+++ b/drivers/hfpmodem/devinfo.c
@@ -91,7 +91,7 @@ static void hfp_devinfo_remove(struct ofono_devinfo *info)
 	g_free(dd);
 }
 =

-static struct ofono_devinfo_driver driver =3D {
+static const struct ofono_devinfo_driver driver =3D {
 	.name			=3D "hfpmodem",
 	.probe			=3D hfp_devinfo_probe,
 	.remove			=3D hfp_devinfo_remove,
diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
index 1be18ca5..95d9ee62 100644
--- a/drivers/hfpmodem/handsfree.c
+++ b/drivers/hfpmodem/handsfree.c
@@ -410,7 +410,7 @@ static void hfp_hf_indicator(struct ofono_handsfree *hf,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static struct ofono_handsfree_driver driver =3D {
+static const struct ofono_handsfree_driver driver =3D {
 	.name			=3D "hfpmodem",
 	.probe			=3D hfp_handsfree_probe,
 	.remove			=3D hfp_handsfree_remove,
diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
index f8be64a9..65a68d01 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -342,7 +342,7 @@ static void hfp_netreg_remove(struct ofono_netreg *netr=
eg)
 	g_free(nd);
 }
 =

-static struct ofono_netreg_driver driver =3D {
+static const struct ofono_netreg_driver driver =3D {
 	.name				=3D "hfpmodem",
 	.probe				=3D hfp_netreg_probe,
 	.remove				=3D hfp_netreg_remove,
diff --git a/drivers/hfpmodem/siri.c b/drivers/hfpmodem/siri.c
index 08ffefa7..d18df149 100644
--- a/drivers/hfpmodem/siri.c
+++ b/drivers/hfpmodem/siri.c
@@ -195,7 +195,7 @@ static void hfp_siri_set_eyes_free_mode(struct ofono_si=
ri *siri,
 	CALLBACK_WITH_FAILURE(cb, NULL);
 }
 =

-static struct ofono_siri_driver driver =3D {
+static const struct ofono_siri_driver driver =3D {
 	.name =3D "hfpmodem",
 	.probe =3D hfp_siri_probe,
 	.remove =3D hfp_siri_remove,
diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index c93b10c3..69667f14 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -1302,7 +1302,7 @@ static void hfp_voicecall_remove(struct ofono_voiceca=
ll *vc)
 	g_free(vd);
 }
 =

-static struct ofono_voicecall_driver driver =3D {
+static const struct ofono_voicecall_driver driver =3D {
 	.name			=3D "hfpmodem",
 	.probe			=3D hfp_voicecall_probe,
 	.remove			=3D hfp_voicecall_remove,
diff --git a/drivers/hsomodem/gprs-context.c b/drivers/hsomodem/gprs-contex=
t.c
index 062975ad..340092fa 100644
--- a/drivers/hsomodem/gprs-context.c
+++ b/drivers/hsomodem/gprs-context.c
@@ -378,7 +378,7 @@ static void hso_gprs_context_remove(struct ofono_gprs_c=
ontext *gc)
 	g_free(gcd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "hsomodem",
 	.probe			=3D hso_gprs_context_probe,
 	.remove			=3D hso_gprs_context_remove,
diff --git a/drivers/hsomodem/radio-settings.c b/drivers/hsomodem/radio-set=
tings.c
index 8c0b88bc..0a5e48ff 100644
--- a/drivers/hsomodem/radio-settings.c
+++ b/drivers/hsomodem/radio-settings.c
@@ -198,7 +198,7 @@ static void hso_radio_settings_remove(struct ofono_radi=
o_settings *rs)
 	g_free(rsd);
 }
 =

-static struct ofono_radio_settings_driver driver =3D {
+static const struct ofono_radio_settings_driver driver =3D {
 	.name			=3D "hsomodem",
 	.probe			=3D hso_radio_settings_probe,
 	.remove			=3D hso_radio_settings_remove,
diff --git a/drivers/huaweimodem/audio-settings.c b/drivers/huaweimodem/aud=
io-settings.c
index eb9813a9..df40aa84 100644
--- a/drivers/huaweimodem/audio-settings.c
+++ b/drivers/huaweimodem/audio-settings.c
@@ -112,7 +112,7 @@ static void huawei_audio_settings_remove(struct ofono_a=
udio_settings *as)
 	g_free(asd);
 }
 =

-static struct ofono_audio_settings_driver driver =3D {
+static const struct ofono_audio_settings_driver driver =3D {
 	.name		=3D "huaweimodem",
 	.probe		=3D huawei_audio_settings_probe,
 	.remove		=3D huawei_audio_settings_remove,
diff --git a/drivers/huaweimodem/cdma-netreg.c b/drivers/huaweimodem/cdma-n=
etreg.c
index 2ed344df..d3e28c82 100644
--- a/drivers/huaweimodem/cdma-netreg.c
+++ b/drivers/huaweimodem/cdma-netreg.c
@@ -209,7 +209,7 @@ static void huawei_cdma_netreg_remove(struct ofono_cdma=
_netreg *netreg)
 	g_at_chat_unref(chat);
 }
 =

-static struct ofono_cdma_netreg_driver driver =3D {
+static const struct ofono_cdma_netreg_driver driver =3D {
 	.name	=3D "huaweimodem",
 	.probe	=3D huawei_cdma_netreg_probe,
 	.remove	=3D huawei_cdma_netreg_remove,
diff --git a/drivers/huaweimodem/gprs-context.c b/drivers/huaweimodem/gprs-=
context.c
index 721563de..cae401c8 100644
--- a/drivers/huaweimodem/gprs-context.c
+++ b/drivers/huaweimodem/gprs-context.c
@@ -338,7 +338,7 @@ static void huawei_gprs_context_remove(struct ofono_gpr=
s_context *gc)
 	g_free(gcd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "huaweimodem",
 	.probe			=3D huawei_gprs_context_probe,
 	.remove			=3D huawei_gprs_context_remove,
diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index 06109cd3..40431d38 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -568,7 +568,7 @@ static void huawei_radio_settings_remove(struct ofono_r=
adio_settings *rs)
 	g_free(rsd);
 }
 =

-static struct ofono_radio_settings_driver driver =3D {
+static const struct ofono_radio_settings_driver driver =3D {
 	.name			=3D "huaweimodem",
 	.probe			=3D huawei_radio_settings_probe,
 	.remove			=3D huawei_radio_settings_remove,
diff --git a/drivers/huaweimodem/ussd.c b/drivers/huaweimodem/ussd.c
index 002337a8..fbed3cd0 100644
--- a/drivers/huaweimodem/ussd.c
+++ b/drivers/huaweimodem/ussd.c
@@ -204,7 +204,7 @@ static void huawei_ussd_remove(struct ofono_ussd *ussd)
 	g_free(data);
 }
 =

-static struct ofono_ussd_driver driver =3D {
+static const struct ofono_ussd_driver driver =3D {
 	.name		=3D "huaweimodem",
 	.probe		=3D huawei_ussd_probe,
 	.remove		=3D huawei_ussd_remove,
diff --git a/drivers/huaweimodem/voicecall.c b/drivers/huaweimodem/voicecal=
l.c
index e2ff63f7..3044f602 100644
--- a/drivers/huaweimodem/voicecall.c
+++ b/drivers/huaweimodem/voicecall.c
@@ -496,7 +496,7 @@ static void huawei_voicecall_remove(struct ofono_voicec=
all *vc)
 	g_free(vd);
 }
 =

-static struct ofono_voicecall_driver driver =3D {
+static const struct ofono_voicecall_driver driver =3D {
 	.name			=3D "huaweimodem",
 	.probe			=3D huawei_voicecall_probe,
 	.remove			=3D huawei_voicecall_remove,
diff --git a/drivers/iceramodem/gprs-context.c b/drivers/iceramodem/gprs-co=
ntext.c
index 5e305f72..395a9dc5 100644
--- a/drivers/iceramodem/gprs-context.c
+++ b/drivers/iceramodem/gprs-context.c
@@ -402,7 +402,7 @@ static void icera_gprs_context_remove(struct ofono_gprs=
_context *gc)
 	g_free(gcd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "iceramodem",
 	.probe			=3D icera_gprs_context_probe,
 	.remove			=3D icera_gprs_context_remove,
diff --git a/drivers/iceramodem/radio-settings.c b/drivers/iceramodem/radio=
-settings.c
index cc9d5fa0..defa4330 100644
--- a/drivers/iceramodem/radio-settings.c
+++ b/drivers/iceramodem/radio-settings.c
@@ -211,7 +211,7 @@ static void icera_radio_settings_remove(struct ofono_ra=
dio_settings *rs)
 	g_free(rsd);
 }
 =

-static struct ofono_radio_settings_driver driver =3D {
+static const struct ofono_radio_settings_driver driver =3D {
 	.name			=3D "iceramodem",
 	.probe			=3D icera_radio_settings_probe,
 	.remove			=3D icera_radio_settings_remove,
diff --git a/drivers/ifxmodem/audio-settings.c b/drivers/ifxmodem/audio-set=
tings.c
index 45aeef46..f3dfd18d 100644
--- a/drivers/ifxmodem/audio-settings.c
+++ b/drivers/ifxmodem/audio-settings.c
@@ -381,7 +381,7 @@ static void ifx_audio_settings_remove(struct ofono_audi=
o_settings *as)
 	g_free(asd);
 }
 =

-static struct ofono_audio_settings_driver driver =3D {
+static const struct ofono_audio_settings_driver driver =3D {
 	.name		=3D "ifxmodem",
 	.probe		=3D ifx_audio_settings_probe,
 	.remove		=3D ifx_audio_settings_remove,
diff --git a/drivers/ifxmodem/ctm.c b/drivers/ifxmodem/ctm.c
index ec4b7a79..4f5e2249 100644
--- a/drivers/ifxmodem/ctm.c
+++ b/drivers/ifxmodem/ctm.c
@@ -166,7 +166,7 @@ static void ifx_ctm_remove(struct ofono_ctm *ctm)
 	g_free(ctmd);
 }
 =

-static struct ofono_ctm_driver driver =3D {
+static const struct ofono_ctm_driver driver =3D {
 	.name           =3D "ifxmodem",
 	.probe          =3D ifx_ctm_probe,
 	.remove         =3D ifx_ctm_remove,
diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 855e935e..5d1da2d5 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -660,7 +660,7 @@ static void ifx_gprs_context_remove(struct ofono_gprs_c=
ontext *gc)
 	g_free(gcd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "ifxmodem",
 	.probe			=3D ifx_gprs_context_probe,
 	.remove			=3D ifx_gprs_context_remove,
diff --git a/drivers/ifxmodem/radio-settings.c b/drivers/ifxmodem/radio-set=
tings.c
index d5fa3f63..c132ba70 100644
--- a/drivers/ifxmodem/radio-settings.c
+++ b/drivers/ifxmodem/radio-settings.c
@@ -200,7 +200,7 @@ static void ifx_radio_settings_remove(struct ofono_radi=
o_settings *rs)
 	g_free(rsd);
 }
 =

-static struct ofono_radio_settings_driver driver =3D {
+static const struct ofono_radio_settings_driver driver =3D {
 	.name			=3D "ifxmodem",
 	.probe			=3D ifx_radio_settings_probe,
 	.remove			=3D ifx_radio_settings_remove,
diff --git a/drivers/ifxmodem/stk.c b/drivers/ifxmodem/stk.c
index ea00bf92..613a8481 100644
--- a/drivers/ifxmodem/stk.c
+++ b/drivers/ifxmodem/stk.c
@@ -306,7 +306,7 @@ static void ifx_stk_remove(struct ofono_stk *stk)
 	g_free(sd);
 }
 =

-static struct ofono_stk_driver driver =3D {
+static const struct ofono_stk_driver driver =3D {
 	.name			=3D "ifxmodem",
 	.probe			=3D ifx_stk_probe,
 	.remove			=3D ifx_stk_remove,
diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index 51e3cc46..ae694e3a 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -1018,7 +1018,7 @@ static void ifx_voicecall_remove(struct ofono_voiceca=
ll *vc)
 	g_free(vd);
 }
 =

-static struct ofono_voicecall_driver driver =3D {
+static const struct ofono_voicecall_driver driver =3D {
 	.name			=3D "ifxmodem",
 	.probe			=3D ifx_voicecall_probe,
 	.remove			=3D ifx_voicecall_remove,
diff --git a/drivers/isimodem/audio-settings.c b/drivers/isimodem/audio-set=
tings.c
index b517925c..dddef18f 100644
--- a/drivers/isimodem/audio-settings.c
+++ b/drivers/isimodem/audio-settings.c
@@ -116,7 +116,7 @@ static void isi_audio_settings_remove(struct ofono_audi=
o_settings *as)
 	g_free(asd);
 }
 =

-static struct ofono_audio_settings_driver driver =3D {
+static const struct ofono_audio_settings_driver driver =3D {
 	.name		=3D "isimodem",
 	.probe		=3D isi_audio_settings_probe,
 	.remove		=3D isi_audio_settings_remove,
diff --git a/drivers/isimodem/call-barring.c b/drivers/isimodem/call-barrin=
g.c
index ab8b5fc9..8a614ec5 100644
--- a/drivers/isimodem/call-barring.c
+++ b/drivers/isimodem/call-barring.c
@@ -428,7 +428,7 @@ static void isi_call_barring_remove(struct ofono_call_b=
arring *barr)
 	g_free(data);
 }
 =

-static struct ofono_call_barring_driver driver =3D {
+static const struct ofono_call_barring_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_call_barring_probe,
 	.remove			=3D isi_call_barring_remove,
diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-for=
warding.c
index 366aa11e..e46f2e09 100644
--- a/drivers/isimodem/call-forwarding.c
+++ b/drivers/isimodem/call-forwarding.c
@@ -456,7 +456,7 @@ static void isi_call_forwarding_remove(struct ofono_cal=
l_forwarding *cf)
 	g_free(data);
 }
 =

-static struct ofono_call_forwarding_driver driver =3D {
+static const struct ofono_call_forwarding_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_call_forwarding_probe,
 	.remove			=3D isi_call_forwarding_remove,
diff --git a/drivers/isimodem/call-meter.c b/drivers/isimodem/call-meter.c
index 8196b737..3f186906 100644
--- a/drivers/isimodem/call-meter.c
+++ b/drivers/isimodem/call-meter.c
@@ -117,7 +117,7 @@ static void isi_call_meter_remove(struct ofono_call_met=
er *cm)
 	g_free(data);
 }
 =

-static struct ofono_call_meter_driver driver =3D {
+static const struct ofono_call_meter_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_call_meter_probe,
 	.remove			=3D isi_call_meter_remove,
diff --git a/drivers/isimodem/call-settings.c b/drivers/isimodem/call-setti=
ngs.c
index 231e3186..b388ecaf 100644
--- a/drivers/isimodem/call-settings.c
+++ b/drivers/isimodem/call-settings.c
@@ -404,7 +404,7 @@ static void isi_call_settings_remove(struct ofono_call_=
settings *cs)
 	g_free(data);
 }
 =

-static struct ofono_call_settings_driver driver =3D {
+static const struct ofono_call_settings_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_call_settings_probe,
 	.remove			=3D isi_call_settings_remove,
diff --git a/drivers/isimodem/cbs.c b/drivers/isimodem/cbs.c
index 6b4ab169..4cf937df 100644
--- a/drivers/isimodem/cbs.c
+++ b/drivers/isimodem/cbs.c
@@ -226,7 +226,7 @@ static void isi_cbs_remove(struct ofono_cbs *cbs)
 	g_free(cd);
 }
 =

-static struct ofono_cbs_driver driver =3D {
+static const struct ofono_cbs_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_cbs_probe,
 	.remove			=3D isi_cbs_remove,
diff --git a/drivers/isimodem/devinfo.c b/drivers/isimodem/devinfo.c
index 65dd98cd..a91b85b4 100644
--- a/drivers/isimodem/devinfo.c
+++ b/drivers/isimodem/devinfo.c
@@ -251,7 +251,7 @@ static void isi_devinfo_remove(struct ofono_devinfo *in=
fo)
 	g_free(data);
 }
 =

-static struct ofono_devinfo_driver driver =3D {
+static const struct ofono_devinfo_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_devinfo_probe,
 	.remove			=3D isi_devinfo_remove,
diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index c89ccbcd..9ccc7f15 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -662,7 +662,7 @@ static void isi_gprs_context_remove(struct ofono_gprs_c=
ontext *gc)
 	g_free(cd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_gprs_context_probe,
 	.remove			=3D isi_gprs_context_remove,
diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index da33472b..e3e26752 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -489,7 +489,7 @@ error:
 	g_free(cbd);
 }
 =

-static struct ofono_gprs_driver driver =3D {
+static const struct ofono_gprs_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_gprs_probe,
 	.remove			=3D isi_gprs_remove,
diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/net=
work-registration.c
index b1e5f25e..7a0fcff2 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -1164,7 +1164,7 @@ static void isi_netreg_remove(struct ofono_netreg *ne=
treg)
 	g_free(data);
 }
 =

-static struct ofono_netreg_driver isimodem =3D {
+static const struct ofono_netreg_driver isimodem =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_netreg_probe,
 	.remove			=3D isi_netreg_remove,
diff --git a/drivers/isimodem/phonebook.c b/drivers/isimodem/phonebook.c
index 47b34a85..36106fe2 100644
--- a/drivers/isimodem/phonebook.c
+++ b/drivers/isimodem/phonebook.c
@@ -340,7 +340,7 @@ static void isi_phonebook_remove(struct ofono_phonebook=
 *pb)
 	g_free(data);
 }
 =

-static struct ofono_phonebook_driver driver =3D {
+static const struct ofono_phonebook_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_phonebook_probe,
 	.remove			=3D isi_phonebook_remove,
diff --git a/drivers/isimodem/radio-settings.c b/drivers/isimodem/radio-set=
tings.c
index 051cf1b0..fa533005 100644
--- a/drivers/isimodem/radio-settings.c
+++ b/drivers/isimodem/radio-settings.c
@@ -364,7 +364,7 @@ static void isi_radio_settings_remove(struct ofono_radi=
o_settings *rs)
 	g_free(rd);
 }
 =

-static struct ofono_radio_settings_driver driver =3D {
+static const struct ofono_radio_settings_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_radio_settings_probe,
 	.remove			=3D isi_radio_settings_remove,
diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index 1dbffb97..07f2e027 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -968,7 +968,7 @@ static void isi_sim_remove(struct ofono_sim *sim)
 	g_free(data);
 }
 =

-static struct ofono_sim_driver driver =3D {
+static const struct ofono_sim_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_sim_probe,
 	.remove			=3D isi_sim_remove,
diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index 85523232..e3965413 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -1120,7 +1120,7 @@ static void isi_sms_remove(struct ofono_sms *sms)
 	g_free(sd);
 }
 =

-static struct ofono_sms_driver driver =3D {
+static const struct ofono_sms_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_sms_probe,
 	.remove			=3D isi_sms_remove,
diff --git a/drivers/isimodem/uicc.c b/drivers/isimodem/uicc.c
index e7457447..c85c6058 100644
--- a/drivers/isimodem/uicc.c
+++ b/drivers/isimodem/uicc.c
@@ -1650,7 +1650,7 @@ static void uicc_sim_remove(struct ofono_sim *sim)
 	g_free(data);
 }
 =

-static struct ofono_sim_driver driver =3D {
+static const struct ofono_sim_driver driver =3D {
 	.name			=3D "wgmodem2.5",
 	.probe			=3D uicc_sim_probe,
 	.remove			=3D uicc_sim_remove,
diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index 1a93b92a..2ed8fde8 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -275,7 +275,7 @@ static void isi_ussd_remove(struct ofono_ussd *ussd)
 	g_free(data);
 }
 =

-static struct ofono_ussd_driver driver =3D {
+static const struct ofono_ussd_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_ussd_probe,
 	.remove			=3D isi_ussd_remove,
diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 2110eb26..9a63f100 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -1934,7 +1934,7 @@ static void isi_remove(struct ofono_voicecall *call)
 	g_free(data);
 }
 =

-static struct ofono_voicecall_driver driver =3D {
+static const struct ofono_voicecall_driver driver =3D {
 	.name			=3D "isimodem",
 	.probe			=3D isi_probe,
 	.remove			=3D isi_remove,
diff --git a/drivers/mbimmodem/devinfo.c b/drivers/mbimmodem/devinfo.c
index 2be70321..8ccabbb9 100644
--- a/drivers/mbimmodem/devinfo.c
+++ b/drivers/mbimmodem/devinfo.c
@@ -88,7 +88,7 @@ static void mbim_devinfo_remove(struct ofono_devinfo *inf=
o)
 	l_free(dd);
 }
 =

-static struct ofono_devinfo_driver driver =3D {
+static const struct ofono_devinfo_driver driver =3D {
 	.name			=3D "mbim",
 	.probe			=3D mbim_devinfo_probe,
 	.remove			=3D mbim_devinfo_remove,
diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-cont=
ext.c
index ac5c1ed8..38c2b1b7 100644
--- a/drivers/mbimmodem/gprs-context.c
+++ b/drivers/mbimmodem/gprs-context.c
@@ -453,7 +453,7 @@ static void mbim_gprs_context_remove(struct ofono_gprs_=
context *gc)
 	l_free(gcd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "mbim",
 	.probe			=3D mbim_gprs_context_probe,
 	.remove			=3D mbim_gprs_context_remove,
diff --git a/drivers/mbimmodem/gprs.c b/drivers/mbimmodem/gprs.c
index d8aa5829..120d4759 100644
--- a/drivers/mbimmodem/gprs.c
+++ b/drivers/mbimmodem/gprs.c
@@ -279,7 +279,7 @@ static void mbim_gprs_remove(struct ofono_gprs *gprs)
 	l_free(gd);
 }
 =

-static struct ofono_gprs_driver driver =3D {
+static const struct ofono_gprs_driver driver =3D {
 	.name			=3D "mbim",
 	.probe			=3D mbim_gprs_probe,
 	.remove			=3D mbim_gprs_remove,
diff --git a/drivers/mbimmodem/network-registration.c b/drivers/mbimmodem/n=
etwork-registration.c
index fb400e73..bdec7d78 100644
--- a/drivers/mbimmodem/network-registration.c
+++ b/drivers/mbimmodem/network-registration.c
@@ -394,7 +394,7 @@ static void mbim_netreg_remove(struct ofono_netreg *net=
reg)
 	l_free(nd);
 }
 =

-static struct ofono_netreg_driver driver =3D {
+static const struct ofono_netreg_driver driver =3D {
 	.name				=3D "mbim",
 	.probe				=3D mbim_netreg_probe,
 	.remove				=3D mbim_netreg_remove,
diff --git a/drivers/mbimmodem/sim.c b/drivers/mbimmodem/sim.c
index 9797f2da..90d4bea8 100644
--- a/drivers/mbimmodem/sim.c
+++ b/drivers/mbimmodem/sim.c
@@ -509,7 +509,7 @@ static void mbim_sim_remove(struct ofono_sim *sim)
 	l_free(sd);
 }
 =

-static struct ofono_sim_driver driver =3D {
+static const struct ofono_sim_driver driver =3D {
 	.name			=3D "mbim",
 	.probe			=3D mbim_sim_probe,
 	.remove			=3D mbim_sim_remove,
diff --git a/drivers/mbimmodem/sms.c b/drivers/mbimmodem/sms.c
index e1d73e17..881a14cc 100644
--- a/drivers/mbimmodem/sms.c
+++ b/drivers/mbimmodem/sms.c
@@ -495,7 +495,7 @@ static void mbim_sms_remove(struct ofono_sms *sms)
 	l_free(sd);
 }
 =

-static struct ofono_sms_driver driver =3D {
+static const struct ofono_sms_driver driver =3D {
 	.name		=3D "mbim",
 	.probe		=3D mbim_sms_probe,
 	.remove		=3D mbim_sms_remove,
diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-contex=
t.c
index 6f2ffa34..c48e7260 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -510,7 +510,7 @@ static void mbm_gprs_context_remove(struct ofono_gprs_c=
ontext *gc)
 	g_free(gcd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "mbmmodem",
 	.probe			=3D mbm_gprs_context_probe,
 	.remove			=3D mbm_gprs_context_remove,
diff --git a/drivers/mbmmodem/location-reporting.c b/drivers/mbmmodem/locat=
ion-reporting.c
index 7270253f..794a2dfc 100644
--- a/drivers/mbmmodem/location-reporting.c
+++ b/drivers/mbmmodem/location-reporting.c
@@ -230,7 +230,7 @@ static void mbm_location_reporting_remove(struct ofono_=
location_reporting *lr)
 	g_free(gd);
 }
 =

-static struct ofono_location_reporting_driver driver =3D {
+static const struct ofono_location_reporting_driver driver =3D {
 	.name			=3D "mbmmodem",
 	.type			=3D OFONO_LOCATION_REPORTING_TYPE_NMEA,
 	.probe			=3D mbm_location_reporting_probe,
diff --git a/drivers/mbmmodem/stk.c b/drivers/mbmmodem/stk.c
index 89b246cd..16f57ff9 100644
--- a/drivers/mbmmodem/stk.c
+++ b/drivers/mbmmodem/stk.c
@@ -261,7 +261,7 @@ static void mbm_stk_remove(struct ofono_stk *stk)
 	g_free(sd);
 }
 =

-static struct ofono_stk_driver driver =3D {
+static const struct ofono_stk_driver driver =3D {
 	.name			=3D "mbmmodem",
 	.probe			=3D mbm_stk_probe,
 	.remove			=3D mbm_stk_remove,
diff --git a/drivers/nwmodem/radio-settings.c b/drivers/nwmodem/radio-setti=
ngs.c
index be06d952..13330e0b 100644
--- a/drivers/nwmodem/radio-settings.c
+++ b/drivers/nwmodem/radio-settings.c
@@ -194,7 +194,7 @@ static void nw_radio_settings_remove(struct ofono_radio=
_settings *rs)
 	g_free(rsd);
 }
 =

-static struct ofono_radio_settings_driver driver =3D {
+static const struct ofono_radio_settings_driver driver =3D {
 	.name			=3D "nwmodem",
 	.probe			=3D nw_radio_settings_probe,
 	.remove			=3D nw_radio_settings_remove,
diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index f5028657..af976b77 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -208,7 +208,7 @@ static void qmi_devinfo_remove(struct ofono_devinfo *de=
vinfo)
 	g_free(data);
 }
 =

-static struct ofono_devinfo_driver driver =3D {
+static const struct ofono_devinfo_driver driver =3D {
 	.name			=3D "qmimodem",
 	.probe			=3D qmi_devinfo_probe,
 	.remove			=3D qmi_devinfo_remove,
diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index 985bdd64..dcdf8ae1 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -491,7 +491,7 @@ static void qmi_gprs_context_remove(struct ofono_gprs_c=
ontext *gc)
 	g_free(data);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "qmimodem",
 	.probe			=3D qmi_gprs_context_probe,
 	.remove			=3D qmi_gprs_context_remove,
diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index db07f310..07adbe9a 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -408,7 +408,7 @@ static void qmi_gprs_remove(struct ofono_gprs *gprs)
 	g_free(data);
 }
 =

-static struct ofono_gprs_driver driver =3D {
+static const struct ofono_gprs_driver driver =3D {
 	.name			=3D "qmimodem",
 	.probe			=3D qmi_gprs_probe,
 	.remove			=3D qmi_gprs_remove,
diff --git a/drivers/qmimodem/location-reporting.c b/drivers/qmimodem/locat=
ion-reporting.c
index e4ce2331..90d57db7 100644
--- a/drivers/qmimodem/location-reporting.c
+++ b/drivers/qmimodem/location-reporting.c
@@ -278,7 +278,7 @@ static void qmi_location_reporting_remove(struct ofono_=
location_reporting *lr)
 	g_free(data);
 }
 =

-static struct ofono_location_reporting_driver driver =3D {
+static const struct ofono_location_reporting_driver driver =3D {
 	.name		=3D "qmimodem",
 	.type		=3D OFONO_LOCATION_REPORTING_TYPE_NMEA,
 	.probe		=3D qmi_location_reporting_probe,
diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index c67f0887..e0333ecf 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -246,7 +246,7 @@ static void qmimodem_lte_remove(struct ofono_lte *lte)
 	g_free(ldd);
 }
 =

-static struct ofono_lte_driver driver =3D {
+static const struct ofono_lte_driver driver =3D {
 	.name				=3D "qmimodem",
 	.probe				=3D qmimodem_lte_probe,
 	.remove				=3D qmimodem_lte_remove,
diff --git a/drivers/qmimodem/netmon.c b/drivers/qmimodem/netmon.c
index 58edb676..14a55632 100644
--- a/drivers/qmimodem/netmon.c
+++ b/drivers/qmimodem/netmon.c
@@ -267,7 +267,7 @@ static void qmi_netmon_remove(struct ofono_netmon *netm=
on)
 	g_free(nmd);
 }
 =

-static struct ofono_netmon_driver driver =3D {
+static const struct ofono_netmon_driver driver =3D {
 	.name			=3D "qmimodem",
 	.probe			=3D qmi_netmon_probe,
 	.remove			=3D qmi_netmon_remove,
diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index a1e3ebcc..1fccb573 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -637,7 +637,7 @@ static void qmi_netreg_remove(struct ofono_netreg *netr=
eg)
 	g_free(data);
 }
 =

-static struct ofono_netreg_driver driver =3D {
+static const struct ofono_netreg_driver driver =3D {
 	.name			=3D "qmimodem",
 	.probe			=3D qmi_netreg_probe,
 	.remove			=3D qmi_netreg_remove,
diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-set=
tings.c
index 36ad25cf..d6f911a1 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -287,7 +287,7 @@ static void qmi_radio_settings_remove(struct ofono_radi=
o_settings *rs)
 	g_free(data);
 }
 =

-static struct ofono_radio_settings_driver driver =3D {
+static const struct ofono_radio_settings_driver driver =3D {
 	.name		=3D "qmimodem",
 	.probe		=3D qmi_radio_settings_probe,
 	.remove		=3D qmi_radio_settings_remove,
diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index 318b1aed..af857693 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -379,7 +379,7 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 	g_free(data);
 }
 =

-static struct ofono_sim_driver driver =3D {
+static const struct ofono_sim_driver driver =3D {
 	.name			=3D "qmimodem-legacy",
 	.probe			=3D qmi_sim_probe,
 	.remove			=3D qmi_sim_remove,
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 1ac50686..8edabb80 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -911,7 +911,7 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 	g_free(data);
 }
 =

-static struct ofono_sim_driver driver =3D {
+static const struct ofono_sim_driver driver =3D {
 	.name			=3D "qmimodem",
 	.probe			=3D qmi_sim_probe,
 	.remove			=3D qmi_sim_remove,
diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 7e6baec5..1e930396 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -571,7 +571,7 @@ static void qmi_sms_remove(struct ofono_sms *sms)
 	g_free(data);
 }
 =

-static struct ofono_sms_driver driver =3D {
+static const struct ofono_sms_driver driver =3D {
 	.name		=3D "qmimodem",
 	.probe		=3D qmi_sms_probe,
 	.remove		=3D qmi_sms_remove,
diff --git a/drivers/qmimodem/ussd.c b/drivers/qmimodem/ussd.c
index bb9fc522..1e613032 100644
--- a/drivers/qmimodem/ussd.c
+++ b/drivers/qmimodem/ussd.c
@@ -269,7 +269,7 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static struct ofono_ussd_driver driver =3D {
+static const struct ofono_ussd_driver driver =3D {
 	.name		=3D "qmimodem",
 	.probe		=3D qmi_ussd_probe,
 	.remove		=3D qmi_ussd_remove,
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 29166b08..52dd69b1 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -95,7 +95,7 @@ static void qmi_voicecall_remove(struct ofono_voicecall *=
vc)
 	g_free(data);
 }
 =

-static struct ofono_voicecall_driver driver =3D {
+static const struct ofono_voicecall_driver driver =3D {
 	.name		=3D "qmimodem",
 	.probe		=3D qmi_voicecall_probe,
 	.remove		=3D qmi_voicecall_remove,
diff --git a/drivers/rilmodem/call-barring.c b/drivers/rilmodem/call-barrin=
g.c
index eb6e7c40..9cf3d537 100644
--- a/drivers/rilmodem/call-barring.c
+++ b/drivers/rilmodem/call-barring.c
@@ -270,7 +270,7 @@ static void ril_call_barring_remove(struct ofono_call_b=
arring *cb)
 	g_free(data);
 }
 =

-static struct ofono_call_barring_driver driver =3D {
+static const struct ofono_call_barring_driver driver =3D {
 	.name			=3D "rilmodem",
 	.probe			=3D ril_call_barring_probe,
 	.remove			=3D ril_call_barring_remove,
diff --git a/drivers/rilmodem/call-forwarding.c b/drivers/rilmodem/call-for=
warding.c
index b186a720..eb65c23a 100644
--- a/drivers/rilmodem/call-forwarding.c
+++ b/drivers/rilmodem/call-forwarding.c
@@ -376,7 +376,7 @@ static void ril_call_forwarding_remove(struct ofono_cal=
l_forwarding *cf)
 	g_free(data);
 }
 =

-static struct ofono_call_forwarding_driver driver =3D {
+static const struct ofono_call_forwarding_driver driver =3D {
 	.name			=3D RILMODEM,
 	.probe			=3D ril_call_forwarding_probe,
 	.remove			=3D ril_call_forwarding_remove,
diff --git a/drivers/rilmodem/call-settings.c b/drivers/rilmodem/call-setti=
ngs.c
index 6aaa3984..2324f572 100644
--- a/drivers/rilmodem/call-settings.c
+++ b/drivers/rilmodem/call-settings.c
@@ -319,7 +319,7 @@ static void ril_call_settings_remove(struct ofono_call_=
settings *cs)
 	g_free(sd);
 }
 =

-static struct ofono_call_settings_driver driver =3D {
+static const struct ofono_call_settings_driver driver =3D {
 	.name			=3D RILMODEM,
 	.probe			=3D ril_call_settings_probe,
 	.remove			=3D ril_call_settings_remove,
diff --git a/drivers/rilmodem/call-volume.c b/drivers/rilmodem/call-volume.c
index e9cb9cfe..58f43b04 100644
--- a/drivers/rilmodem/call-volume.c
+++ b/drivers/rilmodem/call-volume.c
@@ -169,7 +169,7 @@ static void ril_call_volume_remove(struct ofono_call_vo=
lume *cv)
 	g_free(cvd);
 }
 =

-static struct ofono_call_volume_driver driver =3D {
+static const struct ofono_call_volume_driver driver =3D {
 	.name =3D RILMODEM,
 	.probe =3D ril_call_volume_probe,
 	.remove =3D ril_call_volume_remove,
diff --git a/drivers/rilmodem/cbs.c b/drivers/rilmodem/cbs.c
index 14d6bba3..288706cf 100644
--- a/drivers/rilmodem/cbs.c
+++ b/drivers/rilmodem/cbs.c
@@ -193,7 +193,7 @@ static void ril_cbs_remove(struct ofono_cbs *cbs)
 	g_free(data);
 }
 =

-static struct ofono_cbs_driver driver =3D {
+static const struct ofono_cbs_driver driver =3D {
 	.name =3D RILMODEM,
 	.probe =3D ril_cbs_probe,
 	.remove =3D ril_cbs_remove,
diff --git a/drivers/rilmodem/devinfo.c b/drivers/rilmodem/devinfo.c
index 84c7847d..1ac038aa 100644
--- a/drivers/rilmodem/devinfo.c
+++ b/drivers/rilmodem/devinfo.c
@@ -211,7 +211,7 @@ static void ril_devinfo_remove(struct ofono_devinfo *in=
fo)
 	g_ril_unref(ril);
 }
 =

-static struct ofono_devinfo_driver driver =3D {
+static const struct ofono_devinfo_driver driver =3D {
 	.name			=3D RILMODEM,
 	.probe			=3D ril_devinfo_probe,
 	.remove			=3D ril_devinfo_remove,
diff --git a/drivers/rilmodem/gprs-context.c b/drivers/rilmodem/gprs-contex=
t.c
index ebc51a06..ce046d6f 100644
--- a/drivers/rilmodem/gprs-context.c
+++ b/drivers/rilmodem/gprs-context.c
@@ -856,7 +856,7 @@ static void ril_gprs_context_remove(struct ofono_gprs_c=
ontext *gc)
 	g_free(gcd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D RILMODEM,
 	.probe			=3D ril_gprs_context_probe,
 	.remove			=3D ril_gprs_context_remove,
diff --git a/drivers/rilmodem/gprs.c b/drivers/rilmodem/gprs.c
index 668b3b47..01fc50ce 100644
--- a/drivers/rilmodem/gprs.c
+++ b/drivers/rilmodem/gprs.c
@@ -514,7 +514,7 @@ static void ril_gprs_remove(struct ofono_gprs *gprs)
 	g_free(gd);
 }
 =

-static struct ofono_gprs_driver driver =3D {
+static const struct ofono_gprs_driver driver =3D {
 	.name			=3D RILMODEM,
 	.probe			=3D ril_gprs_probe,
 	.remove			=3D ril_gprs_remove,
diff --git a/drivers/rilmodem/lte.c b/drivers/rilmodem/lte.c
index fb84d3d5..61718961 100644
--- a/drivers/rilmodem/lte.c
+++ b/drivers/rilmodem/lte.c
@@ -140,7 +140,7 @@ static void ril_lte_remove(struct ofono_lte *lte)
 	g_free(ld);
 }
 =

-static struct ofono_lte_driver driver =3D {
+static const struct ofono_lte_driver driver =3D {
 	.name				=3D RILMODEM,
 	.probe				=3D ril_lte_probe,
 	.remove				=3D ril_lte_remove,
diff --git a/drivers/rilmodem/netmon.c b/drivers/rilmodem/netmon.c
index 9c633f0f..7dd3a562 100644
--- a/drivers/rilmodem/netmon.c
+++ b/drivers/rilmodem/netmon.c
@@ -338,7 +338,7 @@ static void ril_netmon_periodic_update(struct ofono_net=
mon *netmon,
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

-static struct ofono_netmon_driver driver =3D {
+static const struct ofono_netmon_driver driver =3D {
 	.name			=3D RILMODEM,
 	.probe			=3D ril_netmon_probe,
 	.remove			=3D ril_netmon_remove,
diff --git a/drivers/rilmodem/network-registration.c b/drivers/rilmodem/net=
work-registration.c
index bfca92a5..99c80bc6 100644
--- a/drivers/rilmodem/network-registration.c
+++ b/drivers/rilmodem/network-registration.c
@@ -833,7 +833,7 @@ static void ril_netreg_remove(struct ofono_netreg *netr=
eg)
 	g_free(nd);
 }
 =

-static struct ofono_netreg_driver driver =3D {
+static const struct ofono_netreg_driver driver =3D {
 	.name				=3D RILMODEM,
 	.probe				=3D ril_netreg_probe,
 	.remove				=3D ril_netreg_remove,
diff --git a/drivers/rilmodem/phonebook.c b/drivers/rilmodem/phonebook.c
index d82bb648..ca8e777d 100644
--- a/drivers/rilmodem/phonebook.c
+++ b/drivers/rilmodem/phonebook.c
@@ -1036,7 +1036,7 @@ static void ril_phonebook_remove(struct ofono_phonebo=
ok *pb)
 	g_free(pbd);
 }
 =

-static struct ofono_phonebook_driver driver =3D {
+static const struct ofono_phonebook_driver driver =3D {
 	.name		=3D RILMODEM,
 	.probe		=3D ril_phonebook_probe,
 	.remove		=3D ril_phonebook_remove,
diff --git a/drivers/rilmodem/radio-settings.c b/drivers/rilmodem/radio-set=
tings.c
index cd7bb502..a2e25e0b 100644
--- a/drivers/rilmodem/radio-settings.c
+++ b/drivers/rilmodem/radio-settings.c
@@ -452,7 +452,7 @@ static void ril_radio_settings_remove(struct ofono_radi=
o_settings *rs)
 	g_free(rd);
 }
 =

-static struct ofono_radio_settings_driver driver =3D {
+static const struct ofono_radio_settings_driver driver =3D {
 	.name			=3D RILMODEM,
 	.probe			=3D ril_radio_settings_probe,
 	.remove			=3D ril_radio_settings_remove,
diff --git a/drivers/rilmodem/sim.c b/drivers/rilmodem/sim.c
index fd686f58..ce7176e2 100644
--- a/drivers/rilmodem/sim.c
+++ b/drivers/rilmodem/sim.c
@@ -1482,7 +1482,7 @@ static void ril_sim_remove(struct ofono_sim *sim)
 	g_free(sd);
 }
 =

-static struct ofono_sim_driver driver =3D {
+static const struct ofono_sim_driver driver =3D {
 	.name			=3D RILMODEM,
 	.probe			=3D ril_sim_probe,
 	.remove			=3D ril_sim_remove,
diff --git a/drivers/rilmodem/sms.c b/drivers/rilmodem/sms.c
index 8c16fab1..c4f4a3b1 100644
--- a/drivers/rilmodem/sms.c
+++ b/drivers/rilmodem/sms.c
@@ -502,7 +502,7 @@ static void ril_sms_remove(struct ofono_sms *sms)
 	ofono_sms_set_data(sms, NULL);
 }
 =

-static struct ofono_sms_driver driver =3D {
+static const struct ofono_sms_driver driver =3D {
 	.name		=3D RILMODEM,
 	.probe		=3D ril_sms_probe,
 	.sca_query	=3D ril_csca_query,
diff --git a/drivers/rilmodem/stk.c b/drivers/rilmodem/stk.c
index 013401e3..bfcbf1a0 100644
--- a/drivers/rilmodem/stk.c
+++ b/drivers/rilmodem/stk.c
@@ -237,7 +237,7 @@ static void ril_stk_remove(struct ofono_stk *stk)
 	g_free(data);
 }
 =

-static struct ofono_stk_driver driver =3D {
+static const struct ofono_stk_driver driver =3D {
 	.name =3D RILMODEM,
 	.probe =3D ril_stk_probe,
 	.remove =3D ril_stk_remove,
diff --git a/drivers/rilmodem/ussd.c b/drivers/rilmodem/ussd.c
index 099fe546..7364ea4f 100644
--- a/drivers/rilmodem/ussd.c
+++ b/drivers/rilmodem/ussd.c
@@ -241,7 +241,7 @@ static void ril_ussd_remove(struct ofono_ussd *ussd)
 	g_free(ud);
 }
 =

-static struct ofono_ussd_driver driver =3D {
+static const struct ofono_ussd_driver driver =3D {
 	.name		=3D RILMODEM,
 	.probe		=3D ril_ussd_probe,
 	.remove		=3D ril_ussd_remove,
diff --git a/drivers/rilmodem/voicecall.c b/drivers/rilmodem/voicecall.c
index 010f7d4e..13dc5071 100644
--- a/drivers/rilmodem/voicecall.c
+++ b/drivers/rilmodem/voicecall.c
@@ -855,7 +855,7 @@ void ril_voicecall_remove(struct ofono_voicecall *vc)
 	g_free(vd);
 }
 =

-static struct ofono_voicecall_driver driver =3D {
+static const struct ofono_voicecall_driver driver =3D {
 	.name			=3D RILMODEM,
 	.probe			=3D ril_voicecall_probe,
 	.remove			=3D ril_voicecall_remove,
diff --git a/drivers/speedupmodem/ussd.c b/drivers/speedupmodem/ussd.c
index c27a7ffa..315a0eac 100644
--- a/drivers/speedupmodem/ussd.c
+++ b/drivers/speedupmodem/ussd.c
@@ -204,7 +204,7 @@ static void speedup_ussd_remove(struct ofono_ussd *ussd)
 	g_free(data);
 }
 =

-static struct ofono_ussd_driver driver =3D {
+static const struct ofono_ussd_driver driver =3D {
 	.name		=3D "speedupmodem",
 	.probe		=3D speedup_ussd_probe,
 	.remove		=3D speedup_ussd_remove,
diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index ee82919b..56b34388 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -426,7 +426,7 @@ out:
 	g_free(gcd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "stemodem",
 	.probe			=3D ste_gprs_context_probe,
 	.remove			=3D ste_gprs_context_remove,
diff --git a/drivers/stemodem/radio-settings.c b/drivers/stemodem/radio-set=
tings.c
index 5b007129..5e726cd5 100644
--- a/drivers/stemodem/radio-settings.c
+++ b/drivers/stemodem/radio-settings.c
@@ -222,7 +222,7 @@ static void ste_radio_settings_remove(struct ofono_radi=
o_settings *rs)
 	g_free(rsd);
 }
 =

-static struct ofono_radio_settings_driver driver =3D {
+static const struct ofono_radio_settings_driver driver =3D {
 	.name		=3D "stemodem",
 	.probe		=3D ste_radio_settings_probe,
 	.remove		=3D ste_radio_settings_remove,
diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 4f684391..3fd3c1f4 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -581,7 +581,7 @@ static void ste_voicecall_remove(struct ofono_voicecall=
 *vc)
 	g_free(vd);
 }
 =

-static struct ofono_voicecall_driver driver =3D {
+static const struct ofono_voicecall_driver driver =3D {
 	.name			=3D "stemodem",
 	.probe			=3D ste_voicecall_probe,
 	.remove			=3D ste_voicecall_remove,
diff --git a/drivers/swmodem/gprs-context.c b/drivers/swmodem/gprs-context.c
index 622b07b1..5ac9a975 100644
--- a/drivers/swmodem/gprs-context.c
+++ b/drivers/swmodem/gprs-context.c
@@ -244,7 +244,7 @@ static void sw_gprs_context_remove(struct ofono_gprs_co=
ntext *gc)
 	g_free(gcd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "swmodem",
 	.probe			=3D sw_gprs_context_probe,
 	.remove			=3D sw_gprs_context_remove,
diff --git a/drivers/telitmodem/gprs-context-ncm.c b/drivers/telitmodem/gpr=
s-context-ncm.c
index ca63f760..c4e60e21 100644
--- a/drivers/telitmodem/gprs-context-ncm.c
+++ b/drivers/telitmodem/gprs-context-ncm.c
@@ -468,7 +468,7 @@ static void telitncm_gprs_context_remove(struct ofono_g=
prs_context *gc)
 	g_free(gcd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "telitncmmodem",
 	.probe			=3D telitncm_gprs_context_probe,
 	.remove			=3D telitncm_gprs_context_remove,
diff --git a/drivers/telitmodem/location-reporting.c b/drivers/telitmodem/l=
ocation-reporting.c
index 944af69c..245c29c2 100644
--- a/drivers/telitmodem/location-reporting.c
+++ b/drivers/telitmodem/location-reporting.c
@@ -294,7 +294,7 @@ static void telit_location_reporting_remove(struct ofon=
o_location_reporting *lr)
 	g_free(gd);
 }
 =

-static struct ofono_location_reporting_driver driver =3D {
+static const struct ofono_location_reporting_driver driver =3D {
 	.name			=3D "telitmodem",
 	.type			=3D OFONO_LOCATION_REPORTING_TYPE_NMEA,
 	.probe			=3D telit_location_reporting_probe,
diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index 485148a4..1b4e17f5 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -496,7 +496,7 @@ static void ublox_gprs_context_remove(struct ofono_gprs=
_context *gc)
 	g_free(gcd);
 }
 =

-static struct ofono_gprs_context_driver driver =3D {
+static const struct ofono_gprs_context_driver driver =3D {
 	.name			=3D "ubloxmodem",
 	.probe			=3D ublox_gprs_context_probe,
 	.remove			=3D ublox_gprs_context_remove,
diff --git a/drivers/ubloxmodem/lte.c b/drivers/ubloxmodem/lte.c
index a0e9582f..34397dfe 100644
--- a/drivers/ubloxmodem/lte.c
+++ b/drivers/ubloxmodem/lte.c
@@ -124,7 +124,7 @@ static void ublox_lte_remove(struct ofono_lte *lte)
 	g_free(ldd);
 }
 =

-static struct ofono_lte_driver driver =3D {
+static const struct ofono_lte_driver driver =3D {
 	.name				=3D UBLOXMODEM,
 	.probe				=3D ublox_lte_probe,
 	.remove				=3D ublox_lte_remove,
diff --git a/drivers/ubloxmodem/netmon.c b/drivers/ubloxmodem/netmon.c
index edf3058c..ef042ed4 100644
--- a/drivers/ubloxmodem/netmon.c
+++ b/drivers/ubloxmodem/netmon.c
@@ -335,7 +335,7 @@ static void ublox_netmon_remove(struct ofono_netmon *ne=
tmon)
 	g_free(nmd);
 }
 =

-static struct ofono_netmon_driver driver =3D {
+static const struct ofono_netmon_driver driver =3D {
 	.name			=3D UBLOXMODEM,
 	.probe			=3D ublox_netmon_probe,
 	.remove			=3D ublox_netmon_remove,
diff --git a/drivers/xmm7modem/ims.c b/drivers/xmm7modem/ims.c
index ee6495f6..3cf9e626 100644
--- a/drivers/xmm7modem/ims.c
+++ b/drivers/xmm7modem/ims.c
@@ -234,7 +234,7 @@ static void xmm_ims_remove(struct ofono_ims *ims)
 	g_free(idd);
 }
 =

-static struct ofono_ims_driver driver =3D {
+static const struct ofono_ims_driver driver =3D {
 	.name				=3D "xmm7modem",
 	.probe				=3D xmm_ims_probe,
 	.remove				=3D xmm_ims_remove,
diff --git a/drivers/xmm7modem/netmon.c b/drivers/xmm7modem/netmon.c
index 3b84d534..ba70e2bd 100644
--- a/drivers/xmm7modem/netmon.c
+++ b/drivers/xmm7modem/netmon.c
@@ -245,7 +245,7 @@ static void xmm7modem_netmon_remove(struct ofono_netmon=
 *netmon)
 	g_free(nmd);
 }
 =

-static struct ofono_netmon_driver driver =3D {
+static const struct ofono_netmon_driver driver =3D {
 	.name			=3D XMM7MODEM,
 	.probe			=3D xmm7modem_netmon_probe,
 	.remove			=3D xmm7modem_netmon_remove,
diff --git a/drivers/xmm7modem/radio-settings.c b/drivers/xmm7modem/radio-s=
ettings.c
index e068bb4c..f1eb1aa9 100644
--- a/drivers/xmm7modem/radio-settings.c
+++ b/drivers/xmm7modem/radio-settings.c
@@ -213,7 +213,7 @@ static void xmm_radio_settings_remove(struct ofono_radi=
o_settings *rs)
 	g_free(rsd);
 }
 =

-static struct ofono_radio_settings_driver driver =3D {
+static const struct ofono_radio_settings_driver driver =3D {
 	.name			=3D "xmm7modem",
 	.probe			=3D xmm_radio_settings_probe,
 	.remove			=3D xmm_radio_settings_remove,
diff --git a/drivers/ztemodem/radio-settings.c b/drivers/ztemodem/radio-set=
tings.c
index c01acbe5..6a2b1fc1 100644
--- a/drivers/ztemodem/radio-settings.c
+++ b/drivers/ztemodem/radio-settings.c
@@ -194,7 +194,7 @@ static void zte_radio_settings_remove(struct ofono_radi=
o_settings *rs)
 	g_free(rsd);
 }
 =

-static struct ofono_radio_settings_driver driver =3D {
+static const struct ofono_radio_settings_driver driver =3D {
 	.name			=3D "ztemodem",
 	.probe			=3D zte_radio_settings_probe,
 	.remove			=3D zte_radio_settings_remove,
-- =

2.17.1


--===============1472102530217465428==--

