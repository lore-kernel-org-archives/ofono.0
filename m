Content-Type: multipart/mixed; boundary="===============9169431563662464827=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 02/12] Constify GDBus signal tables
Date: Sun, 20 May 2012 02:07:26 -0300
Message-ID: <1337490456-10941-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337490456-10941-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9169431563662464827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Henrique Dante de Almeida <hdante@profusion.mobi>

Constify signal tables with the following command:

    find . -name '*.[ch]' -exec \
             sed -i 's/\(GDBusSignalTable .* =3D\)/const \1/g' {} \;
---
 src/audio-settings.c     |    2 +-
 src/call-barring.c       |    2 +-
 src/call-forwarding.c    |    2 +-
 src/call-meter.c         |    2 +-
 src/call-settings.c      |    2 +-
 src/call-volume.c        |    2 +-
 src/cbs.c                |    2 +-
 src/cdma-connman.c       |    2 +-
 src/cdma-netreg.c        |    2 +-
 src/cdma-sms.c           |    2 +-
 src/cdma-voicecall.c     |    2 +-
 src/ctm.c                |    2 +-
 src/gprs.c               |    4 ++--
 src/handsfree.c          |    2 +-
 src/location-reporting.c |    2 +-
 src/manager.c            |    2 +-
 src/message-waiting.c    |    2 +-
 src/message.c            |    2 +-
 src/modem.c              |    2 +-
 src/network.c            |    4 ++--
 src/phonebook.c          |    2 +-
 src/radio-settings.c     |    2 +-
 src/sim.c                |    2 +-
 src/sms.c                |    2 +-
 src/stk.c                |    2 +-
 src/ussd.c               |    2 +-
 src/voicecall.c          |    4 ++--
 27 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/src/audio-settings.c b/src/audio-settings.c
index 6388c3e..0e52761 100644
--- a/src/audio-settings.c
+++ b/src/audio-settings.c
@@ -123,7 +123,7 @@ static const GDBusMethodTable audio_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable audio_signals[] =3D {
+static const GDBusSignalTable audio_signals[] =3D {
 	{ "PropertyChanged", "sv" },
 	{ }
 };
diff --git a/src/call-barring.c b/src/call-barring.c
index 952e4c2..6b9bf6e 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -982,7 +982,7 @@ static const GDBusMethodTable cb_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable cb_signals[] =3D {
+static const GDBusSignalTable cb_signals[] =3D {
 	{ "PropertyChanged",		"sv" },
 	{ }
 };
diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index c70d140..7a73ff1 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -891,7 +891,7 @@ static const GDBusMethodTable cf_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable cf_signals[] =3D {
+static const GDBusSignalTable cf_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/call-meter.c b/src/call-meter.c
index fd5edc2..67965a4 100644
--- a/src/call-meter.c
+++ b/src/call-meter.c
@@ -656,7 +656,7 @@ static const GDBusMethodTable cm_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable cm_signals[] =3D {
+static const GDBusSignalTable cm_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ "NearMaximumWarning",	"" },
 	{ }
diff --git a/src/call-settings.c b/src/call-settings.c
index 9d4ff7b..014deb8 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -1338,7 +1338,7 @@ static const GDBusMethodTable cs_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable cs_signals[] =3D {
+static const GDBusSignalTable cs_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/call-volume.c b/src/call-volume.c
index 81b7564..528e39c 100644
--- a/src/call-volume.c
+++ b/src/call-volume.c
@@ -308,7 +308,7 @@ static const GDBusMethodTable cv_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable cv_signals[] =3D {
+static const GDBusSignalTable cv_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/cbs.c b/src/cbs.c
index 1c20cc6..f81cfb7 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -547,7 +547,7 @@ static const GDBusMethodTable cbs_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable cbs_signals[] =3D {
+static const GDBusSignalTable cbs_signals[] =3D {
 	{ "PropertyChanged",	"sv"		},
 	{ "IncomingBroadcast",	"sq"		},
 	{ "EmergencyBroadcast", "sa{sv}"	},
diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 90652e7..92866ba 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -525,7 +525,7 @@ static const GDBusMethodTable cdma_connman_methods[] =
=3D {
 	{ }
 };
 =

-static GDBusSignalTable cdma_connman_signals[] =3D {
+static const GDBusSignalTable cdma_connman_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index e6074a8..7b63cd7 100644
--- a/src/cdma-netreg.c
+++ b/src/cdma-netreg.c
@@ -112,7 +112,7 @@ static const GDBusMethodTable cdma_netreg_manager_metho=
ds[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable cdma_netreg_manager_signals[] =3D {
+static const GDBusSignalTable cdma_netreg_manager_signals[] =3D {
 	{ }
 };
 =

diff --git a/src/cdma-sms.c b/src/cdma-sms.c
index a368124..bef214c 100644
--- a/src/cdma-sms.c
+++ b/src/cdma-sms.c
@@ -48,7 +48,7 @@ static const GDBusMethodTable cdma_sms_manager_methods[] =
=3D {
 	{ }
 };
 =

-static GDBusSignalTable cdma_sms_manager_signals[] =3D {
+static const GDBusSignalTable cdma_sms_manager_signals[] =3D {
 	{ "IncomingMessage",	"sa{sv}"	},
 	/* TODO */
 	{ }
diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
index 3d0c55e..3ff128c 100644
--- a/src/cdma-voicecall.c
+++ b/src/cdma-voicecall.c
@@ -421,7 +421,7 @@ static const GDBusMethodTable manager_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable manager_signals[] =3D {
+static const GDBusSignalTable manager_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ "DisconnectReason",	"s" },
 	{ }
diff --git a/src/ctm.c b/src/ctm.c
index 2ff1cca..88ff141 100644
--- a/src/ctm.c
+++ b/src/ctm.c
@@ -210,7 +210,7 @@ static const GDBusMethodTable ctm_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable ctm_signals[] =3D {
+static const GDBusSignalTable ctm_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/gprs.c b/src/gprs.c
index 887422a..83995f3 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1289,7 +1289,7 @@ static const GDBusMethodTable context_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable context_signals[] =3D {
+static const GDBusSignalTable context_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
@@ -2075,7 +2075,7 @@ static const GDBusMethodTable manager_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable manager_signals[] =3D {
+static const GDBusSignalTable manager_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ "ContextAdded",	"oa{sv}" },
 	{ "ContextRemoved",     "o" },
diff --git a/src/handsfree.c b/src/handsfree.c
index 2566dd8..a838952 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -279,7 +279,7 @@ static const GDBusMethodTable handsfree_methods[] =3D {
 	{ NULL, NULL, NULL, NULL }
 };
 =

-static GDBusSignalTable handsfree_signals[] =3D {
+static const GDBusSignalTable handsfree_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/location-reporting.c b/src/location-reporting.c
index d279814..6417330 100644
--- a/src/location-reporting.c
+++ b/src/location-reporting.c
@@ -248,7 +248,7 @@ static const GDBusMethodTable location_reporting_method=
s[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable location_reporting_signals[] =3D {
+static const GDBusSignalTable location_reporting_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/manager.c b/src/manager.c
index 783ea76..ac729dc 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -85,7 +85,7 @@ static const GDBusMethodTable manager_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable manager_signals[] =3D {
+static const GDBusSignalTable manager_signals[] =3D {
 	{ "ModemAdded",        "oa{sv}" },
 	{ "ModemRemoved",      "o" },
 	{ }
diff --git a/src/message-waiting.c b/src/message-waiting.c
index 7bd2576..19b995d 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -375,7 +375,7 @@ static const GDBusMethodTable message_waiting_methods[]=
 =3D {
 	{ }
 };
 =

-static GDBusSignalTable message_waiting_signals[] =3D {
+static const GDBusSignalTable message_waiting_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/message.c b/src/message.c
index e0e7280..a8be570 100644
--- a/src/message.c
+++ b/src/message.c
@@ -109,7 +109,7 @@ static const GDBusMethodTable message_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable message_signals[] =3D {
+static const GDBusSignalTable message_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/modem.c b/src/modem.c
index f9fd37a..f4278e9 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1130,7 +1130,7 @@ static const GDBusMethodTable modem_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable modem_signals[] =3D {
+static const GDBusSignalTable modem_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/network.c b/src/network.c
index 68749ba..7d28762 100644
--- a/src/network.c
+++ b/src/network.c
@@ -630,7 +630,7 @@ static const GDBusMethodTable network_operator_methods[=
] =3D {
 	{ }
 };
 =

-static GDBusSignalTable network_operator_signals[] =3D {
+static const GDBusSignalTable network_operator_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
@@ -1030,7 +1030,7 @@ static const GDBusMethodTable network_registration_me=
thods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable network_registration_signals[] =3D {
+static const GDBusSignalTable network_registration_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/phonebook.c b/src/phonebook.c
index 3563cee..16f1fb9 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -485,7 +485,7 @@ static const GDBusMethodTable phonebook_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable phonebook_signals[] =3D {
+static const GDBusSignalTable phonebook_signals[] =3D {
 	{ }
 };
 =

diff --git a/src/radio-settings.c b/src/radio-settings.c
index 132fd4a..4777b18 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -609,7 +609,7 @@ static const GDBusMethodTable radio_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable radio_signals[] =3D {
+static const GDBusSignalTable radio_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/sim.c b/src/sim.c
index b979ddd..6207607 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1086,7 +1086,7 @@ static const GDBusMethodTable sim_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable sim_signals[] =3D {
+static const GDBusSignalTable sim_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ }
 };
diff --git a/src/sms.c b/src/sms.c
index 1f64be9..428eb52 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1114,7 +1114,7 @@ static const GDBusMethodTable sms_manager_methods[] =
=3D {
 	{ }
 };
 =

-static GDBusSignalTable sms_manager_signals[] =3D {
+static const GDBusSignalTable sms_manager_signals[] =3D {
 	{ "PropertyChanged",	"sv"		},
 	{ "IncomingMessage",	"sa{sv}"	},
 	{ "ImmediateMessage",	"sa{sv}"	},
diff --git a/src/stk.c b/src/stk.c
index 61b29bb..f111f0d 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -827,7 +827,7 @@ static const GDBusMethodTable stk_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable stk_signals[] =3D {
+static const GDBusSignalTable stk_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 =

 	{ }
diff --git a/src/ussd.c b/src/ussd.c
index 25ef61f..92a7949 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -740,7 +740,7 @@ static const GDBusMethodTable ussd_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable ussd_signals[] =3D {
+static const GDBusSignalTable ussd_signals[] =3D {
 	{ "NotificationReceived",	"s" },
 	{ "RequestReceived",		"s" },
 	{ "PropertyChanged",		"sv" },
diff --git a/src/voicecall.c b/src/voicecall.c
index 73b84b9..36a795d 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -678,7 +678,7 @@ static const GDBusMethodTable voicecall_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable voicecall_signals[] =3D {
+static const GDBusSignalTable voicecall_signals[] =3D {
 	{ "PropertyChanged",	"sv" },
 	{ "DisconnectReason",	"s" },
 	{ }
@@ -2143,7 +2143,7 @@ static const GDBusMethodTable manager_methods[] =3D {
 	{ }
 };
 =

-static GDBusSignalTable manager_signals[] =3D {
+static const GDBusSignalTable manager_signals[] =3D {
 	{ "Forwarded",		"s" },
 	{ "BarringActive",	"s" },
 	{ "PropertyChanged",	"sv" },
-- =

1.7.10.2


--===============9169431563662464827==--

