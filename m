Content-Type: multipart/mixed; boundary="===============4109000661760316483=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/6] calypso: Enable AT extended error codes.
Date: Thu, 05 Aug 2010 19:30:55 +0200
Message-ID: <1281029457-9048-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1281029457-9048-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4109000661760316483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The STK driver tries to interpret the codes.
---
 plugins/calypso.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/calypso.c b/plugins/calypso.c
index 7798e10..5367684 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -178,6 +178,8 @@ static void setup_modem(struct ofono_modem *modem)
 		g_at_chat_send(data->dlcs[i], "ATE0", NULL, NULL, NULL, NULL);
 		g_at_chat_send(data->dlcs[i], "AT%CUNS=3D0",
 				NULL, NULL, NULL, NULL);
+		g_at_chat_send(data->dlcs[i], "AT+CMEE=3D1",
+				NULL, NULL, NULL, NULL);
 	}
 =

 	/* CSTAT tells us when SMS & Phonebook are ready to be used */
-- =

1.7.1.86.g0e460.dirty


--===============4109000661760316483==--

