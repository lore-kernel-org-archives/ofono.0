Content-Type: multipart/mixed; boundary="===============1382937906865412820=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] src/lte.c: added implementation for ofono_lte_get_modem
Date: Sun, 23 Sep 2018 06:41:11 +0200
Message-ID: <20180923044111.22055-2-gciofono@gmail.com>
In-Reply-To: <20180923044111.22055-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1382937906865412820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/lte.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/lte.c b/src/lte.c
index e16d9aab..4b14f6e8 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -373,3 +373,9 @@ void *ofono_lte_get_data(const struct ofono_lte *lte)
 {
 	return lte->driver_data;
 }
+
+struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte *lte)
+{
+	return __ofono_atom_get_modem(lte->atom);
+}
+
-- =

2.17.1


--===============1382937906865412820==--

