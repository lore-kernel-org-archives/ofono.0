Content-Type: multipart/mixed; boundary="===============7937950647627556839=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH 1/2] types: extend OFONO_MAX_PHONE_NUMBER_LENGTH
Date: Tue, 25 Jan 2011 11:02:37 -0300
Message-ID: <1295964158-19223-2-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1295964158-19223-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7937950647627556839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/types.h b/include/types.h
index 7963e0f..71d0988 100644
--- a/include/types.h
+++ b/include/types.h
@@ -76,7 +76,7 @@ struct ofono_error {
 	int error;
 };
 =

-#define OFONO_MAX_PHONE_NUMBER_LENGTH 20
+#define OFONO_MAX_PHONE_NUMBER_LENGTH 80
 #define OFONO_MAX_CALLER_NAME_LENGTH 80
 =

 struct ofono_phone_number {
-- =

1.7.2.3


--===============7937950647627556839==--

