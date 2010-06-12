Content-Type: multipart/mixed; boundary="===============9094729168008291724=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 09/11] gsmdial: Unref ppp when we get disconnected
Date: Sat, 12 Jun 2010 13:50:48 +0800
Message-ID: <1276321850-13307-10-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1276321850-13307-9-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9094729168008291724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 29e1d22..59f1a5c 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -265,7 +265,12 @@ static void ppp_connect(const char *iface, const char =
*local, const char *peer,
 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
 {
 	char buf[64];
+
 	g_print("PPP Link down: %d\n", reason);
+
+	g_at_ppp_unref(ppp);
+	ppp =3D NULL;
+
 	g_at_chat_resume(modem);
 =

 	sprintf(buf, "AT+CFUN=3D%u", option_offmode);
-- =

1.6.3.3


--===============9094729168008291724==--

