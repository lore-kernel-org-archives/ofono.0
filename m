Content-Type: multipart/mixed; boundary="===============7473948156056881661=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 2/9] emulator: add hsp emulator type
Date: Thu, 17 Mar 2011 19:55:41 +0100
Message-ID: <1300388148-925-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1300388148-925-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7473948156056881661==
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


--===============7473948156056881661==--

