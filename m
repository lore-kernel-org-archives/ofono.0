Content-Type: multipart/mixed; boundary="===============6848480873828563290=="
MIME-Version: 1.0
From: jun.wei@intel.com
Subject: [RFC 2/3] ifxmodem: Enable support of Neighbor Cell Info
Date: Tue, 23 Nov 2010 13:12:20 +0800
Message-ID: <1290489140-11908-1-git-send-email-jun.wei@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6848480873828563290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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


--===============6848480873828563290==--

