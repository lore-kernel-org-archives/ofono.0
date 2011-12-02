Content-Type: multipart/mixed; boundary="===============7171571369116740472=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 4/9] gprs-provision: Fix crash if no SPN present
Date: Fri, 02 Dec 2011 13:10:32 +0200
Message-ID: <1322824237-10039-5-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322824237-10039-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7171571369116740472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 examples/provision.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/examples/provision.c b/examples/provision.c
index 546a161..3f9d124 100644
--- a/examples/provision.c
+++ b/examples/provision.c
@@ -49,7 +49,7 @@ static int example_provision_get_settings(const char *mcc=
, const char *mnc,
 			mcc, mnc, spn);
 =

 	if (strcmp(mcc, "246") !=3D 0 || strcmp(mnc, "81") !=3D 0 ||
-						strcmp(spn, "oFono") !=3D 0)
+						g_strcmp0(spn, "oFono") !=3D 0)
 		return -ENOENT;
 =

 	ofono_debug("Creating example settings for phonesim");
-- =

1.7.5.4


--===============7171571369116740472==--

