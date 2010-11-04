Content-Type: multipart/mixed; boundary="===============0918429488617321835=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCHv2] isigen: increase offline timeout
Date: Thu, 04 Nov 2010 16:20:49 +0200
Message-ID: <1288880449-13207-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0918429488617321835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The modem deregisters from network before response to MTC_STATE_REQ is
returned.  Deregistering can take up to 6 seconds.
---
 drivers/isimodem/mtc.h |    1 +
 plugins/isigen.c       |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/isimodem/mtc.h b/drivers/isimodem/mtc.h
index 2a5754f..4f452e7 100644
--- a/drivers/isimodem/mtc.h
+++ b/drivers/isimodem/mtc.h
@@ -28,6 +28,7 @@ extern "C" {
 =

 #define PN_MTC			0x15
 #define MTC_TIMEOUT		5
+#define MTC_STATE_REQ_TIMEOUT   (6 + 5)
 =

 enum mtc_isi_cause {
 	MTC_OK =3D 0x00,
diff --git a/plugins/isigen.c b/plugins/isigen.c
index 493d926..838d060 100644
--- a/plugins/isigen.c
+++ b/plugins/isigen.c
@@ -373,7 +373,7 @@ static void isigen_online(struct ofono_modem *modem, of=
ono_bool_t online,
 =

 	isi->online =3D online;
 =

-	if (g_isi_send(isi->client, req, sizeof(req), MTC_TIMEOUT,
+	if (g_isi_send(isi->client, req, sizeof(req), MTC_STATE_REQ_TIMEOUT,
 			mtc_state_cb, cbd, NULL))
 		return;
 =

-- =

1.7.1


--===============0918429488617321835==--

