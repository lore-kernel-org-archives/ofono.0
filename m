Content-Type: multipart/mixed; boundary="===============0066739311418328630=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isiusb: wait for MTC transitions, too
Date: Mon, 18 Apr 2011 16:24:52 +0300
Message-ID: <1303133092-8913-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0066739311418328630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/isiusb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/isiusb.c b/plugins/isiusb.c
index ad24fc9..82d2cc5 100644
--- a/plugins/isiusb.c
+++ b/plugins/isiusb.c
@@ -352,7 +352,7 @@ static void mtc_state_cb(const GIsiMessage *msg, void *=
data)
 =

 	DBG("MTC cause: %s (0x%02X)", mtc_isi_cause_name(cause), cause);
 =

-	if (cause =3D=3D MTC_OK) {
+	if (cause =3D=3D MTC_OK || cause =3D=3D MTC_STATE_TRANSITION_GOING_ON) {
 		isi->online_cbd =3D cbd;
 		return;
 	}
-- =

1.7.1


--===============0066739311418328630==--

