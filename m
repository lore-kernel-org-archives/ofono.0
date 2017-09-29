Content-Type: multipart/mixed; boundary="===============6339676405030795752=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 2/2] modem: Implement ofono_modem_get_sim
Date: Fri, 29 Sep 2017 12:49:08 +0300
Message-ID: <1506678548-8340-2-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1506678548-8340-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6339676405030795752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/modem.c b/src/modem.c
index ac361be..4af0551 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -184,6 +184,11 @@ const char *ofono_modem_get_path(struct ofono_modem *m=
odem)
 	return NULL;
 }
 =

+struct ofono_sim *ofono_modem_get_sim(struct ofono_modem *modem)
+{
+	return __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+}
+
 struct ofono_atom *__ofono_modem_add_atom(struct ofono_modem *modem,
 					enum ofono_atom_type type,
 					void (*destruct)(struct ofono_atom *),
-- =

1.9.1


--===============6339676405030795752==--

