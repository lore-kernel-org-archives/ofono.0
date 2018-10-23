Content-Type: multipart/mixed; boundary="===============2626194248192749961=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] src/modem.c/call_watches null pointer check
Date: Tue, 23 Oct 2018 09:50:38 +0200
Message-ID: <20181023075039.13587-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2626194248192749961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

check the pointer modem->atom_watches, that can be null when the
function is called during the disable/remove of the device,
for example when it is unplugged or switched off.
---
 src/modem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/modem.c b/src/modem.c
index 9e254482..124a5192 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -255,11 +255,16 @@ static void call_watches(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond)
 {
 	struct ofono_modem *modem =3D atom->modem;
-	GSList *atom_watches =3D modem->atom_watches->items;
+	GSList *atom_watches;
 	GSList *l;
 	struct atom_watch *watch;
 	ofono_atom_watch_func notify;
 =

+	if (!modem->atom_watches)
+		return;
+
+	atom_watches =3D modem->atom_watches->items;
+
 	for (l =3D atom_watches; l; l =3D l->next) {
 		watch =3D l->data;
 =

-- =

2.17.1


--===============2626194248192749961==--

