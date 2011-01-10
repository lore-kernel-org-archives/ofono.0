Content-Type: multipart/mixed; boundary="===============8572235139562864716=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 1/5] types: add tty flag to ofono_call
Date: Mon, 10 Jan 2011 16:01:28 +0200
Message-ID: <1294668092-27896-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294668092-27896-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8572235139562864716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/types.h b/include/types.h
index 9fd174d..caf148c 100644
--- a/include/types.h
+++ b/include/types.h
@@ -98,6 +98,7 @@ struct ofono_call {
 	int direction;
 	int status;
 	ofono_bool_t mpty;
+	ofono_bool_t tty;
 	struct ofono_phone_number phone_number;
 	char name[OFONO_MAX_CALLER_NAME_LENGTH + 1];
 	int clip_validity;
-- =

1.7.0.4


--===============8572235139562864716==--

