Content-Type: multipart/mixed; boundary="===============6538705504862423341=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH 6/6] hfp_hf_bluez5: Handle org.bluez.Profile1.Release()
Date: Thu, 15 Aug 2013 23:26:09 -0300
Message-ID: <1376619969-15080-7-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1376619969-15080-1-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6538705504862423341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There's nothing we can do in this case, so we only reply with a
success.
---
 plugins/hfp_hf_bluez5.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 7e98a45..391a74e 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -564,9 +564,7 @@ static DBusMessage *profile_release(DBusConnection *con=
n,
 {
 	DBG("Profile handler Release");
 =

-	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-						".NotImplemented",
-						"Implementation not provided");
+	return dbus_message_new_method_return(msg);
 }
 =

 static DBusMessage *profile_cancel(DBusConnection *conn,
-- =

1.8.3.4


--===============6538705504862423341==--

