Content-Type: multipart/mixed; boundary="===============4911090713038839822=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 4/9] test-stkutil: add html attribute tests for get_inkey_test
Date: Fri, 02 Jul 2010 06:46:03 -0700
Message-ID: <1278078368-32565-5-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1278078368-32565-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4911090713038839822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   69 +++++++++++++++++++++++++++++++++++++++--------=
----
 1 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 6f781ed..e48ab0d 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -977,6 +977,7 @@ struct get_inkey_test {
 	struct stk_duration duration;
 	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
+	char *html;
 };
 =

 static unsigned char get_inkey_111[] =3D { 0xD0, 0x15, 0x81, 0x03, 0x01, 0=
x22,
@@ -1582,7 +1583,9 @@ static struct get_inkey_test get_inkey_data_911 =3D {
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
@@ -1600,7 +1603,10 @@ static struct get_inkey_test get_inkey_data_921 =3D {
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
@@ -1618,7 +1624,10 @@ static struct get_inkey_test get_inkey_data_931 =3D {
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
@@ -1636,7 +1645,9 @@ static struct get_inkey_test get_inkey_data_941 =3D {
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
@@ -1647,7 +1658,9 @@ static struct get_inkey_test get_inkey_data_942 =3D {
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
@@ -1665,7 +1678,9 @@ static struct get_inkey_test get_inkey_data_951 =3D {
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
@@ -1676,7 +1691,9 @@ static struct get_inkey_test get_inkey_data_952 =3D {
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
@@ -1694,7 +1711,9 @@ static struct get_inkey_test get_inkey_data_961 =3D {
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
@@ -1705,7 +1724,9 @@ static struct get_inkey_test get_inkey_data_962 =3D {
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
@@ -1723,7 +1744,9 @@ static struct get_inkey_test get_inkey_data_971 =3D {
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
@@ -1734,7 +1757,9 @@ static struct get_inkey_test get_inkey_data_972 =3D {
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
@@ -1752,7 +1777,9 @@ static struct get_inkey_test get_inkey_data_981 =3D {
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
@@ -1763,7 +1790,9 @@ static struct get_inkey_test get_inkey_data_982 =3D {
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
@@ -1781,7 +1810,9 @@ static struct get_inkey_test get_inkey_data_991 =3D {
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
@@ -1792,7 +1823,9 @@ static struct get_inkey_test get_inkey_data_992a =3D {
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
@@ -1817,7 +1850,9 @@ static struct get_inkey_test get_inkey_data_9101 =3D {
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
@@ -1899,6 +1934,8 @@ static void test_get_inkey(gconstpointer data)
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


--===============4911090713038839822==--

