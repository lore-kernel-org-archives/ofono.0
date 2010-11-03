Content-Type: multipart/mixed; boundary="===============5385585356680660889=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isigen: increase offline timeout
Date: Wed, 03 Nov 2010 20:16:22 +0200
Message-ID: <1288808182-15952-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5385585356680660889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The modem deregisters from network before response to MTC_STATE_REQ is
returned. Deregistering can take at least 8 seconds.
---
 plugins/isigen.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/isigen.c b/plugins/isigen.c
index 493d926..014456f 100644
--- a/plugins/isigen.c
+++ b/plugins/isigen.c
@@ -373,7 +373,7 @@ static void isigen_online(struct ofono_modem *modem, of=
ono_bool_t online,
 =

 	isi->online =3D online;
 =

-	if (g_isi_send(isi->client, req, sizeof(req), MTC_TIMEOUT,
+	if (g_isi_send(isi->client, req, sizeof(req), 8 + MTC_TIMEOUT,
 			mtc_state_cb, cbd, NULL))
 		return;
 =

-- =

1.7.1


--===============5385585356680660889==--

