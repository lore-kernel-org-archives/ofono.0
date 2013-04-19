Content-Type: multipart/mixed; boundary="===============4701989456267689286=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 4/7] core: Set ECNR to TRUE by default
Date: Fri, 19 Apr 2013 14:34:41 -0300
Message-ID: <1366392884-7116-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366392884-7116-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4701989456267689286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to Bluetooth HFP spec: By default, if the AG supports its
own embedded echo canceling and/or noise reduction functions, it shall
have them activated until the AT+NREC command is received. The
configuration set by the HF shall by used by the AG while the Service
Level Connection is active.

Since there isn't a command to query the current value, it is being
assumed that ECNR is enabled when the connection is established and
the gateway supports ECNR feature.
---
 src/handsfree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/handsfree.c b/src/handsfree.c
index 041d3f2..31f2cea 100644
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


--===============4701989456267689286==--

