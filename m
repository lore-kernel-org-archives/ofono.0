Content-Type: multipart/mixed; boundary="===============4162904045722446608=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH v2] watch: Free service data in service_reply
Date: Mon, 26 Jul 2010 09:10:26 +0800
Message-ID: <1280106626-4726-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4162904045722446608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Avoid the memory leak of server_data.
---
 gdbus/watch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 1d479fa..29f23e2 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -533,7 +533,7 @@ static void check_service(DBusConnection *connection, c=
onst char *name,
 		goto done;
 	}
 =

-	dbus_pending_call_set_notify(call, service_reply, data, NULL);
+	dbus_pending_call_set_notify(call, service_reply, data, g_free);
 =

 	dbus_pending_call_unref(call);
 =

-- =

1.7.0.4


--===============4162904045722446608==--

