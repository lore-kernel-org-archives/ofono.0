Content-Type: multipart/mixed; boundary="===============7394890445939234145=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 03/12] service: Store msg_id provided by M-Send.conf PDU
Date: Fri, 17 Aug 2012 16:35:04 +0200
Message-ID: <1345214113-25597-4-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1345214113-25597-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7394890445939234145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/service.c b/src/service.c
index db9c514..b073ca9 100644
--- a/src/service.c
+++ b/src/service.c
@@ -629,7 +629,7 @@ static gboolean result_request_send_conf(struct mms_req=
uest *request)
 =

 	uuid =3D request->msg->uuid;
 =

-	path =3D g_strdup_printf("%s/%s/%s", MMS_PATH, service->identity,	uuid);
+	path =3D g_strdup_printf("%s/%s/%s", MMS_PATH, service->identity, uuid);
 =

 	if (request->status !=3D 200)
 		goto error;
@@ -655,17 +655,21 @@ static gboolean result_request_send_conf(struct mms_r=
equest *request)
 =

 	mms_debug("response status : %d", msg->sc.rsp_status);
 =

-	mms_message_free(msg);
-
 	munmap(pdu, len);
 =

 	unlink(request->data_path);
 =

 	meta =3D mms_store_meta_open(service->identity, uuid);
-	if (meta =3D=3D NULL)
+	if (meta =3D=3D NULL) {
+		mms_message_free(msg);
+
 		goto error;
+	}
 =

 	g_key_file_set_string(meta, "info", "state", "sent");
+	g_key_file_set_string(meta, "info", "id", msg->sc.msgid);
+
+	mms_message_free(msg);
 =

 	mms_store_meta_close(service->identity, uuid, meta, TRUE);
 =

-- =

1.7.9.5


--===============7394890445939234145==--

