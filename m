Content-Type: multipart/mixed; boundary="===============4254621452546333415=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv3 09/10] service: add requeue functionality
Date: Wed, 18 Apr 2012 15:27:47 +0200
Message-ID: <1334755668-27458-10-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1334755668-27458-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4254621452546333415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: S=C3=A9bastien Bianti <sebastien.bianti@linux.intel.com>

---
 src/service.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/src/service.c b/src/service.c
index bcfd9e0..f25e656 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1807,6 +1807,25 @@ exit:
 	return TRUE;
 }

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
@@ -1847,7 +1866,12 @@ complete:
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

 	request->service->current_request_id =3D 0;
--
1.7.4.1


--===============4254621452546333415==--

