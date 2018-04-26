Content-Type: multipart/mixed; boundary="===============3885155926716511142=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 1/2] include: Add ofono_modem_get_gprs
Date: Thu, 26 Apr 2018 17:00:31 +0300
Message-ID: <1524751232-20139-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3885155926716511142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/modem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/modem.h b/include/modem.h
index c93b3d2..005a42e 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -29,6 +29,7 @@ extern "C" {
 #include <ofono/types.h>
 =

 struct ofono_modem;
+struct ofono_gprs;
 struct ofono_sim;
 =

 enum ofono_modem_type {
@@ -82,6 +83,7 @@ void ofono_modem_remove_interface(struct ofono_modem *mod=
em,
 =

 const char *ofono_modem_get_path(struct ofono_modem *modem);
 struct ofono_sim *ofono_modem_get_sim(struct ofono_modem *modem);
+struct ofono_gprs *ofono_modem_get_gprs(struct ofono_modem *modem);
 =

 void ofono_modem_set_data(struct ofono_modem *modem, void *data);
 void *ofono_modem_get_data(struct ofono_modem *modem);
-- =

1.9.1


--===============3885155926716511142==--

