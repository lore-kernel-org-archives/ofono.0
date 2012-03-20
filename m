Content-Type: multipart/mixed; boundary="===============2248848615488005197=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 1/3] service: remove dead file
Date: Tue, 20 Mar 2012 19:42:21 +0100
Message-ID: <1332268943-24300-2-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1332268943-24300-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2248848615488005197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/service.c b/src/service.c
index ef6b544..3fdf4e0 100644
--- a/src/service.c
+++ b/src/service.c
@@ -755,6 +755,7 @@ static DBusMessage *send_message(DBusConnection *conn,
 		release_attachement_data(msg->attachments);
 		mms_message_free(msg);
 =

+		unlink(request->data_path);
 		mms_request_destroy(request);
 =

 		return __mms_error_trans_failure(dbus_msg);
-- =

1.7.4.4


--===============2248848615488005197==--

