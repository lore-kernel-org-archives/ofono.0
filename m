Content-Type: multipart/mixed; boundary="===============4233206990507243687=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 1/2] include: Add ofono_modem_get_voicecall
Date: Fri, 29 Jun 2018 16:57:39 +0300
Message-ID: <1530280660-3212-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4233206990507243687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/modem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/modem.h b/include/modem.h
index 005a42e..bed46c2 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -31,6 +31,7 @@ extern "C" {
 struct ofono_modem;
 struct ofono_gprs;
 struct ofono_sim;
+struct ofono_voicecall;
 =

 enum ofono_modem_type {
 	OFONO_MODEM_TYPE_HARDWARE =3D 0,
@@ -84,6 +85,7 @@ void ofono_modem_remove_interface(struct ofono_modem *mod=
em,
 const char *ofono_modem_get_path(struct ofono_modem *modem);
 struct ofono_sim *ofono_modem_get_sim(struct ofono_modem *modem);
 struct ofono_gprs *ofono_modem_get_gprs(struct ofono_modem *modem);
+struct ofono_voicecall *ofono_modem_get_voicecall(struct ofono_modem *mode=
m);
 =

 void ofono_modem_set_data(struct ofono_modem *modem, void *data);
 void *ofono_modem_get_data(struct ofono_modem *modem);
-- =

1.9.1


--===============4233206990507243687==--

