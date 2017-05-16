Content-Type: multipart/mixed; boundary="===============1958091926739315906=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH] qmimodem: add debug helper qmi_result_tlv_walk
Date: Tue, 16 May 2017 15:38:07 +0200
Message-ID: <20170516133807.32368-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1958091926739315906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

qmi_result_tlv_walk prints the type and length field
of a result to DBG()
---
 drivers/qmimodem/qmi.c | 17 +++++++++++++++++
 drivers/qmimodem/qmi.h |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 30123723..cdeaddaa 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1026,6 +1026,23 @@ void qmi_device_set_close_on_unref(struct qmi_device=
 *device, bool do_close)
 	device->close_on_unref =3D do_close;
 }
 =

+void qmi_result_tlv_walk(struct qmi_result *result)
+{
+	const void *ptr =3D result->data;
+	uint16_t len =3D result->length;
+
+	while (len > QMI_TLV_HDR_SIZE) {
+		const struct qmi_tlv_hdr *tlv =3D ptr;
+		uint16_t tlv_length =3D GUINT16_FROM_LE(tlv->length);
+
+		DBG("tlv: 0x%02x len 0x%04x", tlv->type, tlv->length);
+
+		ptr +=3D QMI_TLV_HDR_SIZE + tlv_length;
+		len -=3D QMI_TLV_HDR_SIZE + tlv_length;
+	}
+}
+
+
 static const void *tlv_get(const void *data, uint16_t size,
 					uint8_t type, uint16_t *length)
 {
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 0cd8f7c9..ec4a479c 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -136,7 +136,7 @@ bool qmi_result_get_uint32(struct qmi_result *result, u=
int8_t type,
 							uint32_t *value);
 bool qmi_result_get_uint64(struct qmi_result *result, uint8_t type,
 							uint64_t *value);
-
+void qmi_result_tlv_walk(struct qmi_result *result);
 =

 struct qmi_service;
 =

-- =

2.13.0


--===============1958091926739315906==--

