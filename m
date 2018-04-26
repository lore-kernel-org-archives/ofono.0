Content-Type: multipart/mixed; boundary="===============8144172712013770784=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 2/2] modem: Implement ofono_modem_get_gprs
Date: Thu, 26 Apr 2018 17:00:32 +0300
Message-ID: <1524751232-20139-2-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1524751232-20139-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8144172712013770784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/modem.c b/src/modem.c
index 0cee861..9409347 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -189,6 +189,11 @@ struct ofono_sim *ofono_modem_get_sim(struct ofono_mod=
em *modem)
 	return __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
 }
 =

+struct ofono_gprs *ofono_modem_get_gprs(struct ofono_modem *modem)
+{
+	return __ofono_atom_find(OFONO_ATOM_TYPE_GPRS, modem);
+}
+
 struct ofono_atom *__ofono_modem_add_atom(struct ofono_modem *modem,
 					enum ofono_atom_type type,
 					void (*destruct)(struct ofono_atom *),
-- =

1.9.1


--===============8144172712013770784==--

