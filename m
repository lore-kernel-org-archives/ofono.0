Content-Type: multipart/mixed; boundary="===============4758111580151544909=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 9/9] test-stkutil: add html attribute tests for setup idle
 mode tests
Date: Tue, 13 Jul 2010 05:40:55 -0700
Message-ID: <1279024855-10586-10-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1279024855-10586-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4758111580151544909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   84 +++++++++++++++++++++++++++++++++++++++++------=
----
 1 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 20a3902..1d7485a 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -13994,6 +13994,7 @@ struct setup_idle_mode_text_test {
 	struct stk_icon_id icon_id;
 	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
+	char *html;
 };
 =

 static unsigned char setup_idle_mode_text_111[] =3D { 0xD0, 0x1A, 0x81, 0x=
03,
@@ -14426,7 +14427,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_411 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Idle Mode Text 1</span>"
+		"</div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_412 =3D {
@@ -14444,7 +14448,10 @@ static struct setup_idle_mode_text_test setup_idle=
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
@@ -14462,7 +14469,10 @@ static struct setup_idle_mode_text_test setup_idle=
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
@@ -14480,7 +14490,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_441 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x04, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"font-size: "
+		"big;color: #347235;background-color: #FFFF00;\">"
+		"Idle Mode Text 1</span></div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_442 =3D {
@@ -14491,7 +14504,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_442 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Idle Mode Text 2</span>"
+		"</div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_443 =3D {
@@ -14509,7 +14525,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_451 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x08, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"font-size: "
+		"small;color: #347235;background-color: #FFFF00;\">"
+		"Idle Mode Text 1</span></div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_452 =3D {
@@ -14520,7 +14539,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_452 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Idle Mode Text 2</span>"
+		"</div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_453 =3D {
@@ -14538,7 +14560,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_461 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x10, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"font-weight=
: "
+		"bold;color: #347235;background-color: #FFFF00;\">"
+		"Idle Mode Text 1</span></div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_462 =3D {
@@ -14549,7 +14574,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_462 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Idle Mode Text 2</span>"
+		"</div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_463 =3D {
@@ -14567,7 +14595,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_471 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x20, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"font-style:=
 "
+		"italic;color: #347235;background-color: #FFFF00;\">"
+		"Idle Mode Text 1</span></div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_472 =3D {
@@ -14578,7 +14609,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_472 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Idle Mode Text 2</span>"
+		"</div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_473 =3D {
@@ -14596,7 +14630,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_481 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x40, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span "
+		"style=3D\"text-decoration: underline;color: #347235;"
+		"background-color: #FFFF00;\">Idle Mode Text 1</span></div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_482 =3D {
@@ -14607,7 +14644,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_482 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Idle Mode Text 2</span>"
+		"</div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_483 =3D {
@@ -14625,7 +14665,11 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_491 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x80, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span "
+		"style=3D\"text-decoration: line-through;color: "
+		"#347235;background-color: #FFFF00;\">Idle Mode Text 1</span>"
+		"</div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_492 =3D {
@@ -14636,7 +14680,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_492 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Idle Mode Text 2</span>"
+		"</div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_493 =3D {
@@ -14654,7 +14701,10 @@ static struct setup_idle_mode_text_test setup_idle=
_mode_text_data_4101 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Idle Mode Text 1</span>"
+		"</div>",
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_4102 =3D=
 {
@@ -14699,6 +14749,8 @@ static void test_setup_idle_mode_text(gconstpointer=
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


--===============4758111580151544909==--

