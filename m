Content-Type: multipart/mixed; boundary="===============1041102494449022956=="
MIME-Version: 1.0
From: Wei, Jun <jun.wei@intel.com>
Subject: [PATCH v2 2/4] ifxmodem: Enable support of Neighbor cell info
Date: Sun, 09 Jan 2011 22:05:50 +0800
Message-ID: <1A42CE6F5F474C41B63392A5F80372B231DCEE44@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1294490448-26563-1-git-send-email-jun.wei@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1041102494449022956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Wei, Jun =

Sent: Saturday, January 08, 2011 8:41 PM
To: ofono(a)ofono.org
Cc: Wei, Jun
Subject: [PATCH v2 2/4] ifxmodem: Enable support of Neighbor cell info

From: Jun Wei <jun.wei@intel.com>

---
 drivers/ifxmodem/ifxmodem.c |    2 ++
 drivers/ifxmodem/ifxmodem.h |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/ifxmodem/ifxmodem.c b/drivers/ifxmodem/ifxmodem.c
index 8a9ac8f..1f38d33 100644
--- a/drivers/ifxmodem/ifxmodem.c
+++ b/drivers/ifxmodem/ifxmodem.c
@@ -39,6 +39,7 @@ static int ifxmodem_init(void)
 	ifx_radio_settings_init();
 	ifx_gprs_context_init();
 	ifx_stk_init();
+	ifx_cell_info_init();
 =

 	return 0;
 }
@@ -50,6 +51,7 @@ static void ifxmodem_exit(void)
 	ifx_radio_settings_exit();
 	ifx_audio_settings_exit();
 	ifx_voicecall_exit();
+	ifx_cell_info_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(ifxmodem, "Infineon modem driver", VERSION,
diff --git a/drivers/ifxmodem/ifxmodem.h b/drivers/ifxmodem/ifxmodem.h
index 8ea52e5..fca1711 100644
--- a/drivers/ifxmodem/ifxmodem.h
+++ b/drivers/ifxmodem/ifxmodem.h
@@ -35,3 +35,6 @@ extern void ifx_gprs_context_exit();
 =

 extern void ifx_stk_init();
 extern void ifx_stk_exit();
+
+extern void ifx_cell_info_init();
+extern void ifx_cell_info_exit();
-- =

1.7.2.3


--===============1041102494449022956==--

