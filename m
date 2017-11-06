Content-Type: multipart/mixed; boundary="===============8733042241839055817=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 5/5] docs: ImsPrivateIdentity property documentation
Date: Mon, 06 Nov 2017 09:49:34 -0800
Message-ID: <1509990574-19950-5-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1509990574-19950-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8733042241839055817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index 01ddc75..bce47c1 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -200,3 +200,8 @@ Properties	boolean Present [readonly]
 			might have changed the retry counters, i.e. calls to
 			ChangePin(), EnterPin(), ResetPin() LockPin(),
 			UnlockPin().
+
+		string ImsPrivateIdentity [readonly, optional]
+
+			Contains the SIM's ImsPrivateIdentity, read from the
+			ISIM.
-- =

2.7.4


--===============8733042241839055817==--

