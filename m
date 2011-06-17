Content-Type: multipart/mixed; boundary="===============6735729910338713150=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] call-settings: fix typo
Date: Fri, 17 Jun 2011 15:09:12 +0200
Message-ID: <1308316152-28974-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6735729910338713150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-settings.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index 2d68adc..692d3b4 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -733,7 +733,7 @@ static void clir_ss_query_callback(const struct ofono_e=
rror *error,
 =

 	switch (network) {
 	case CLIR_STATUS_UNKNOWN:
-		value =3D "uknown";
+		value =3D "unknown";
 		break;
 =

 	case CLIR_STATUS_PROVISIONED_PERMANENT:
-- =

1.7.1


--===============6735729910338713150==--

