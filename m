Content-Type: multipart/mixed; boundary="===============7522612778559326638=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] smart-messaging: set agent to NULL after free
Date: Wed, 02 Feb 2011 16:53:32 -0200
Message-ID: <1296672812-2983-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7522612778559326638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If agent is not set to NULL after it's freed, the following situation
would not work:

smart_messaging_register_agent()
smart_messaging_unregister_agent()
smart_messaging_register_agent()

And this one could potentially crash oFono:

smart_messaging_register_agent()
smart_messaging_unregister_agent()
smart_messaging_unregister_agent()
---
 plugins/smart-messaging.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/smart-messaging.c b/plugins/smart-messaging.c
index 40af89f..52344de 100644
--- a/plugins/smart-messaging.c
+++ b/plugins/smart-messaging.c
@@ -165,6 +165,7 @@ static DBusMessage *smart_messaging_unregister_agent(DB=
usConnection *conn,
 		return __ofono_error_failed(msg);
 =

 	sms_agent_free(sm->agent);
+	sm->agent =3D NULL;
 =

 	return dbus_message_new_method_return(msg);
 }
-- =

1.7.4


--===============7522612778559326638==--

