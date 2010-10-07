Content-Type: multipart/mixed; boundary="===============5907348836893507235=="
MIME-Version: 1.0
From: Alexander Kanavin <alexander.kanavin@nokia.com>
Subject: [PATCH 2/3] Fix COLR typo
Date: Thu, 07 Oct 2010 13:50:55 +0300
Message-ID: <1286448656-25186-2-git-send-email-alexander.kanavin@nokia.com>
In-Reply-To: <1286448656-25186-1-git-send-email-alexander.kanavin@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5907348836893507235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-settings.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/call-settings.c b/src/call-settings.c
index f206e7b..23da47e 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -551,7 +551,7 @@ static void clip_colp_colr_ss_query_cb(const struct ofo=
no_error *error,
 	case CALL_SETTING_TYPE_COLR:
 		set_colr(cs, status);
 		value =3D colr_status_to_string(status);
-		context =3D "CallingLineRestriction";
+		context =3D "CalledLineRestriction";
 		break;
 =

 	default:
-- =

1.7.0.4


--===============5907348836893507235==--

