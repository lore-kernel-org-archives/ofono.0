Content-Type: multipart/mixed; boundary="===============6890434639176340648=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 2/2] service: use proper status value string
Date: Mon, 23 Apr 2012 10:31:49 +0200
Message-ID: <1335169909-12531-3-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1335169909-12531-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6890434639176340648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/service.c b/src/service.c
index 469393a..f89fd3f 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1502,7 +1502,7 @@ static void append_sr_msg_properties(DBusMessageIter =
*dict,
 					struct mms_message *msg)
 {
 	const char *date =3D time_to_str(&msg->rc.date);
-	const char *status =3D "draft";
+	const char *status =3D mms_message_status_get_string(msg->sr.status);
 =

 	mms_dbus_dict_append_basic(dict, "Status",
 					DBUS_TYPE_STRING, &status);
-- =

1.7.4.4


--===============6890434639176340648==--

