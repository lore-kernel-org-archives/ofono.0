Content-Type: multipart/mixed; boundary="===============9063698899103871980=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 02/10] service: add debug prints
Date: Fri, 13 Apr 2012 18:33:41 +0200
Message-ID: <1334334829-31617-3-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1334334829-31617-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9063698899103871980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/service.c b/src/service.c
index 593adcb..6041d6d 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1804,8 +1804,10 @@ static gboolean web_get_cb(GWebResult *result, gpoin=
ter user_data)
 	struct mms_service *service;
 	const guint8 *chunk;
 =

-	if (g_web_result_get_chunk(result, &chunk, &chunk_size) =3D=3D FALSE)
+	if (g_web_result_get_chunk(result, &chunk, &chunk_size) =3D=3D FALSE) {
+		mms_error("Fail to get data chunk");
 		goto error;
+	}
 =

 	if (chunk_size =3D=3D 0) {
 		close(request->fd);
@@ -1904,6 +1906,8 @@ static guint process_request(struct mms_request *requ=
est)
 		return id;
 	}
 =

+	mms_error("Cannot process request (request type: %d)", request->type);
+
 	unlink(request->data_path);
 =

 	return 0;
@@ -2020,6 +2024,8 @@ error:
 =

 out:
 	mms_message_free(msg);
+
+	mms_error("Failed to handle incoming notification");
 }
 =

 void mms_service_bearer_notify(struct mms_service *service, mms_bool_t act=
ive,
-- =

1.7.4.4


--===============9063698899103871980==--

