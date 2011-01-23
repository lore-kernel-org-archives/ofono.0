Content-Type: multipart/mixed; boundary="===============8865819365846143754=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: [PATCH 4/7] hfpmodem: Phone type defined using enum called_number_type
Date: Sun, 23 Jan 2011 11:16:33 +0100
Message-ID: <1295777796-19978-5-git-send-email-george@matveev.se>
In-Reply-To: <1295777796-19978-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8865819365846143754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index d4d370e..9481545 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -366,7 +366,7 @@ static void hfp_dial(struct ofono_voicecall *vc,
 		goto error;
 =

 	cbd->user =3D vc;
-	if (ph->type =3D=3D 145)
+	if (ph->type =3D=3D CALLED_NUMBER_TYPE_INTERNATIONAL)
 		snprintf(buf, sizeof(buf), "ATD+%s", ph->number);
 	else
 		snprintf(buf, sizeof(buf), "ATD%s", ph->number);
-- =

1.5.6.5


--===============8865819365846143754==--

