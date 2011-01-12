Content-Type: multipart/mixed; boundary="===============7674911825148063463=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 4/9] doc: add CalledLineIdentification property to voicecall
Date: Wed, 12 Jan 2011 09:27:42 -0200
Message-ID: <1294831667-7447-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294831667-7447-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7674911825148063463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/voicecall-api.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index 4f38e6a..7971fe6 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -87,6 +87,15 @@ Properties	string LineIdentification [readonly]
 			"override category" option was not provisioned for
 			the current subscriber.
 =

+		string CalledLineIdentification [readonly]
+
+			Contains the Called Line Identification information
+			returned by the network. This is only available for
+			incoming calls, in which it indicates the dialed number
+			to make this call. This is useful for subscribers
+			associated to multiple identifications to differentiate
+			the calls received by each one.
+
 		string Name [readonly]
 =

 			Contains the Name Identification information returned
-- =

1.7.3.5


--===============7674911825148063463==--

