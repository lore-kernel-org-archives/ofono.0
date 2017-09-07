Content-Type: multipart/mixed; boundary="===============8559784902462678173=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 4/5] qmi: add helper to get int16_t result
Date: Thu, 07 Sep 2017 14:11:35 +0200
Message-ID: <20170907121136.13520-4-jonas@southpole.se>
In-Reply-To: <20170907121136.13520-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8559784902462678173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 21 +++++++++++++++++++++
 drivers/qmimodem/qmi.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 17c6a6f..c538cb9 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1720,6 +1720,27 @@ bool qmi_result_get_uint8(struct qmi_result *result,=
 uint8_t type,
 	return true;
 }
 =

+bool qmi_result_get_int16(struct qmi_result *result, uint8_t type,
+							int16_t *value)
+{
+	const unsigned char *ptr;
+	uint16_t len, tmp;
+
+	if (!result || !type)
+		return false;
+
+	ptr =3D tlv_get(result->data, result->length, type, &len);
+	if (!ptr)
+		return false;
+
+	memcpy(&tmp, ptr, 2);
+
+	if (value)
+		*value =3D GINT16_FROM_LE(tmp);
+
+	return true;
+}
+
 bool qmi_result_get_uint16(struct qmi_result *result, uint8_t type,
 							uint16_t *value)
 {
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index bfe8e6b..b4955b4 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -130,6 +130,8 @@ const void *qmi_result_get(struct qmi_result *result, u=
int8_t type,
 char *qmi_result_get_string(struct qmi_result *result, uint8_t type);
 bool qmi_result_get_uint8(struct qmi_result *result, uint8_t type,
 							uint8_t *value);
+bool qmi_result_get_int16(struct qmi_result *result, uint8_t type,
+							int16_t *value);
 bool qmi_result_get_uint16(struct qmi_result *result, uint8_t type,
 							uint16_t *value);
 bool qmi_result_get_uint32(struct qmi_result *result, uint8_t type,
-- =

2.9.3


--===============8559784902462678173==--

