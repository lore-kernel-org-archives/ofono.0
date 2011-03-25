Content-Type: multipart/mixed; boundary="===============3778189832218318541=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 17/18] gsmdial: add new option to test sending escape sequence
Date: Fri, 25 Mar 2011 16:25:48 +0100
Message-ID: <1301066749-12052-18-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3778189832218318541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gsmdial.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index a10e7cb..92a7ff2 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -57,6 +57,7 @@ static gchar *option_username =3D NULL;
 static gchar *option_password =3D NULL;
 static gchar *option_pppdump =3D NULL;
 static gboolean option_bluetooth =3D FALSE;
+static gboolean option_esc =3D FALSE;
 =

 static GAtPPP *ppp;
 static GAtChat *control;
@@ -624,6 +625,8 @@ static GOptionEntry options[] =3D {
 				"Use ATD*99***<cid>#" },
 	{ "bluetooth", 'b', 0, G_OPTION_ARG_NONE, &option_bluetooth,
 				"Use only ATD*99" },
+	{ "esc_seq", 'e', 0, G_OPTION_ARG_NONE, &option_esc,
+				"Send escape sequence test" },
 	{ "username", 'u', 0, G_OPTION_ARG_STRING, &option_username,
 				"Specify PPP username" },
 	{ "password", 'w', 0, G_OPTION_ARG_STRING, &option_password,
-- =

1.7.1


--===============3778189832218318541==--

