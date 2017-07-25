Content-Type: multipart/mixed; boundary="===============2100744381819910024=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 4/5] voicecall.h: declare struct ofono_modem
Date: Tue, 25 Jul 2017 15:26:23 +0200
Message-ID: <20170725132624.32293-4-lynxis@fe80.eu>
In-Reply-To: <20170725132624.32293-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2100744381819910024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a warning when only voicecall.h is included:
'struct ofono_modem declared' inside parameter list will not be visible
outside of this definition or declaration struct ofono_voicecall
*ofono_voicecall_create(struct ofono_modem *modem,...
---
 include/voicecall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/voicecall.h b/include/voicecall.h
index 4d0b3886..eb897e5e 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -28,6 +28,7 @@ extern "C" {
 =

 #include <ofono/types.h>
 =

+struct ofono_modem;
 struct ofono_voicecall;
 =

 typedef void (*ofono_voicecall_cb_t)(const struct ofono_error *error,
-- =

2.13.3


--===============2100744381819910024==--

