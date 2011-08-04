Content-Type: multipart/mixed; boundary="===============5563600377088731238=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] speedup: blacklist the NO CARRIER terminator for control
 channel
Date: Thu, 04 Aug 2011 18:13:05 +0200
Message-ID: <1312474385-6381-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5563600377088731238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some Speedup cards will send the NO CARRIER in the control channel.
---
 plugins/speedup.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/speedup.c b/plugins/speedup.c
index 0142ece..12ff501 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -182,6 +182,9 @@ static int speedup_enable(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

+	g_at_chat_blacklist_terminator(data->aux,
+					G_AT_CHAT_TERMINATOR_NO_CARRIER);
+
 	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
 =

-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============5563600377088731238==--

