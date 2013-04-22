Content-Type: multipart/mixed; boundary="===============5536799128861176607=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 4/7] core: Set EchoCancelingNoiseReduction to TRUE by
 default
Date: Mon, 22 Apr 2013 09:58:40 -0300
Message-ID: <1366635523-8272-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366635523-8272-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5536799128861176607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to Bluetooth HFP spec: By default, if the AG supports its
own embedded echo canceling and/or noise reduction functions, it shall
have them activated until the AT+NREC command is received. The
configuration set by the HF shall by used by the AG while the Service
Level Connection is active.

Since there isn't a command to query the current value, it is being
assumed that Echo Canceling and Noise Reduction is enabled when the
connection is established and the gateway supports this feature.
---
 src/handsfree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/handsfree.c b/src/handsfree.c
index d60841b..c89f5e3 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -361,6 +361,7 @@ struct ofono_handsfree *ofono_handsfree_create(struct o=
fono_modem *modem,
 	hf->atom =3D __ofono_modem_add_atom(modem,
 					OFONO_ATOM_TYPE_HANDSFREE,
 					handsfree_remove, hf);
+	hf->ecnr =3D TRUE;
 =

 	for (l =3D g_drivers; l; l =3D l->next) {
 		const struct ofono_handsfree_driver *drv =3D l->data;
-- =

1.7.11.7


--===============5536799128861176607==--

