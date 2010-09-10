Content-Type: multipart/mixed; boundary="===============2442974794600194449=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH v2 2/4] unit: Add unit test for status report expiration
Date: Fri, 10 Sep 2010 17:28:20 +0300
Message-ID: <1284128902-16727-2-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1284128902-16727-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2442974794600194449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-sms.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/unit/test-sms.c b/unit/test-sms.c
index d56cdce..0ff9cd5 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -1301,6 +1301,13 @@ static void test_sr_assembly()
 	sms_address_from_string(&addr, "+4915259911630");
 =

 	sra =3D status_report_assembly_new(NULL);
+
+	status_report_assembly_add_fragment(sra, 42, &addr, 4, time(NULL), 2);
+	status_report_assembly_add_fragment(sra, 42, &addr, 5, time(NULL), 2);
+
+	status_report_assembly_expire(sra, time(NULL) + 40);
+	g_assert(g_hash_table_size(sra->assembly_table) =3D=3D 0);
+
 	status_report_assembly_add_fragment(sra, 42, &addr, 4, time(NULL), 2);
 	status_report_assembly_add_fragment(sra, 42, &addr, 5, time(NULL), 2);
 =

-- =

1.6.3.3



--===============2442974794600194449==--

