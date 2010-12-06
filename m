Content-Type: multipart/mixed; boundary="===============5490160992680864892=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 07/14] doc: add Name property
Date: Mon, 06 Dec 2010 18:12:35 -0200
Message-ID: <1291666362-19128-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291666362-19128-6-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5490160992680864892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/voicecall-api.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index f0ba316..a0242ab 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -87,6 +87,11 @@ Properties	string LineIdentification [readonly]
 			"override category" option was not provisioned for
 			the current subscriber.
 =

+		string Name [readonly]
+
+			Contains the Name Identification information returned
+			by the network, if present.
+
 		boolean Multiparty [readonly]
 =

 			Contains the indication if the voice call is part
-- =

1.7.3.2


--===============5490160992680864892==--

