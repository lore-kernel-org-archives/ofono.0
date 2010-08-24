Content-Type: multipart/mixed; boundary="===============4626570301608244058=="
MIME-Version: 1.0
From: Yong Su <yong.su@windriver.com>
Subject: [PATCH 4/4] Support text mode sms sending and receiving
Date: Tue, 24 Aug 2010 14:36:08 +0800
Message-ID: <1282631768-15935-1-git-send-email-yong.su@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4626570301608244058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatsyntax.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatsyntax.h b/gatchat/gatsyntax.h
index d76cf6f..3693db1 100644
--- a/gatchat/gatsyntax.h
+++ b/gatchat/gatsyntax.h
@@ -57,6 +57,7 @@ struct _GAtSyntax {
 	int state;
 	GAtSyntaxSetHintFunc set_hint;
 	GAtSyntaxFeedFunc feed;
+	int expect_msg_len;
 };
 =

 =

-- =

1.6.3.3


--===============4626570301608244058==--

