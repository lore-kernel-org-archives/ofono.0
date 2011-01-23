Content-Type: multipart/mixed; boundary="===============7978392217106140405=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: [PATCH 7/7] stemodem: Phone type defined using enum called_number_type
Date: Sun, 23 Jan 2011 11:21:47 +0100
Message-ID: <1295778107-20035-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7978392217106140405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index ad505ff..709a869 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -192,7 +192,7 @@ static void ste_dial(struct ofono_voicecall *vc,
 =

 	cbd->user =3D vc;
 =

-	if (ph->type =3D=3D 145)
+	if (ph->type =3D=3D CALLED_NUMBER_TYPE_INTERNATIONAL)
 		snprintf(buf, sizeof(buf), "ATD+%s", ph->number);
 	else
 		snprintf(buf, sizeof(buf), "ATD%s", ph->number);
-- =

1.5.6.5


--===============7978392217106140405==--

