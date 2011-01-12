Content-Type: multipart/mixed; boundary="===============5735524845698625669=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [gisi-notify-fix PATCH 4/4] isimodem: fix crash in gprs
Date: Wed, 12 Jan 2011 21:24:12 +0200
Message-ID: <1294860252-29570-5-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1294860252-29570-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5735524845698625669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

There was a crash if gprs was removed while creating context.
---
 drivers/isimodem/gprs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index e614ac9..1550f24 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -199,6 +199,9 @@ static void info_pp_read_resp_cb(const GIsiMessage *msg=
, void *opaque)
 	uint8_t count =3D GPDS_MAX_CONTEXT_COUNT;
 	GIsiSubBlockIter iter;
 =

+	if (g_isi_msg_error(msg) =3D=3D -ESHUTDOWN)
+		return;
+
 	if (g_isi_msg_error(msg) < 0)
 		goto out;
 =

-- =

1.7.1


--===============5735524845698625669==--

