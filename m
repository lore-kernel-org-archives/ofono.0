Content-Type: multipart/mixed; boundary="===============3547705117745150080=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 3/4] qmimodem: add translator qmi_error_to_ofono_cme()
Date: Tue, 05 Dec 2017 19:20:16 +0100
Message-ID: <20171205182017.462-3-lynxis@fe80.eu>
In-Reply-To: <20171205182017.462-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3547705117745150080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Translates qmi error codes into ofono cme errors
---
 drivers/qmimodem/qmi.c | 11 +++++++++++
 drivers/qmimodem/qmi.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a0632ca54025..90349db61964 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -476,6 +476,17 @@ static const char *__error_to_string(uint16_t error)
 	return NULL;
 }
 =

+int qmi_error_to_ofono_cme(int qmi_error) {
+	switch (qmi_error) {
+	case 0x0019:
+		return 4; /* Not Supported */
+	case 0x0052:
+		return 32; /* Access Denied */
+	default:
+		return -1;
+	}
+}
+
 static void __debug_msg(const char dir, const void *buf, size_t len,
 				qmi_debug_func_t function, void *user_data)
 {
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index b4955b40b1fb..4f2d5bdf59c5 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -140,6 +140,8 @@ bool qmi_result_get_uint64(struct qmi_result *result, u=
int8_t type,
 							uint64_t *value);
 void qmi_result_print_tlvs(struct qmi_result *result);
 =

+int qmi_error_to_ofono_cme(int qmi_error);
+
 struct qmi_service;
 =

 typedef void (*qmi_result_func_t)(struct qmi_result *result, void *user_da=
ta);
-- =

2.15.1


--===============3547705117745150080==--

