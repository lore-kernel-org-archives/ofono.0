Content-Type: multipart/mixed; boundary="===============3952473041379207356=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 09/10] test-stkutil: add html attribute tests for setup idle
 mode tests
Date: Thu, 01 Jul 2010 08:31:24 -0700
Message-ID: <1277998285-30207-10-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1277998285-30207-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3952473041379207356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   69 +++++++++++++++++++++++++++++++++++++++--------=
----
 1 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index ada02c0..74e2ec2 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -13719,6 +13719,7 @@ struct setup_idle_mode_text_test {
 	struct stk_icon_id icon_id;
 	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
+	char *html;
 };
 =

 static unsigned char setup_idle_mode_text_111[] =3D { 0xD0, 0x1A, 0x81, 0x=
03,
@@ -14151,7 +14152,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14169,7 +14172,10 @@ static struct setup_idle_mode_text_test setup_idle=
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
@@ -14187,7 +14193,10 @@ static struct setup_idle_mode_text_test setup_idle=
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
@@ -14205,7 +14214,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14216,7 +14227,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14234,7 +14247,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14245,7 +14260,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14263,7 +14280,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14274,7 +14293,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14292,7 +14313,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14303,7 +14326,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14321,7 +14346,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14332,7 +14359,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14350,7 +14379,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14361,7 +14392,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14379,7 +14412,9 @@ static struct setup_idle_mode_text_test setup_idle_=
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
@@ -14424,6 +14459,8 @@ static void test_setup_idle_mode_text(gconstpointer=
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


--===============3952473041379207356==--

