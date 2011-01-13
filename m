Content-Type: multipart/mixed; boundary="===============3010911664663575335=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/2] include: remove unused mpty from ofono_call
Date: Thu, 13 Jan 2011 10:29:57 -0800
Message-ID: <1294943397-27551-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294943397-27551-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3010911664663575335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/types.h b/include/types.h
index 9fd174d..1b95eaa 100644
--- a/include/types.h
+++ b/include/types.h
@@ -97,7 +97,6 @@ struct ofono_call {
 	int type;
 	int direction;
 	int status;
-	ofono_bool_t mpty;
 	struct ofono_phone_number phone_number;
 	char name[OFONO_MAX_CALLER_NAME_LENGTH + 1];
 	int clip_validity;
-- =

1.7.0.4


--===============3010911664663575335==--

