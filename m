Content-Type: multipart/mixed; boundary="===============1202888270436607214=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/2] src/lte.c: added implementation for ofono_lte_get_modem
Date: Sat, 22 Sep 2018 12:04:01 +0200
Message-ID: <20180922100401.14889-2-gciofono@gmail.com>
In-Reply-To: <20180922100401.14889-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1202888270436607214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/lte.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/lte.c b/src/lte.c
index e16d9aab..23fe8e1c 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -373,3 +373,8 @@ void *ofono_lte_get_data(const struct ofono_lte *lte)
 {
 	return lte->driver_data;
 }
+
+struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte *lte)
+{
+	return __ofono_atom_get_modem(lte->atom);
+}
-- =

2.17.1


--===============1202888270436607214==--

