Content-Type: multipart/mixed; boundary="===============7820240301347025787=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 2/2] modem: Implement ofono_modem_get_voicecall
Date: Fri, 29 Jun 2018 16:57:40 +0300
Message-ID: <1530280660-3212-2-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1530280660-3212-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7820240301347025787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/modem.c b/src/modem.c
index 9409347..9e25448 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -194,6 +194,11 @@ struct ofono_gprs *ofono_modem_get_gprs(struct ofono_m=
odem *modem)
 	return __ofono_atom_find(OFONO_ATOM_TYPE_GPRS, modem);
 }
 =

+struct ofono_voicecall *ofono_modem_get_voicecall(struct ofono_modem *mode=
m)
+{
+	return __ofono_atom_find(OFONO_ATOM_TYPE_VOICECALL, modem);
+}
+
 struct ofono_atom *__ofono_modem_add_atom(struct ofono_modem *modem,
 					enum ofono_atom_type type,
 					void (*destruct)(struct ofono_atom *),
-- =

1.9.1


--===============7820240301347025787==--

