Content-Type: multipart/mixed; boundary="===============4971664987223849675=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH] cdmamodem: fix to follow oFono probe rules
Date: Fri, 14 Jan 2011 12:25:52 -0800
Message-ID: <1295036752-23114-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4971664987223849675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Not allowed to call register directly from probe, use g_idle_add
instead for now
---
 drivers/cdmamodem/voicecall.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/cdmamodem/voicecall.c b/drivers/cdmamodem/voicecall.c
index a0fa79f..94ec74b 100644
--- a/drivers/cdmamodem/voicecall.c
+++ b/drivers/cdmamodem/voicecall.c
@@ -109,6 +109,15 @@ static void cdma_hangup(struct ofono_cdma_voicecall *v=
c,
 	cdma_template("AT+CHV", vc, cdma_hangup_cb, cb, data);
 }
 =

+static gboolean cdma_voicecall_initialized(gpointer user_data)
+{
+	struct ofono_cdma_voicecall *vc =3D user_data;
+
+	ofono_cdma_voicecall_register(vc);
+
+	return FALSE;
+}
+
 static int cdma_voicecall_probe(struct ofono_cdma_voicecall *vc,
 					unsigned int vendor, void *data)
 {
@@ -123,8 +132,7 @@ static int cdma_voicecall_probe(struct ofono_cdma_voice=
call *vc,
 	vd->vendor =3D vendor;
 =

 	ofono_cdma_voicecall_set_data(vc, vd);
-
-	ofono_cdma_voicecall_register(vc);
+	g_idle_add(cdma_voicecall_initialized, vc);
 =

 	return 0;
 }
-- =

1.7.0.4


--===============4971664987223849675==--

