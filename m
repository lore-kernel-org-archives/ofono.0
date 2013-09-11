Content-Type: multipart/mixed; boundary="===============7248811003944633707=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH 6/7] hfp_hf_bluez5: Handle org.bluez.Profile1.Cancel()
Date: Tue, 10 Sep 2013 21:09:45 -0300
Message-ID: <1378858186-683-6-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1378858186-683-1-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7248811003944633707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cancel() will be called when the ConnectProfile() is called, perhaps
even replied with a success, and the user cancels the connection
attempt.
---
 plugins/hfp_hf_bluez5.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index f08bf53..7e98a45 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -574,9 +574,7 @@ static DBusMessage *profile_cancel(DBusConnection *conn,
 {
 	DBG("Profile handler Cancel");
 =

-	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-					".NotImplemented",
-					"Implementation not provided");
+	return dbus_message_new_method_return(msg);
 }
 =

 static DBusMessage *profile_disconnection(DBusConnection *conn,
-- =

1.8.4


--===============7248811003944633707==--

