Content-Type: multipart/mixed; boundary="===============3752994059337902964=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 3/4] isimodem: implement Suspended property
Date: Fri, 10 Sep 2010 16:50:58 +0300
Message-ID: <1284126659-18741-4-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1284126659-18741-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3752994059337902964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/debug.c |   25 ++++++++++++++++++++
 drivers/isimodem/debug.h |    2 +
 drivers/isimodem/gpds.h  |   17 ++++++++++++++
 drivers/isimodem/gprs.c  |   56 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 4 files changed, 99 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 86530fd..b398797 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -979,6 +979,31 @@ const char *gpds_isi_cause_name(enum gpds_isi_cause va=
lue)
 	return "GPDS_<UNKNOWN>";
 }
 =

+const char *gpds_transfer_status_name(enum gpds_transfer_status value)
+{
+	switch (value) {
+		_(GPDS_TRANSFER_NOT_AVAIL);
+		_(GPDS_TRANSFER_AVAIL);
+	}
+	return "GPDS_<UNKNOWN>";
+}
+
+const char *gpds_transfer_cause_name(enum gpds_transfer_cause value)
+{
+	switch (value) {
+		_(GPDS_TRANSFER_CAUSE_ATTACHED);
+		_(GPDS_TRANSFER_CAUSE_DETACHED);
+		_(GPDS_TRANSFER_CAUSE_RESUMED);
+		_(GPDS_TRANSFER_CAUSE_SUSPENDED_NO_COVERAGE);
+		_(GPDS_TRANSFER_CAUSE_SUSPENDED_CALL_SMS);
+		_(GPDS_TRANSFER_CAUSE_SUSPENDED_CALL);
+		_(GPDS_TRANSFER_CAUSE_SUSPENDED_RAU);
+		_(GPDS_TRANSFER_CAUSE_SUSPENDED_LU);
+		_(GPDS_TRANSFER_CAUSE_DSAC_RESTRICTION);
+	}
+	return "GPDS_<UNKNOWN>";
+}
+
 #undef _
 =

 static void hex_dump(const char *name, const uint8_t m[], size_t len)
diff --git a/drivers/isimodem/debug.h b/drivers/isimodem/debug.h
index d507991..1ad5547 100644
--- a/drivers/isimodem/debug.h
+++ b/drivers/isimodem/debug.h
@@ -70,6 +70,8 @@ const char *gpds_message_id_name(enum gpds_message_id val=
ue);
 const char *gpds_subblock_name(enum gpds_subblock value);
 const char *gpds_status_name(enum gpds_status value);
 const char *gpds_isi_cause_name(enum gpds_isi_cause value);
+const char *gpds_transfer_status_name(enum gpds_transfer_status value);
+const char *gpds_transfer_cause_name(enum gpds_transfer_cause value);
 =

 void ss_debug(const void *restrict buf, size_t len, void *data);
 void mtc_debug(const void *restrict buf, size_t len, void *data);
diff --git a/drivers/isimodem/gpds.h b/drivers/isimodem/gpds.h
index 86d4d95..9bb60e6 100644
--- a/drivers/isimodem/gpds.h
+++ b/drivers/isimodem/gpds.h
@@ -202,6 +202,23 @@ enum gpds_isi_cause {
 	GPDS_CAUSE_AUT_FAILURE =3D		0xFF,
 };
 =

+enum gpds_transfer_status {
+	GPDS_TRANSFER_NOT_AVAIL =3D		0x00,
+	GPDS_TRANSFER_AVAIL =3D			0x01,
+};
+
+enum gpds_transfer_cause {
+	GPDS_TRANSFER_CAUSE_ATTACHED =3D			0x02,
+	GPDS_TRANSFER_CAUSE_DETACHED =3D			0x03,
+	GPDS_TRANSFER_CAUSE_RESUMED =3D			0x04,
+	GPDS_TRANSFER_CAUSE_SUSPENDED_NO_COVERAGE =3D	0x05,
+	GPDS_TRANSFER_CAUSE_SUSPENDED_CALL_SMS =3D	0x07,
+	GPDS_TRANSFER_CAUSE_SUSPENDED_CALL =3D		0x08,
+	GPDS_TRANSFER_CAUSE_SUSPENDED_RAU =3D		0x09,
+	GPDS_TRANSFER_CAUSE_SUSPENDED_LU =3D		0x0A,
+	GPDS_TRANSFER_CAUSE_DSAC_RESTRICTION =3D		0x0B,
+};
+
 enum gpds_context_type {
 	GPDS_CONT_TYPE_NORMAL =3D			0x00,
 	GPDS_CONT_TYPE_NWI =3D			0x01,
diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index 6f4f686..93786ec 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -72,6 +72,55 @@ static void detach_ind_cb(GIsiClient *client,
 	/*ofono_gprs_detached_notify(gprs);*/
 }
 =

+static void suspend_notify(struct ofono_gprs *gprs, uint8_t suspend_status,
+			uint8_t suspend_cause)
+{
+	int cause;
+
+	DBG("transfer status: %s (0x%02"PRIx8") cause %s (0x%02"PRIx8")",
+		gpds_transfer_status_name(suspend_status), suspend_status,
+		gpds_transfer_cause_name(suspend_cause), suspend_cause);
+
+	if (suspend_status =3D=3D GPDS_TRANSFER_AVAIL) {
+		ofono_gprs_resume_notify(gprs);
+		return;
+	}
+
+	switch (suspend_cause) {
+	case GPDS_TRANSFER_CAUSE_SUSPENDED_NO_COVERAGE:
+		cause =3D GPRS_SUSPENDED_NO_COVERAGE;
+		break;
+
+	case GPDS_TRANSFER_CAUSE_SUSPENDED_CALL:
+		cause =3D GPRS_SUSPENDED_CALL;
+		break;
+
+	case GPDS_TRANSFER_CAUSE_SUSPENDED_CALL_SMS:
+	case GPDS_TRANSFER_CAUSE_SUSPENDED_RAU:
+	case GPDS_TRANSFER_CAUSE_SUSPENDED_LU:
+		cause =3D GPRS_SUSPENDED_SIGNALLING;
+		break;
+
+	default:
+		return;
+	}
+
+	ofono_gprs_suspend_notify(gprs, cause);
+}
+
+static void transfer_status_ind_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	struct ofono_gprs *gprs =3D opaque;
+	const unsigned char *msg =3D data;
+
+	if (!msg || len < 3 || msg[0] !=3D GPDS_TRANSFER_STATUS_IND)
+		return;
+
+	suspend_notify(gprs, msg[1], msg[2]);
+}
+
 static gboolean isi_gprs_register(gpointer user)
 {
 	struct ofono_gprs *gprs =3D user;
@@ -83,6 +132,8 @@ static gboolean isi_gprs_register(gpointer user)
 		g_isi_client_set_debug(gd->client, gpds_debug, NULL);
 =

 	g_isi_subscribe(gd->client, GPDS_DETACH_IND, detach_ind_cb, gprs);
+	g_isi_subscribe(gd->client, GPDS_TRANSFER_STATUS_IND,
+			transfer_status_ind_cb, gprs);
 =

 	ofono_gprs_register(user);
 =

@@ -258,6 +309,7 @@ static gboolean status_resp_cb(GIsiClient *client,
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
 	ofono_gprs_status_cb_t cb =3D cbd->cb;
+	struct ofono_gprs *gprs =3D cbd->data;
 	int status;
 =

 	if (!msg) {
@@ -265,7 +317,7 @@ static gboolean status_resp_cb(GIsiClient *client,
 		goto error;
 	}
 =

-	if (len < 2 || msg[0] !=3D GPDS_STATUS_RESP)
+	if (len < 13 || msg[0] !=3D GPDS_STATUS_RESP)
 		return FALSE;
 =

 	/* FIXME: the core still expects reg status, and not a boolean
@@ -281,6 +333,8 @@ static gboolean status_resp_cb(GIsiClient *client,
 		status =3D GPRS_STAT_UNKNOWN;
 	}
 =

+	suspend_notify(gprs, msg[11], msg[12]);
+
 	CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
 =

 	return TRUE;
-- =

1.7.0.4


--===============3752994059337902964==--

