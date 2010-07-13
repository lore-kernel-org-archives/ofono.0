Content-Type: multipart/mixed; boundary="===============8853314890062825987=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 8/9] test-stkutil: add html attribute test for select_item_test
Date: Tue, 13 Jul 2010 05:40:54 -0700
Message-ID: <1279024855-10586-9-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1279024855-10586-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8853314890062825987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   83 +++++++++++++++++++++++++++++++++++++++++------=
----
 1 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index d39e938..20a3902 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -5989,6 +5989,7 @@ struct select_item_test {
 	struct stk_text_attribute text_attr;
 	struct stk_item_text_attribute_list item_text_attr_list;
 	struct stk_frame_id frame_id;
+	char *html;
 };
 =

 static unsigned char select_item_111[] =3D { 0xD0, 0x3D, 0x81, 0x03, 0x01,=
 0x24,
@@ -7035,7 +7036,10 @@ static struct select_item_test select_item_data_911 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x00, 0xB4, 0x00, 0x06, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Toolkit Select 1</span>"
+		"</div>",
 };
 =

 static struct select_item_test select_item_data_912 =3D {
@@ -7065,7 +7069,10 @@ static struct select_item_test select_item_data_921 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x01, 0xB4, 0x00, 0x06, 0x01, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: center;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Toolkit Select 1</span>"
+		"</div>",
 };
 =

 static struct select_item_test select_item_data_922 =3D {
@@ -7095,7 +7102,10 @@ static struct select_item_test select_item_data_931 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x02, 0xB4, 0x00, 0x06, 0x02, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: right;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Toolkit Select 1</span>"
+		"</div>"
 };
 =

 static struct select_item_test select_item_data_932 =3D {
@@ -7125,7 +7135,10 @@ static struct select_item_test select_item_data_941 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x04, 0xB4, 0x00, 0x06, 0x04, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"font-size: "
+		"big;color: #347235;background-color: #FFFF00;\">"
+		"Toolkit Select 1</span></div>",
 };
 =

 static struct select_item_test select_item_data_942 =3D {
@@ -7144,7 +7157,10 @@ static struct select_item_test select_item_data_942 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x00, 0xB4, 0x00, 0x06, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Toolkit Select 2</span>"
+		"</div>",
 };
 =

 static struct select_item_test select_item_data_943 =3D {
@@ -7174,7 +7190,10 @@ static struct select_item_test select_item_data_951 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x08, 0xB4, 0x00, 0x06, 0x08, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"font-size: "
+		"small;color: #347235;background-color: #FFFF00;\">"
+		"Toolkit Select 1</span></div>",
 };
 =

 static struct select_item_test select_item_data_952 =3D {
@@ -7193,7 +7212,10 @@ static struct select_item_test select_item_data_952 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x00, 0xB4, 0x00, 0x06, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Toolkit Select 2</span>"
+		"</div>",
 };
 =

 static struct select_item_test select_item_data_953 =3D {
@@ -7223,7 +7245,10 @@ static struct select_item_test select_item_data_961 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x10, 0xB4, 0x00, 0x06, 0x10, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"font-weight=
: "
+		"bold;color: #347235;background-color: #FFFF00;\">"
+		"Toolkit Select 1</span></div>",
 };
 =

 static struct select_item_test select_item_data_962 =3D {
@@ -7242,7 +7267,10 @@ static struct select_item_test select_item_data_962 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x00, 0xB4, 0x00, 0x06, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Toolkit Select 2</span>"
+		"</div>",
 };
 =

 static struct select_item_test select_item_data_963 =3D {
@@ -7272,7 +7300,10 @@ static struct select_item_test select_item_data_971 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x20, 0xB4, 0x00, 0x06, 0x20, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"font-style:=
 "
+		"italic;color: #347235;background-color: #FFFF00;\">"
+		"Toolkit Select 1</span></div>"
 };
 =

 static struct select_item_test select_item_data_972 =3D {
@@ -7291,7 +7322,10 @@ static struct select_item_test select_item_data_972 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x00, 0xB4, 0x00, 0x06, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Toolkit Select 2</span>"
+		"</div>",
 };
 =

 static struct select_item_test select_item_data_973 =3D {
@@ -7321,7 +7355,10 @@ static struct select_item_test select_item_data_981 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x40, 0xB4, 0x00, 0x06, 0x40, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span "
+		"style=3D\"text-decoration: underline;color: #347235;"
+		"background-color: #FFFF00;\">Toolkit Select 1</span></div>",
 };
 =

 static struct select_item_test select_item_data_982 =3D {
@@ -7340,7 +7377,10 @@ static struct select_item_test select_item_data_982 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x00, 0xB4, 0x00, 0x06, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Toolkit Select 2</span>"
+		"</div>",
 };
 =

 static struct select_item_test select_item_data_983 =3D {
@@ -7370,7 +7410,10 @@ static struct select_item_test select_item_data_991 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x80, 0xB4, 0x00, 0x06, 0x80, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span "
+		"style=3D\"text-decoration: line-through;color: #347235;"
+		"background-color: #FFFF00;\">Toolkit Select 1</span></div>",
 };
 =

 static struct select_item_test select_item_data_992 =3D {
@@ -7389,7 +7432,10 @@ static struct select_item_test select_item_data_992 =
=3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x00, 0xB4, 0x00, 0x06, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Toolkit Select 2</span>"
+		"</div>",
 };
 =

 static struct select_item_test select_item_data_993 =3D {
@@ -7419,7 +7465,10 @@ static struct select_item_test select_item_data_9101=
 =3D {
 	.item_text_attr_list =3D {
 		.len =3D 8,
 		.list =3D { 0x00, 0x06, 0x00, 0xB4, 0x00, 0x06, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Toolkit Select 1</span>"
+		"</div>",
 };
 =

 static struct select_item_test select_item_data_9102 =3D {
@@ -7547,6 +7596,8 @@ static void test_select_item(gconstpointer data)
 	check_item_text_attribute_list(
 				&command->select_item.item_text_attr_list,
 				&test->item_text_attr_list);
+	check_text_attr_html(&command->select_item.text_attr,
+				command->select_item.alpha_id, test->html);
 	check_frame_id(&command->select_item.frame_id, &test->frame_id);
 =

 	stk_command_free(command);
-- =

1.6.6.1


--===============8853314890062825987==--

