Content-Type: multipart/mixed; boundary="===============6713286957063991352=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 07/12] service: Support delivery_ind notif on start
Date: Fri, 24 Aug 2012 15:06:06 +0200
Message-ID: <1345813571-15775-8-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1345813571-15775-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6713286957063991352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 8087477..b3ecc1e 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1357,7 +1357,8 @@ static gboolean load_message_from_store(const char *s=
ervice_id,
 	else if (strcmp(state, "draft") =3D=3D 0
 			&& msg->type =3D=3D MMS_MESSAGE_TYPE_SEND_REQ)
 		msg->sr.status =3D MMS_MESSAGE_STATUS_DRAFT;
-	else if (msg->type !=3D MMS_MESSAGE_TYPE_NOTIFICATION_IND)
+	else if (msg->type !=3D MMS_MESSAGE_TYPE_NOTIFICATION_IND &&
+			msg->type !=3D MMS_MESSAGE_TYPE_DELIVERY_IND)
 		goto out;
 =

 	success =3D TRUE;
@@ -1482,6 +1483,8 @@ register_sr:
 			request =3D NULL;
 			mms_message_register(service, msg);
 		}
+	} else if (msg->type =3D=3D MMS_MESSAGE_TYPE_DELIVERY_IND) {
+		request =3D NULL;
 	} else
 		request =3D NULL;
 =

-- =

1.7.9.5


--===============6713286957063991352==--

