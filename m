Content-Type: multipart/mixed; boundary="===============2964046887777118147=="
MIME-Version: 1.0
From: iiro.kaihlaniemi@nokia.com
Subject: [PATCH 3/5] isimodem: Add functionality to UICC
Date: Wed, 03 Aug 2011 10:43:11 +0000
Message-ID: <6B9DA0A3415B234191A1ADFA6275C51CB2412F@008-AM1MPN1-041.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2964046887777118147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/isimodem/debug.h b/drivers/isimodem/debug.h
index 3a273e9..7629317 100644
--- a/drivers/isimodem/debug.h
+++ b/drivers/isimodem/debug.h
@@ -50,7 +50,9 @@ const char *mce_status_info(enum mce_status_info value);
 =

 const char *uicc_message_id_name(enum uicc_message_id value);
 const char *uicc_subblock_name(uint8_t value);
+const char *uicc_service_type_name(uint8_t value);
 const char *uicc_status_name(uint8_t value);
+const char *uicc_details_name(uint8_t value);
 =

 const char *sms_gsm_cause_name(enum sms_gsm_cause value);
 const char *sms_isi_cause_name(enum sms_isi_cause value);








--===============2964046887777118147==--

