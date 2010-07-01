Content-Type: multipart/mixed; boundary="===============1861159641799069945=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 05/10] test-stkutil: add html attribute tests for
 get_input_test
Date: Thu, 01 Jul 2010 08:31:20 -0700
Message-ID: <1277998285-30207-6-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1277998285-30207-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1861159641799069945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   69 +++++++++++++++++++++++++++++++++++++++--------=
----
 1 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 3b19227..4d22d94 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -1938,6 +1938,7 @@ struct get_input_test {
 	struct stk_icon_id icon_id;
 	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
+	char *html;
 };
 =

 static unsigned char get_input_111[] =3D { 0xD0, 0x1B, 0x81, 0x03, 0x01, 0=
x23,
@@ -2773,7 +2774,9 @@ static struct get_input_test get_input_data_811 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter 12345</span>"
 };
 =

 static struct get_input_test get_input_data_812 =3D {
@@ -2799,7 +2802,10 @@ static struct get_input_test get_input_data_821 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x01, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: center;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Enter 12345</span>"
+		"</div>",
 };
 =

 static struct get_input_test get_input_data_822 =3D {
@@ -2825,7 +2831,10 @@ static struct get_input_test get_input_data_831 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x02, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: right;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Enter 12345</span>"
+		"</div>",
 };
 =

 static struct get_input_test get_input_data_832 =3D {
@@ -2851,7 +2860,9 @@ static struct get_input_test get_input_data_841 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x04, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-size: big;color: #347235;"
+		"background-color: #FFFF00;\">Enter 12345</span>",
 };
 =

 static struct get_input_test get_input_data_842 =3D {
@@ -2866,7 +2877,9 @@ static struct get_input_test get_input_data_842 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter 22222</span>"
 };
 =

 static struct get_input_test get_input_data_843 =3D {
@@ -2892,7 +2905,9 @@ static struct get_input_test get_input_data_851 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x08, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-size: small;color: #347235;"
+		"background-color: #FFFF00;\">Enter 12345</span>",
 };
 =

 static struct get_input_test get_input_data_852 =3D {
@@ -2907,7 +2922,9 @@ static struct get_input_test get_input_data_852 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter 22222</span>"
 };
 =

 static struct get_input_test get_input_data_853 =3D {
@@ -2933,7 +2950,9 @@ static struct get_input_test get_input_data_861 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x10, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-weight: bold;color: #347235;"
+		"background-color: #FFFF00;\">Enter 12345</span>"
 };
 =

 static struct get_input_test get_input_data_862 =3D {
@@ -2948,7 +2967,9 @@ static struct get_input_test get_input_data_862 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter 22222</span>"
 };
 =

 static struct get_input_test get_input_data_863 =3D {
@@ -2974,7 +2995,9 @@ static struct get_input_test get_input_data_871 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x20, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-style: italic;color: #347235;"
+		"background-color: #FFFF00;\">Enter 12345</span>"
 };
 =

 static struct get_input_test get_input_data_872 =3D {
@@ -2989,7 +3012,9 @@ static struct get_input_test get_input_data_872 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter 22222</span>"
 };
 =

 static struct get_input_test get_input_data_873 =3D {
@@ -3015,7 +3040,9 @@ static struct get_input_test get_input_data_881 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x40, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"text-decoration: underline;color: #347235;"
+		"background-color: #FFFF00;\">Enter 12345</span>"
 };
 =

 static struct get_input_test get_input_data_882 =3D {
@@ -3030,7 +3057,9 @@ static struct get_input_test get_input_data_882 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter 22222</span>"
 };
 =

 static struct get_input_test get_input_data_883 =3D {
@@ -3056,7 +3085,9 @@ static struct get_input_test get_input_data_891 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x80, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"text-decoration: line-through;color: #347235;"
+		"background-color: #FFFF00;\">Enter 12345</span>"
 };
 =

 static struct get_input_test get_input_data_892 =3D {
@@ -3071,7 +3102,9 @@ static struct get_input_test get_input_data_892 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter 22222</span>"
 };
 =

 static struct get_input_test get_input_data_893 =3D {
@@ -3097,7 +3130,9 @@ static struct get_input_test get_input_data_8101 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0B, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Enter 12345</span>"
 };
 =

 static struct get_input_test get_input_data_8102 =3D {
@@ -3231,6 +3266,8 @@ static void test_get_input(gconstpointer data)
 	check_icon_id(&command->get_input.icon_id, &test->icon_id);
 	check_text_attr(&command->get_input.text_attr,
 						&test->text_attr);
+	check_text_attr_html(&command->get_input.text_attr,
+				command->get_input.text, test->html);
 	check_frame_id(&command->get_input.frame_id, &test->frame_id);
 =

 	stk_command_free(command);
-- =

1.6.6.1


--===============1861159641799069945==--

