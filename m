Content-Type: multipart/mixed; boundary="===============0577507157769423283=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH 5/6] hfp_hf_bluez5: Handle org.bluez.Profile1.Cancel()
Date: Thu, 15 Aug 2013 23:26:08 -0300
Message-ID: <1376619969-15080-6-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1376619969-15080-1-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0577507157769423283==
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

1.8.3.4


--===============0577507157769423283==--

