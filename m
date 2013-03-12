Content-Type: multipart/mixed; boundary="===============6593079927071359275=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 02/20] handsfree-audio: Add user data to card driver
Date: Tue, 12 Mar 2013 11:21:26 -0300
Message-ID: <1363098104-16467-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6593079927071359275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For hfp_hf_bluez5 plugin, the modem reference needs to be passed using
the user data. Access to service level connection is required to send
AT commands.
---
 include/handsfree-audio.h | 3 ++-
 src/handsfree-audio.c     | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index e99a2dd..1a059b3 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -44,7 +44,8 @@ void ofono_handsfree_card_driver_unregister(
 			const struct ofono_handsfree_card_driver *d);
 =

 struct ofono_handsfree_card *ofono_handsfree_card_create(const char *remot=
e,
-					const char *local, uint16_t version);
+					const char *local, uint16_t version,
+					void *data);
 int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
 void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
 =

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 62d316f..52e1ede 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -56,6 +56,7 @@ struct ofono_handsfree_card {
 	const struct ofono_handsfree_card_driver *driver;
 	DBusMessage *msg;
 	guint sco_watch;
+	void *data;
 };
 =

 struct agent {
@@ -320,7 +321,8 @@ static const GDBusSignalTable card_signals[] =3D {
 };
 =

 struct ofono_handsfree_card *ofono_handsfree_card_create(const char *remot=
e,
-					const char *local, uint16_t version)
+					const char *local, uint16_t version,
+					void *data)
 {
 	struct ofono_handsfree_card *card;
 	GSList *l;
@@ -329,6 +331,7 @@ struct ofono_handsfree_card *ofono_handsfree_card_creat=
e(const char *remote,
 =

 	card->remote =3D g_strdup(remote);
 	card->local =3D g_strdup(local);
+	card->data =3D data;
 =

 	card_list =3D g_slist_prepend(card_list, card);
 =

@@ -338,7 +341,7 @@ struct ofono_handsfree_card *ofono_handsfree_card_creat=
e(const char *remote,
 		if (drv->version !=3D version)
 			continue;
 =

-		if (drv->probe(card, NULL) < 0)
+		if (drv->probe(card, data) < 0)
 			continue;
 =

 		card->driver =3D drv;
-- =

1.7.11.7


--===============6593079927071359275==--

