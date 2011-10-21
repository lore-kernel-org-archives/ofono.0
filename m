Content-Type: multipart/mixed; boundary="===============6747772196188038413=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v4 07/12] hfpmodem: Avoid segfault in network-registration
Date: Fri, 21 Oct 2011 18:51:32 +0200
Message-ID: <1319215897-6310-8-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319215897-6310-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6747772196188038413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The use of g_idle_add can cause a segmentation fault if the object is
destroyed in the meantime.
---
 drivers/hfpmodem/network-registration.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
index da7d8eb..4b9f875 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -51,6 +51,7 @@ struct netreg_data {
 	GAtChat *chat;
 	unsigned char cind_pos[HFP_INDICATOR_LAST];
 	int cind_val[HFP_INDICATOR_LAST];
+	guint register_source;
 };
 =

 static void cops_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -297,6 +298,9 @@ static void hfp_signal_strength(struct ofono_netreg *ne=
treg,
 static gboolean hfp_netreg_register(gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	nd->register_source =3D 0;
 =

 	ofono_netreg_register(netreg);
 =

@@ -320,7 +324,7 @@ static int hfp_netreg_probe(struct ofono_netreg *netreg=
, unsigned int vendor,
 	g_at_chat_register(nd->chat, "+CIEV:", ciev_notify, FALSE,
 				netreg, NULL);
 =

-	g_idle_add(hfp_netreg_register, netreg);
+	nd->register_source =3D g_idle_add(hfp_netreg_register, netreg);
 =

 	return 0;
 }
@@ -329,6 +333,9 @@ static void hfp_netreg_remove(struct ofono_netreg *netr=
eg)
 {
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

+	if (nd->register_source !=3D 0)
+		g_source_remove(nd->register_source);
+
 	ofono_netreg_set_data(netreg, NULL);
 =

 	g_at_chat_unref(nd->chat);
-- =

1.7.6.4


--===============6747772196188038413==--

