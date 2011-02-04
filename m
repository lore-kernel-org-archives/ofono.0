Content-Type: multipart/mixed; boundary="===============0235058476772874604=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 5/5] stemodem: Use defined call_status enum
Date: Fri, 04 Feb 2011 12:35:43 -0800
Message-ID: <1296851743-14483-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296851743-14483-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0235058476772874604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/voicecall.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 4a3a83d..3ca106e 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -356,7 +356,8 @@ static void ste_deflect(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	char buf[128];
-	unsigned int incoming_or_waiting =3D (0x1 << 4) | (0x1 << 5);
+	unsigned int incoming_or_waiting =3D
+		(0x1 << CALL_STATUS_INCOMING) | (0x1 << CALL_STATUS_WAITING);
 =

 	snprintf(buf, sizeof(buf), "AT+CTFR=3D\"%s\",%d", ph->number, ph->type);
 	ste_template(buf, vc, ste_generic_cb, incoming_or_waiting, cb, data);
-- =

1.7.0.4


--===============0235058476772874604==--

