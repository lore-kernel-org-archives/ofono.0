Content-Type: multipart/mixed; boundary="===============8199611699210627822=="
MIME-Version: 1.0
From: martin.xu@intel.com
Subject: [PATCH] Fix compile warning at MeeGo The gcc version is MeeGo 4.5.1
Date: Thu, 06 Jan 2011 17:46:11 +0800
Message-ID: <1294307171-13485-1-git-send-email-martin.xu@intel.com>
In-Reply-To: <martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8199611699210627822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: blutolan <blutolan@blutolan-desktop.(none)>

---
 src/call-forwarding.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 512f223..36ba4f1 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -246,7 +246,7 @@ static gboolean is_cfu_enabled(struct ofono_call_forwar=
ding *cf,
 static void sim_set_cf_indicator(struct ofono_call_forwarding *cf)
 {
 	gboolean cfu_voice;
-	struct ofono_call_forwarding_condition *cond;
+	struct ofono_call_forwarding_condition *cond =3D NULL;
 =

 	cfu_voice =3D is_cfu_enabled(cf, &cond);
 =

-- =

1.7.2.2


--===============8199611699210627822==--

