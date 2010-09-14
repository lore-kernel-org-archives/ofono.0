Content-Type: multipart/mixed; boundary="===============2596207094941971459=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 2/2] unit: national to international conversion
Date: Tue, 14 Sep 2010 20:38:46 +0300
Message-ID: <1284485926-5255-2-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1284485926-5255-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2596207094941971459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-sms.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/unit/test-sms.c b/unit/test-sms.c
index 0ff9cd5..96b9b50 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -1316,6 +1316,23 @@ static void test_sr_assembly()
 =

 	g_assert(id =3D=3D 42);
 	g_assert(delivered =3D=3D TRUE);
+	g_assert(g_hash_table_size(sra->assembly_table) =3D=3D 0);
+
+	/*
+	 * Send sms-message in the national address-format,
+	 * but receive in the international address-format.
+	 */
+	sms_address_from_string(&addr, "9911630");
+	status_report_assembly_add_fragment(sra, 42, &addr, 4, time(NULL), 2);
+	status_report_assembly_add_fragment(sra, 42, &addr, 5, time(NULL), 2);
+
+	g_assert(!status_report_assembly_report(sra, &sr1, &id, &delivered));
+	g_assert(status_report_assembly_report(sra, &sr2, &id, &delivered));
+
+	g_assert(id =3D=3D 42);
+	g_assert(delivered =3D=3D TRUE);
+	g_assert(g_hash_table_size(sra->assembly_table) =3D=3D 0);
+
 	status_report_assembly_free(sra);
 }
 =

-- =

1.6.3.3



--===============2596207094941971459==--

