Content-Type: multipart/mixed; boundary="===============0045128931105966169=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [isi-voicecall-fix PATCHv3 5/6] isi/voicecall: release COMING calls
 with BUSY cause
Date: Tue, 16 Nov 2010 19:05:23 +0200
Message-ID: <1289927124-30133-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1289927124-30133-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0045128931105966169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Very early incoming calls were not released with BUSY cause.
---
 drivers/isimodem/voicecall.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 76aa8f5..cdd5d11 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -1220,6 +1220,7 @@ static void isi_release_specific(struct ofono_voiceca=
ll *ovc, int id,
 		uint8_t cause =3D CALL_CAUSE_RELEASE_BY_USER;
 =

 		switch (status->status) {
+		case CALL_STATUS_COMING:
 		case CALL_STATUS_MT_ALERTING:
 		case CALL_STATUS_WAITING:
 			cause =3D CALL_CAUSE_BUSY_USER_REQUEST;
-- =

1.7.1


--===============0045128931105966169==--

