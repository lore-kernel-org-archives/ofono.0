Content-Type: multipart/mixed; boundary="===============3417805708043507768=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 14/19] sms: document SMS Message's D-Bus 'To' property
Date: Tue, 03 Aug 2010 16:51:03 -0700
Message-ID: <f2f3dfd96de48791c19fdf8cdec468c361b1d87c.1280879410.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1280879410.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3417805708043507768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 doc/sms-api.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/doc/sms-api.txt b/doc/sms-api.txt
index 2bf588f..70eb492 100644
--- a/doc/sms-api.txt
+++ b/doc/sms-api.txt
@@ -109,3 +109,8 @@ Properties	string State
 =

 			Current transmission state {queued, wsr, done,
 			canceling, cancelled, failed, expired}
+
+		string To
+
+			Destination number to which the message is
+			being sent.
-- =

1.6.6.1


--===============3417805708043507768==--

