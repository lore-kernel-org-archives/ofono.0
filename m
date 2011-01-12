Content-Type: multipart/mixed; boundary="===============1490520348614554400=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/9] include: add cdip field in ofono_call
Date: Wed, 12 Jan 2011 09:27:39 -0200
Message-ID: <1294831667-7447-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294831667-7447-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1490520348614554400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/types.h b/include/types.h
index 9fd174d..769b8f0 100644
--- a/include/types.h
+++ b/include/types.h
@@ -99,6 +99,7 @@ struct ofono_call {
 	int status;
 	ofono_bool_t mpty;
 	struct ofono_phone_number phone_number;
+	struct ofono_phone_number called_number;
 	char name[OFONO_MAX_CALLER_NAME_LENGTH + 1];
 	int clip_validity;
 	int cnap_validity;
-- =

1.7.3.5


--===============1490520348614554400==--

