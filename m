Content-Type: multipart/mixed; boundary="===============6225539268403244491=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 07/10] test-stkutil: add html attribute test for
 setup_menu_test
Date: Thu, 01 Jul 2010 08:31:22 -0700
Message-ID: <1277998285-30207-8-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1277998285-30207-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6225539268403244491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   50 ++++++++++++++++++++++++++++++++++++++---------=
---
 1 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 3ab3528..fca4526 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -4644,6 +4644,7 @@ struct setup_menu_test {
 	struct stk_item_icon_id_list item_icon_id_list;
 	struct stk_text_attribute text_attr;
 	struct stk_item_text_attribute_list item_text_attr_list;
+	char *html;
 };
 =

 static unsigned char setup_menu_111[] =3D { 0xD0, 0x3B, 0x81, 0x03, 0x01, =
0x25,
@@ -5457,7 +5458,9 @@ static struct setup_menu_test setup_menu_data_611 =3D=
 {
 		.len =3D 12,
 		.list =3D { 0x00, 0x06, 0x00, 0xB4, 0x00, 0x06, 0x00, 0xB4,
 				0x00, 0x06, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Toolkit Menu 1</span>",
 };
 =

 static struct setup_menu_test setup_menu_data_612 =3D {
@@ -5490,7 +5493,10 @@ static struct setup_menu_test setup_menu_data_621 =
=3D {
 		.len =3D 12,
 		.list =3D { 0x00, 0x06, 0x01, 0xB4, 0x00, 0x06, 0x01, 0xB4,
 				0x00, 0x06, 0x01, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: center;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Toolkit Menu 1</span>"
+		"</div>"
 };
 =

 static struct setup_menu_test setup_menu_data_622 =3D {
@@ -5527,7 +5533,10 @@ static struct setup_menu_test setup_menu_data_631 =
=3D {
 		.len =3D 12,
 		.list =3D { 0x00, 0x06, 0x02, 0xB4, 0x00, 0x06, 0x02, 0xB4,
 				0x00, 0x06, 0x02, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: right;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Toolkit Menu 1</span>"
+		"</div>"
 };
 =

 static struct setup_menu_test setup_menu_data_632 =3D {
@@ -5560,7 +5569,9 @@ static struct setup_menu_test setup_menu_data_641 =3D=
 {
 		.len =3D 12,
 		.list =3D { 0x00, 0x06, 0x04, 0xB4, 0x00, 0x06, 0x04, 0xB4,
 				0x00, 0x06, 0x04, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-size: big;color: #347235;"
+		"background-color: #FFFF00;\">Toolkit Menu 1</span>",
 };
 =

 static struct setup_menu_test setup_menu_data_642 =3D {
@@ -5581,7 +5592,9 @@ static struct setup_menu_test setup_menu_data_642 =3D=
 {
 		.len =3D 12,
 		.list =3D { 0x00, 0x06, 0x00, 0xB4, 0x00, 0x06, 0x00, 0xB4,
 				0x00, 0x06, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Toolkit Menu 2</span>",
 };
 =

 static struct setup_menu_test setup_menu_data_643 =3D {
@@ -5614,7 +5627,9 @@ static struct setup_menu_test setup_menu_data_651 =3D=
 {
 		.len =3D 12,
 		.list =3D { 0x00, 0x06, 0x08, 0xB4, 0x00, 0x06, 0x08, 0xB4,
 				0x00, 0x06, 0x08, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-size: small;color: #347235;"
+		"background-color: #FFFF00;\">Toolkit Menu 1</span>",
 };
 =

 static struct setup_menu_test setup_menu_data_661 =3D {
@@ -5635,7 +5650,9 @@ static struct setup_menu_test setup_menu_data_661 =3D=
 {
 		.len =3D 12,
 		.list =3D { 0x00, 0x06, 0x10, 0xB4, 0x00, 0x06, 0x10, 0xB4,
 				0x00, 0x06, 0x10, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-weight: bold;color: #347235;"
+		"background-color: #FFFF00;\">Toolkit Menu 1</span>",
 };
 =

 static struct setup_menu_test setup_menu_data_671 =3D {
@@ -5656,7 +5673,9 @@ static struct setup_menu_test setup_menu_data_671 =3D=
 {
 		.len =3D 12,
 		.list =3D { 0x00, 0x06, 0x20, 0xB4, 0x00, 0x06, 0x20, 0xB4,
 				0x00, 0x06, 0x20, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-style: italic;color: #347235;"
+		"background-color: #FFFF00;\">Toolkit Menu 1</span>"
 };
 =

 static struct setup_menu_test setup_menu_data_681 =3D {
@@ -5677,7 +5696,9 @@ static struct setup_menu_test setup_menu_data_681 =3D=
 {
 		.len =3D 12,
 		.list =3D { 0x00, 0x06, 0x40, 0xB4, 0x00, 0x06, 0x40, 0xB4,
 				0x00, 0x06, 0x40, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"text-decoration: underline;color: #347235;"
+		"background-color: #FFFF00;\">Toolkit Menu 1</span>",
 };
 =

 static struct setup_menu_test setup_menu_data_691 =3D {
@@ -5698,7 +5719,9 @@ static struct setup_menu_test setup_menu_data_691 =3D=
 {
 		.len =3D 12,
 		.list =3D { 0x00, 0x06, 0x80, 0xB4, 0x00, 0x06, 0x80, 0xB4,
 				0x00, 0x06, 0x80, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"text-decoration: line-through;color: #347235;"
+		"background-color: #FFFF00;\">Toolkit Menu 1</span>"
 };
 =

 static struct setup_menu_test setup_menu_data_6101 =3D {
@@ -5719,7 +5742,9 @@ static struct setup_menu_test setup_menu_data_6101 =
=3D {
 		.len =3D 12,
 		.list =3D { 0x00, 0x06, 0x00, 0xB4, 0x00, 0x06, 0x00, 0xB4,
 				0x00, 0x06, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Toolkit Menu</span>",
 };
 =

 static struct setup_menu_test setup_menu_data_711 =3D {
@@ -5862,7 +5887,8 @@ static void test_setup_menu(gconstpointer data)
 	check_text_attr(&command->setup_menu.text_attr, &test->text_attr);
 	check_item_text_attribute_list(&command->setup_menu.item_text_attr_list,
 					&test->item_text_attr_list);
-
+	check_text_attr_html(&command->setup_menu.text_attr,
+				command->setup_menu.alpha_id, test->html);
 	stk_command_free(command);
 }
 =

-- =

1.6.6.1


--===============6225539268403244491==--

