Content-Type: multipart/mixed; boundary="===============2217108154851590749=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 06/12] gatchat:new hint to handle +CPOS
Date: Fri, 11 Mar 2011 14:23:03 +0200
Message-ID: <1299846189-15132-7-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1299846189-15132-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2217108154851590749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatsyntax.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatsyntax.h b/gatchat/gatsyntax.h
index afc0bd3..2580ec6 100644
--- a/gatchat/gatsyntax.h
+++ b/gatchat/gatsyntax.h
@@ -29,7 +29,8 @@ extern "C" {
 enum _GAtSyntaxExpectHint {
 	G_AT_SYNTAX_EXPECT_PDU,
 	G_AT_SYNTAX_EXPECT_MULTILINE,
-	G_AT_SYNTAX_EXPECT_PROMPT
+	G_AT_SYNTAX_EXPECT_PROMPT,
+	G_AT_SYNTAX_EXPECT_SHORT_PROMPT
 };
 =

 typedef enum _GAtSyntaxExpectHint GAtSyntaxExpectHint;
-- =

1.7.0.4


--===============2217108154851590749==--

