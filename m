Content-Type: multipart/mixed; boundary="===============4562605437187742809=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 3/5] isimodem: cell info init and exit functions
Date: Mon, 07 Mar 2011 12:24:32 +0200
Message-ID: <1299493474-12982-4-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1299493474-12982-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4562605437187742809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/isimodem.c |    2 ++
 drivers/isimodem/isimodem.h |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/isimodem.c b/drivers/isimodem/isimodem.c
index ba5cd54..0b69ff9 100644
--- a/drivers/isimodem/isimodem.c
+++ b/drivers/isimodem/isimodem.c
@@ -54,6 +54,7 @@ static int isimodem_init(void)
 	isi_gprs_init();
 	isi_gprs_context_init();
 	isi_audio_settings_init();
+	isi_cell_info_init();
 =

 	return 0;
 }
@@ -77,6 +78,7 @@ static void isimodem_exit(void)
 	isi_gprs_exit();
 	isi_gprs_context_exit();
 	isi_audio_settings_exit();
+	isi_cell_info_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(isimodem, "PhoNet / ISI modem driver", VERSION,
diff --git a/drivers/isimodem/isimodem.h b/drivers/isimodem/isimodem.h
index ed64f9d..c8d1a90 100644
--- a/drivers/isimodem/isimodem.h
+++ b/drivers/isimodem/isimodem.h
@@ -69,3 +69,6 @@ extern void isi_gprs_context_exit(void);
 =

 extern void isi_audio_settings_init(void);
 extern void isi_audio_settings_exit(void);
+
+extern void isi_cell_info_init();
+extern void isi_cell_info_exit();
-- =

1.7.1


--===============4562605437187742809==--

