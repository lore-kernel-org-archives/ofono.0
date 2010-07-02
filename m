Content-Type: multipart/mixed; boundary="===============6186134773087447103=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 9/9] test-stkutil: add html attribute tests for setup idle
 mode tests
Date: Fri, 02 Jul 2010 06:46:08 -0700
Message-ID: <1278078368-32565-10-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1278078368-32565-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6186134773087447103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   69 +++++++++++++++++++++++++++++++++++++++--------=
----
 1 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 7993813..348c991 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -13932,6 +13932,7 @@ struct setup_idle_mode_text_test {
 	struct stk_icon_id icon_id;
 	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
+	char *html;
 };
 =

 static unsigned char setup_idle_mode_text_111[] =3D { 0xD0, 0x1A, 0x81, 0x=
03,
@@ -14364,7 +14365,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_411 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Idle Mode Text 1</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_412 =3D {
@@ -14382,7 +14385,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_421 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x01, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: center;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Idle Mode Text 1</span>"
+		"</div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_422 =3D {
@@ -14400,7 +14406,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_431 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x02, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: right;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Idle Mode Text 1</span>"
+		"</div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_432 =3D {
@@ -14418,7 +14427,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_441 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x04, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-size: big;color: #347235;"
+		"background-color: #FFFF00;\">Idle Mode Text 1</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_442 =3D {
@@ -14429,7 +14440,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_442 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Idle Mode Text 2</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_443 =3D {
@@ -14447,7 +14460,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_451 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x08, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-size: small;color: #347235;"
+		"background-color: #FFFF00;\">Idle Mode Text 1</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_452 =3D {
@@ -14458,7 +14473,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_452 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Idle Mode Text 2</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_453 =3D {
@@ -14476,7 +14493,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_461 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x10, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-weight: bold;color: #347235;"
+		"background-color: #FFFF00;\">Idle Mode Text 1</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_462 =3D {
@@ -14487,7 +14506,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_462 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Idle Mode Text 2</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_463 =3D {
@@ -14505,7 +14526,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_471 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x20, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"font-style: italic;color: #347235;"
+		"background-color: #FFFF00;\">Idle Mode Text 1</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_472 =3D {
@@ -14516,7 +14539,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_472 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Idle Mode Text 2</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_473 =3D {
@@ -14534,7 +14559,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_481 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x40, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"text-decoration: underline;color: #347235;"
+		"background-color: #FFFF00;\">Idle Mode Text 1</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_482 =3D {
@@ -14545,7 +14572,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_482 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Idle Mode Text 2</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_483 =3D {
@@ -14563,7 +14592,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_491 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x80, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"text-decoration: line-through;color: "
+		"#347235;background-color: #FFFF00;\">Idle Mode Text 1</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_492 =3D {
@@ -14574,7 +14605,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_492 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Idle Mode Text 2</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_493 =3D {
@@ -14592,7 +14625,9 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_4101 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Idle Mode Text 1</span>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_4102 =3D=
 {
@@ -14637,6 +14672,8 @@ static void test_setup_idle_mode_text(gconstpointer=
 data)
 	check_icon_id(&command->setup_idle_mode_text.icon_id, &test->icon_id);
 	check_text_attr(&command->setup_idle_mode_text.text_attr,
 							&test->text_attr);
+	check_text_attr_html(&command->setup_idle_mode_text.text_attr,
+				command->setup_idle_mode_text.text, test->html);
 	check_frame_id(&command->setup_idle_mode_text.frame_id,
 							&test->frame_id);
 =

-- =

1.6.6.1


--===============6186134773087447103==--

