Content-Type: multipart/mixed; boundary="===============7613476346498180717=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 01/13] handsfree-audio: Add card driver
Date: Fri, 08 Mar 2013 20:11:13 -0300
Message-ID: <1362784285-22731-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362784285-22731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7613476346498180717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a new handsfree audio driver abstration to allow
implementing the connect callbacks and other potential functions
specific of each HFP profile version. This approach also avoids
including dependency of hfpmodem in handsfree-audio, keeping the service
level handling inside the hfp_hf_bluez5 only.
---
 include/handsfree-audio.h | 11 +++++++++++
 src/handsfree-audio.c     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index c5403c7..69f5a8e 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -30,6 +30,17 @@ extern "C" {
 =

 struct ofono_handsfree_card;
 =

+struct ofono_handsfree_card_driver {
+	int (*probe) (struct ofono_handsfree_card *card, void *data);
+	void (*remove) (struct ofono_handsfree_card *card);
+	int (*audio_connect) (const char *remote, const char *local);
+};
+
+int ofono_handsfree_card_driver_register(
+			const struct ofono_handsfree_card_driver *d);
+void ofono_handsfree_card_driver_unregister(
+			const struct ofono_handsfree_card_driver *d);
+
 struct ofono_handsfree_card *ofono_handsfree_card_create(const char *remot=
e,
 							const char *local);
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 73c6183..ffae47b 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -52,6 +52,7 @@ struct ofono_handsfree_card {
 	char *remote;
 	char *local;
 	char *path;
+	const struct ofono_handsfree_card_driver *driver;
 };
 =

 struct agent {
@@ -66,6 +67,7 @@ static struct agent *agent =3D NULL;
 static int ref_count =3D 0;
 static GSList *card_list =3D 0;
 static guint sco_watch =3D 0;
+static GSList *g_drivers =3D NULL;
 =

 static void send_new_connection(const char *card, int fd)
 {
@@ -255,6 +257,7 @@ struct ofono_handsfree_card *ofono_handsfree_card_creat=
e(const char *remote,
 							const char *local)
 {
 	struct ofono_handsfree_card *card;
+	GSList *l;
 =

 	card =3D g_new0(struct ofono_handsfree_card, 1);
 =

@@ -263,6 +266,16 @@ struct ofono_handsfree_card *ofono_handsfree_card_crea=
te(const char *remote,
 =

 	card_list =3D g_slist_prepend(card_list, card);
 =

+	for (l =3D g_drivers; l; l =3D g_slist_next(l)) {
+		const struct ofono_handsfree_card_driver *drv =3D l->data;
+
+		if (drv->probe(card, NULL) < 0)
+			continue;
+
+		card->driver =3D drv;
+		break;
+	}
+
 	return card;
 }
 =

@@ -534,6 +547,27 @@ static const GDBusSignalTable am_signals[] =3D {
 	{ }
 };
 =

+int ofono_handsfree_card_driver_register(
+				const struct ofono_handsfree_card_driver *d)
+{
+	DBG("driver: %p", d);
+
+	if (d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
+
+	return 0;
+}
+
+void ofono_handsfree_card_driver_unregister(
+				const struct ofono_handsfree_card_driver *d)
+{
+	DBG("driver: %p", d);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
+
 void ofono_handsfree_audio_ref(void)
 {
 	ref_count +=3D 1;
-- =

1.7.11.7


--===============7613476346498180717==--

