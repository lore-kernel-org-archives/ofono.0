Content-Type: multipart/mixed; boundary="===============8442549333592696881=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/5] drivers: fix misspellings
Date: Tue, 01 Feb 2011 15:32:50 -0200
Message-ID: <1296581572-3697-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296581572-3697-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8442549333592696881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/sms.c       |    2 +-
 drivers/isimodem/voicecall.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index ded7d9c..3529b59 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -215,7 +215,7 @@ static void sca_query_resp_cb(const GIsiMessage *msg, v=
oid *data)
 	memcpy(sd->params.alpha, info->alpha, sizeof(sd->params.alpha));
 =

 	/*
-	 * Bitmask indicating absense of parameters --
+	 * Bitmask indicating absence of parameters --
 	 * If second bit is set it indicates that the SCA is absent
 	 */
 	if (info->absent & 0x2)
diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 6a1e582..a4ab0c1 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -842,7 +842,7 @@ static struct isi_call_req_ctx *isi_call_deflect_req(st=
ruct ofono_voicecall *ovc
 		4,		/* Sub-block length */
 		CALL_GSM_OP_DEFLECT, 0,
 		CALL_GSM_DEFLECTION_ADDRESS,
-		sub_len,	/* Sub-block lenght */
+		sub_len,	/* Sub-block length */
 		address_type & 0x7F,
 		0x7,		/* Default presentation */
 		0,		/* Filler */
-- =

1.7.4


--===============8442549333592696881==--

