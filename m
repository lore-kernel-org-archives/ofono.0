Content-Type: multipart/mixed; boundary="===============2634800427713429818=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 09/10] service: add requeue functionality
Date: Fri, 13 Apr 2012 18:33:48 +0200
Message-ID: <1334334829-31617-10-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1334334829-31617-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2634800427713429818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/src/service.c b/src/service.c
index de92487..01d9886 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1805,6 +1805,25 @@ exit:
 	return TRUE;
 }
 =

+static gboolean mms_requeue_request(struct mms_request *request)
+{
+	request->attempt +=3D 1;
+
+	if (request->attempt =3D=3D MAX_ATTEMPTS)
+		return FALSE;
+
+	if (request->type =3D=3D MMS_REQUEST_TYPE_GET) {
+		request->fd =3D open(request->data_path, O_WRONLY | O_TRUNC,
+							S_IWUSR | S_IRUSR);
+		if (request->fd < 0)
+			return FALSE;
+	}
+
+	g_queue_push_tail(request->service->request_queue, request);
+
+	return TRUE;
+}
+
 static gboolean web_get_cb(GWebResult *result, gpointer user_data)
 {
 	gsize written;
@@ -1845,7 +1864,12 @@ complete:
 	else {
 		mms_error("Fail to get data (http status =3D %03u)",
 							request->status);
-		unlink(request->data_path);
+		if (mms_requeue_request(request) =3D=3D TRUE)
+			mms_error("retry later");
+		else {
+			unlink(request->data_path);
+			mms_request_destroy(request);
+		}
 	}
 =

 	request->service->current_request_id =3D 0;
-- =

1.7.4.4


--===============2634800427713429818==--

