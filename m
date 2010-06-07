Content-Type: multipart/mixed; boundary="===============2520431614526491972=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/20] Fix: download CBS to SIM even when "Powered" is 0
Date: Mon, 07 Jun 2010 12:08:28 +0200
Message-ID: <1275905322-14768-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2520431614526491972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cbs.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/cbs.c b/src/cbs.c
index 27185ba..316573b 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -185,11 +185,6 @@ void ofono_cbs_notify(struct ofono_cbs *cbs, const uns=
igned char *pdu,
 	if (cbs->assembly =3D=3D NULL)
 		return;
 =

-	if (!cbs->powered) {
-		ofono_error("Ignoring CBS because powered is off");
-		return;
-	}
-
 	if (!cbs_decode(pdu, pdu_len, &c)) {
 		ofono_error("Unable to decode CBS PDU");
 		return;
@@ -201,6 +196,11 @@ void ofono_cbs_notify(struct ofono_cbs *cbs, const uns=
igned char *pdu,
 		return;
 	}
 =

+	if (!cbs->powered) {
+		ofono_error("Ignoring CBS because powered is off");
+		return;
+	}
+
 	if (!cbs_dcs_decode(c.dcs, &udhi, &cls, &charset, &comp, NULL, NULL)) {
 		ofono_error("Unknown / Reserved DCS.  Ignoring");
 		return;
-- =

1.7.1.86.g0e460.dirty


--===============2520431614526491972==--

