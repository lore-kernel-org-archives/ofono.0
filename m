Content-Type: multipart/mixed; boundary="===============3596410668998747722=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 3/5] hsp_ag: add hsp emulator type
Date: Mon, 14 Mar 2011 16:49:19 +0100
Message-ID: <1300117761-6181-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1300117761-6181-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3596410668998747722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 71b7c24..e010606 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -42,6 +42,7 @@ struct ofono_emulator_request;
 enum ofono_emulator_type {
 	OFONO_EMULATOR_TYPE_DUN,
 	OFONO_EMULATOR_TYPE_HFP,
+	OFONO_EMULATOR_TYPE_HSP,
 };
 =

 enum ofono_emulator_request_type {
-- =

1.7.1


--===============3596410668998747722==--

