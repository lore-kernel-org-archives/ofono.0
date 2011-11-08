Content-Type: multipart/mixed; boundary="===============3090816138258973999=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 3/6] gsmdial: Add IPv6 CP option
Date: Tue, 08 Nov 2011 14:46:55 +0200
Message-ID: <1320756418-30890-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1320756418-30890-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3090816138258973999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index be159eb..b4b2015 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -59,6 +59,7 @@ static gchar *option_pppdump =3D NULL;
 static gboolean option_bluetooth =3D FALSE;
 static gboolean option_acfc =3D FALSE;
 static gboolean option_pfc =3D FALSE;
+static gboolean option_ipv6cp =3D FALSE;
 =

 static GAtPPP *ppp;
 static GAtChat *control;
@@ -372,6 +373,9 @@ static void connect_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	if (option_pppdump)
 		g_at_ppp_set_recording(ppp, option_pppdump);
 =

+	if (option_ipv6cp)
+		g_at_ppp_set_ipv6cp_info(ppp, FALSE, NULL, NULL);
+
 	g_at_ppp_set_credentials(ppp, option_username, option_password);
 =

 	g_at_ppp_set_acfc_enabled(ppp, option_acfc);
@@ -687,6 +691,8 @@ static GOptionEntry options[] =3D {
 				"Use Protocol Field Compression" },
 	{ "acfc", 0, 0, G_OPTION_ARG_NONE, &option_acfc,
 				"Use Address & Control Field Compression" },
+	{ "ipv6cp", '6', 0, G_OPTION_ARG_NONE, &option_ipv6cp,
+				"Enable IPv6 CP" },
 	{ NULL },
 };
 =

-- =

1.7.5.4


--===============3090816138258973999==--

