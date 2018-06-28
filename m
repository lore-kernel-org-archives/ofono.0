Content-Type: multipart/mixed; boundary="===============6875538612202243734=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 2/3] emulator: Handle OFONO_ERROR_TYPE_ERRNO in switch
Date: Thu, 28 Jun 2018 19:30:59 +0300
Message-ID: <1530203460-20552-2-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1530203460-20552-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6875538612202243734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/emulator.c b/src/emulator.c
index ccb26dc..b3afb3d 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -1347,6 +1347,7 @@ void ofono_emulator_send_final(struct ofono_emulator =
*em,
 	case OFONO_ERROR_TYPE_CEER:
 	case OFONO_ERROR_TYPE_SIM:
 	case OFONO_ERROR_TYPE_FAILURE:
+	case OFONO_ERROR_TYPE_ERRNO:
 failure:
 		g_at_server_send_final(em->server, G_AT_SERVER_RESULT_ERROR);
 		break;
-- =

1.9.1


--===============6875538612202243734==--

