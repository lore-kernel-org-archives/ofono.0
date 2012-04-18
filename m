Content-Type: multipart/mixed; boundary="===============2252932825635439646=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv3 02/10] service: add debug prints
Date: Wed, 18 Apr 2012 15:27:40 +0200
Message-ID: <1334755668-27458-3-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1334755668-27458-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2252932825635439646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: S=C3=A9bastien Bianti <sebastien.bianti@linux.intel.com>

---
 src/service.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/service.c b/src/service.c
index 7f2a302..e36f318 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1806,8 +1806,10 @@ static gboolean web_get_cb(GWebResult *result, gpoin=
ter user_data)
 	struct mms_service *service;
 	const guint8 *chunk;

-	if (g_web_result_get_chunk(result, &chunk, &chunk_size) =3D=3D FALSE)
+	if (g_web_result_get_chunk(result, &chunk, &chunk_size) =3D=3D FALSE) {
+		mms_error("Fail to get data chunk");
 		goto error;
+	}

 	if (chunk_size =3D=3D 0) {
 		close(request->fd);
@@ -1906,6 +1908,8 @@ static guint process_request(struct mms_request *requ=
est)
 		return id;
 	}

+	mms_error("Cannot process request (request type: %d)", request->type);
+
 	unlink(request->data_path);

 	return 0;
@@ -2022,6 +2026,8 @@ error:

 out:
 	mms_message_free(msg);
+
+	mms_error("Failed to handle incoming notification");
 }

 void mms_service_bearer_notify(struct mms_service *service, mms_bool_t act=
ive,
--
1.7.4.1


--===============2252932825635439646==--

