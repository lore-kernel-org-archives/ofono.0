Content-Type: multipart/mixed; boundary="===============0964933310238559180=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] lte.h: added ofono_lte_get_modem global function
Date: Sun, 23 Sep 2018 06:41:10 +0200
Message-ID: <20180923044111.22055-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0964933310238559180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

this function can be used in the drivers to query the functions
ofono_modem_get_* to retrieve modem-specific properties
---
 include/lte.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/lte.h b/include/lte.h
index ef84ab99..0f2501c0 100644
--- a/include/lte.h
+++ b/include/lte.h
@@ -61,6 +61,8 @@ void ofono_lte_set_data(struct ofono_lte *lte, void *data=
);
 =

 void *ofono_lte_get_data(const struct ofono_lte *lte);
 =

+struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte *lte);
+
 #ifdef __cplusplus
 }
 #endif
-- =

2.17.1


--===============0964933310238559180==--

