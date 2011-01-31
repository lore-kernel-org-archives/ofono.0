Content-Type: multipart/mixed; boundary="===============1443874018713736299=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 7/8] emulator: Implement dialing up for DUN
Date: Mon, 31 Jan 2011 18:52:01 -0200
Message-ID: <1296507122-10936-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296507122-10936-6-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1443874018713736299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It handles client ATD*99# request and then initiate the PPP negotiation.
IP forward through the new ppp interface is not done yet.

Initially based on patches from Zhenhua Zhang <zhenhua.zhang@intel.com>
---
 src/emulator.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index aa71e21..12e801d 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -32,11 +32,18 @@
 #include "ofono.h"
 #include "common.h"
 #include "gatserver.h"
+#include "gatppp.h"
+
+#define DUN_SERVER_ADDRESS	"192.168.1.1"
+#define DUN_PEER_ADDRESS	"192.168.1.2"
+#define DUN_DNS_SERVER_1	"10.10.10.10"
+#define DUN_DNS_SERVER_2	"10.10.10.11"
 =

 struct ofono_emulator {
 	struct ofono_modem *modem;
 	struct ofono_atom *atom;
 	GAtServer *server;
+	GAtPPP *ppp;
 	struct ofono_emulator_driver *driver;
 };
 =

@@ -167,6 +174,12 @@ void ofono_emulator_disable(struct ofono_emulator *e)
 {
 	DBG("");
 =

+	if (e->ppp) {
+		g_at_ppp_shutdown(e->ppp);
+		g_at_ppp_unref(e->ppp);
+		e->ppp =3D NULL;
+	}
+
 	g_at_server_shutdown(e->server);
 	g_at_server_unref(e->server);
 	e->server =3D NULL;
@@ -201,6 +214,8 @@ int ofono_emulator_enable(struct ofono_emulator *e, int=
 fd)
 	g_at_server_set_disconnect_function(e->server,
 						emulator_disconnect_cb, e);
 =

+	g_at_server_register(e->server, "D", dial_cb, e, NULL);
+
 	return 0;
 }
 =

-- =

1.7.4.rc3


--===============1443874018713736299==--

