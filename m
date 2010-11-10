Content-Type: multipart/mixed; boundary="===============7821742668884812715=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3] cbs: CB download must be enabled in SIM service tables.
Date: Wed, 10 Nov 2010 04:27:52 +0100
Message-ID: <1289359672-19206-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1289359672-19206-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7821742668884812715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cbs.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/cbs.c b/src/cbs.c
index 6bd2f69..821985b 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -173,6 +173,7 @@ static void cbs_dispatch_text(struct ofono_cbs *cbs, en=
um sms_class cls,
 void ofono_cbs_notify(struct ofono_cbs *cbs, const unsigned char *pdu,
 				int pdu_len)
 {
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(cbs->atom);
 	struct cbs c;
 	enum sms_class cls;
 	gboolean udhi;
@@ -181,6 +182,7 @@ void ofono_cbs_notify(struct ofono_cbs *cbs, const unsi=
gned char *pdu,
 	enum sms_charset charset;
 	char *message;
 	char iso639_lang[3];
+	struct ofono_atom *sim_atom;
 =

 	if (cbs->assembly =3D=3D NULL)
 		return;
@@ -191,6 +193,17 @@ void ofono_cbs_notify(struct ofono_cbs *cbs, const uns=
igned char *pdu,
 	}
 =

 	if (cbs_topic_in_range(c.message_identifier, cbs->efcbmid_contents)) {
+		sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+
+		if (!sim_atom)
+			return;
+
+		if (!__ofono_sim_service_available(
+					__ofono_atom_get_data(sim_atom),
+					SIM_UST_SERVICE_DATA_DOWNLOAD_SMS_CB,
+					SIM_SST_SERVICE_DATA_DOWNLOAD_SMS_CB))
+			return;
+
 		if (cbs->stk)
 			__ofono_cbs_sim_download(cbs->stk, &c);
 		return;
-- =

1.7.1.86.g0e460.dirty


--===============7821742668884812715==--

