Content-Type: multipart/mixed; boundary="===============3226355827599104899=="
MIME-Version: 1.0
From: Mark van der Putten <mark.van.der.putten@intemo.com>
Subject: [PATCH] Signal sim initialized for gemalto plugin
Date: Thu, 19 Apr 2018 17:54:26 +0200
Message-ID: <1524153266-24388-1-git-send-email-mark.van.der.putten@intemo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3226355827599104899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Modem type PLS8-E, firmware 03.017
---
 plugins/gemalto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index af02403..ec8174d 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -204,6 +204,11 @@ static void gemalto_ciev_notify(GAtResult *result, gpo=
inter user_data)
 					NULL);
 		break;
 =

+	/* USIM initialization completed. UE has finished reading USIM data. */
+	case 5:
+	        ofono_sim_initialized_notify(sim);
+		break;
+
 	default:
 		break;
 	}
-- =

2.1.4


--===============3226355827599104899==--

