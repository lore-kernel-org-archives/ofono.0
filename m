Content-Type: multipart/mixed; boundary="===============7504025372683893028=="
MIME-Version: 1.0
From: Alexander Kanavin <alexander.kanavin@nokia.com>
Subject: [PATCH 1/3] Fix typo in SS enum to string conversion
Date: Thu, 07 Oct 2010 13:50:54 +0300
Message-ID: <1286448656-25186-1-git-send-email-alexander.kanavin@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7504025372683893028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/common.c b/src/common.c
index 55c4b40..bcd42f6 100644
--- a/src/common.c
+++ b/src/common.c
@@ -438,7 +438,7 @@ const char *ss_control_type_to_string(enum ss_control_t=
ype type)
 {
 	switch (type) {
 	case SS_CONTROL_TYPE_ACTIVATION:
-		return "acivation";
+		return "activation";
 	case SS_CONTROL_TYPE_REGISTRATION:
 		return "registration";
 	case SS_CONTROL_TYPE_QUERY:
-- =

1.7.0.4


--===============7504025372683893028==--

