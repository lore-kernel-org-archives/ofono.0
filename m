Content-Type: multipart/mixed; boundary="===============7393825513592999524=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 03/10] handsfree-audio: Remove modem dependency
Date: Thu, 28 Feb 2013 15:52:45 -0300
Message-ID: <1362077572-28049-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362077572-28049-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7393825513592999524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch replaces the handsfree modem verification by the Audio Card.
Audio Cards are created when the RFCOMM fd descriptor is received, and
registered when the service level connetion is established.
---
 src/handsfree-audio.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 14488ac..6657bc5 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -70,19 +70,12 @@ static GSList *card_list =3D 0;
 static guint sco_watch =3D 0;
 static uint16_t local_hfp_version =3D HFP_VERSION_1_6;
 =

-static ofono_bool_t slc_match(struct ofono_modem *modem, void *userdata)
+static int card_cmp(gconstpointer a, gconstpointer b)
 {
-	const char *remote =3D userdata;
-	const char *value =3D ofono_modem_get_string(modem, "Remote");
+	const struct ofono_handsfree_card *card =3D a;
+	const char *remote =3D b;
 =

-	if (value =3D=3D NULL)
-		return FALSE;
-
-	/* Make sure SLC has been established */
-	if (ofono_modem_get_powered(modem) !=3D TRUE)
-		return FALSE;
-
-	return g_str_equal(remote, value);
+	return g_strcmp0(card->remote, remote);
 }
 =

 static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
@@ -107,8 +100,8 @@ static gboolean sco_accept(GIOChannel *io, GIOCondition=
 cond,
 =

 	bt_ba2str(&saddr.sco_bdaddr, remote);
 =

-	if (ofono_modem_find(slc_match, remote) =3D=3D NULL) {
-		ofono_error("Rejecting SCO: No SLC connection found!");
+	if (g_slist_find_custom(card_list, remote, card_cmp) =3D=3D NULL) {
+		ofono_error("Rejecting SCO: Audio Card not found!");
 		close(nsk);
 		return TRUE;
 	}
-- =

1.7.11.7


--===============7393825513592999524==--

