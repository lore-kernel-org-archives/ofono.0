Content-Type: multipart/mixed; boundary="===============1621482691247191883=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] sim: Don't submit parallel EFpl reads
Date: Fri, 08 Dec 2017 17:57:56 +0300
Message-ID: <1512745076-3153-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1621482691247191883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In addition to not doing unnecessary SIM I/O, this fixes memory leaks
like this one:

=3D=3D10096=3D=3D 74 (56 direct, 18 indirect) bytes in 2 blocks are definit=
ely lost in loss record 1,252 of 1,342
=3D=3D10096=3D=3D    at 0x4841BF0: calloc (vg_replace_malloc.c)
=3D=3D10096=3D=3D    by 0x4B03117: g_malloc0 (gmem.c)
=3D=3D10096=3D=3D    by 0xF83DF: concat_lang_prefs (sim.c)
=3D=3D10096=3D=3D    by 0xF8697: sim_efpl_read_cb (sim.c)
=3D=3D10096=3D=3D    by 0x12CBF7: sim_fs_op_read_block_cb (simfs.c)
---
 src/sim.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index 2538c77..31df636 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2200,6 +2200,9 @@ static void sim_efli_efpl_changed(int id, void *userd=
ata)
 	if (sim->efli !=3D NULL) /* This shouldn't happen */
 		return;
 =

+	if (sim->language_prefs_update)
+		return;
+
 	if (sim->language_prefs) {
 		g_strfreev(sim->language_prefs);
 		sim->language_prefs =3D NULL;
-- =

1.9.1


--===============1621482691247191883==--

