Content-Type: multipart/mixed; boundary="===============3508690454864325924=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 1/2] modem.h: ofono_modem_set_powered_timeout_hint
Date: Wed, 24 Oct 2018 07:28:09 +0200
Message-ID: <20181024052810.28128-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3508690454864325924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

function to set the powered timeout dynamically.

The function is effective if called before Powered=3Dtrue,
so it is best called in udevng.
If not called, the timeout is set by default to 20 seconds.
---
 include/modem.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/modem.h b/include/modem.h
index bed46c2b..9b12cfad 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -127,6 +127,9 @@ void ofono_modem_driver_unregister(const struct ofono_m=
odem_driver *);
 struct ofono_modem *ofono_modem_find(ofono_modem_compare_cb_t func,
 					void *user_data);
 =

+void ofono_modem_set_powered_timeout_hint(struct ofono_modem *modem,
+							unsigned int seconds);
+
 #ifdef __cplusplus
 }
 #endif
-- =

2.17.1


--===============3508690454864325924==--

