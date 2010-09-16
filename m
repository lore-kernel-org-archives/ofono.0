Content-Type: multipart/mixed; boundary="===============0609004491304387720=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [isimodem-ussd PATCH 4/5] isimodem/debug: debug USSD type
Date: Thu, 16 Sep 2010 20:32:48 +0300
Message-ID: <1284658369-1988-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1284658369-1988-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0609004491304387720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/debug.c |   13 +++++++++++++
 drivers/isimodem/debug.h |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index b398797..d226c51 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -70,6 +70,19 @@ const char *ss_message_id_name(enum ss_message_id value)
 	return "SS_<UNKNOWN>";
 }
 =

+const char *ss_ussd_type_name(enum ss_ussd_type value)
+{
+	switch (value) {
+		_(SS_GSM_USSD_MT_REPLY);
+		_(SS_GSM_USSD_COMMAND);
+		_(SS_GSM_USSD_REQUEST);
+		_(SS_GSM_USSD_NOTIFY);
+		_(SS_GSM_USSD_END);
+	}
+	return "SS_<UNKNOWN>";
+}
+
+
 const char *ss_subblock_name(enum ss_subblock value)
 {
 	switch (value) {
diff --git a/drivers/isimodem/debug.h b/drivers/isimodem/debug.h
index 1ad5547..f03f4ec 100644
--- a/drivers/isimodem/debug.h
+++ b/drivers/isimodem/debug.h
@@ -34,6 +34,7 @@
 =

 const char *ss_message_id_name(enum ss_message_id value);
 const char *ss_subblock_name(enum ss_subblock value);
+const char *ss_ussd_type_name(enum ss_ussd_type value);
 =

 const char *mtc_isi_cause_name(enum mtc_isi_cause value);
 const char *mtc_message_id_name(enum mtc_message_id value);
-- =

1.7.0.4


--===============0609004491304387720==--

