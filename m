Content-Type: multipart/mixed; boundary="===============3283467112714777865=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 04/10] test-stkutil: add html attribute tests for
 get_inkey_test
Date: Thu, 01 Jul 2010 08:31:19 -0700
Message-ID: <1277998285-30207-5-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1277998285-30207-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3283467112714777865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   69 +++++++++++++++++++++++++++++++++++++++--------=
----
 1 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index bc0e018..3b19227 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -964,6 +964,7 @@ struct get_inkey_test {
 	struct stk_duration duration;
 	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
+	char *html;
 };
 =

 static unsigned char get_inkey_111[] =3D { 0xD0, 0x15, 0x81, 0x03, 0x01, 0=
x22,
@@ -1569,7 +1570,9 @@ static struct get_inkey_test get_inkey_data_911 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter \"+\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_912 =3D {
@@ -1587,7 +1590,10 @@ static struct get_inkey_test get_inkey_data_921 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x01, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: center;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Enter \"+\"</span>"
+		"</div>",
 };
 =

 static struct get_inkey_test get_inkey_data_922 =3D {
@@ -1605,7 +1611,10 @@ static struct get_inkey_test get_inkey_data_931 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x02, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: right;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Enter \"+\"</span>"
+		"</div>",
 };
 =

 static struct get_inkey_test get_inkey_data_932 =3D {
@@ -1623,7 +1632,9 @@ static struct get_inkey_test get_inkey_data_941 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x04, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-size: big;color: #347235;"
+		"background-color: #FFFF00;\">Enter \"+\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_942 =3D {
@@ -1634,7 +1645,9 @@ static struct get_inkey_test get_inkey_data_942 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter \"#\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_943 =3D {
@@ -1652,7 +1665,9 @@ static struct get_inkey_test get_inkey_data_951 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x08, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-size: small;color: #347235;"
+		"background-color: #FFFF00;\">Enter \"+\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_952 =3D {
@@ -1663,7 +1678,9 @@ static struct get_inkey_test get_inkey_data_952 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter \"#\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_953 =3D {
@@ -1681,7 +1698,9 @@ static struct get_inkey_test get_inkey_data_961 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x10, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-weight: bold;color: #347235;"
+		"background-color: #FFFF00;\">Enter \"+\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_962 =3D {
@@ -1692,7 +1711,9 @@ static struct get_inkey_test get_inkey_data_962 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter \"#\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_963 =3D {
@@ -1710,7 +1731,9 @@ static struct get_inkey_test get_inkey_data_971 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x20, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-style: italic;color: #347235;"
+		"background-color: #FFFF00;\">Enter \"+\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_972 =3D {
@@ -1721,7 +1744,9 @@ static struct get_inkey_test get_inkey_data_972 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter \"#\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_973 =3D {
@@ -1739,7 +1764,9 @@ static struct get_inkey_test get_inkey_data_981 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x40, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"text-decoration: underline;color: #347235;"
+		"background-color: #FFFF00;\">Enter \"+\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_982 =3D {
@@ -1750,7 +1777,9 @@ static struct get_inkey_test get_inkey_data_982 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter \"#\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_983 =3D {
@@ -1768,7 +1797,9 @@ static struct get_inkey_test get_inkey_data_991 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x80, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"text-decoration: line-through;color: #347235;"
+		"background-color: #FFFF00;\">Enter \"+\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_992a =3D {
@@ -1779,7 +1810,9 @@ static struct get_inkey_test get_inkey_data_992a =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter \"#\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_992b =3D {
@@ -1804,7 +1837,9 @@ static struct get_inkey_test get_inkey_data_9101 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x09, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter \"+\"</span>",
 };
 =

 static struct get_inkey_test get_inkey_data_9102 =3D {
@@ -1886,6 +1921,8 @@ static void test_get_inkey(gconstpointer data)
 	check_duration(&command->get_inkey.duration, &test->duration);
 	check_text_attr(&command->get_inkey.text_attr,
 						&test->text_attr);
+	check_text_attr_html(&command->get_inkey.text_attr,
+				command->get_inkey.text, test->html);
 	check_frame_id(&command->get_inkey.frame_id, &test->frame_id);
 =

 	stk_command_free(command);
-- =

1.6.6.1


--===============3283467112714777865==--

