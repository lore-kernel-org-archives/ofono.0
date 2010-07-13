Content-Type: multipart/mixed; boundary="===============4074313983066485883=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 6/9] test-stkutil: add html attribute tests for play_tone_test
Date: Tue, 13 Jul 2010 05:40:52 -0700
Message-ID: <1279024855-10586-7-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1279024855-10586-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4074313983066485883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   82 +++++++++++++++++++++++++++++++++++++++++------=
----
 1 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index bb09270..d1a633f 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -3351,6 +3351,7 @@ struct play_tone_test {
 	struct stk_icon_id icon_id;
 	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
+	char *html;
 };
 =

 static unsigned char play_tone_111[] =3D { 0xD0, 0x1B, 0x81, 0x03, 0x01, 0=
x20,
@@ -4121,7 +4122,10 @@ static struct play_tone_test play_tone_data_411 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Text Attribute 1</span>"
+		"</div>",
 };
 =

 static struct play_tone_test play_tone_data_412 =3D {
@@ -4149,7 +4153,10 @@ static struct play_tone_test play_tone_data_421 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x01, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: center;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Text Attribute 1</span>"
+		"</div>",
 };
 =

 static struct play_tone_test play_tone_data_422 =3D {
@@ -4177,7 +4184,10 @@ static struct play_tone_test play_tone_data_431 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x02, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: right;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Text Attribute 1</span>"
+		"</div>",
 };
 =

 static struct play_tone_test play_tone_data_432 =3D {
@@ -4205,7 +4215,10 @@ static struct play_tone_test play_tone_data_441 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x04, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"font-size: "
+		"big;color: #347235;background-color: #FFFF00;\">"
+		"Text Attribute 1</span></div>",
 };
 =

 static struct play_tone_test play_tone_data_442 =3D {
@@ -4221,7 +4234,10 @@ static struct play_tone_test play_tone_data_442 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Text Attribute 2</span>"
+		"</div>",
 };
 =

 static struct play_tone_test play_tone_data_443 =3D {
@@ -4249,7 +4265,10 @@ static struct play_tone_test play_tone_data_451 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x08, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"font-size: "
+		"small;color: #347235;background-color: #FFFF00;\">"
+		"Text Attribute 1</span></div>",
 };
 =

 static struct play_tone_test play_tone_data_452 =3D {
@@ -4265,7 +4284,10 @@ static struct play_tone_test play_tone_data_452 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Text Attribute 2</span>"
+		"</div>",
 };
 =

 static struct play_tone_test play_tone_data_453 =3D {
@@ -4293,7 +4315,10 @@ static struct play_tone_test play_tone_data_461 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0E, 0x10, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"font-weight=
: "
+		"bold;color: #347235;background-color: #FFFF00;\">"
+		"Text Attribute</span></div> 1"
 };
 =

 static struct play_tone_test play_tone_data_462 =3D {
@@ -4309,7 +4334,10 @@ static struct play_tone_test play_tone_data_462 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Text Attribute 2</span>"
+		"</div>",
 };
 =

 static struct play_tone_test play_tone_data_463 =3D {
@@ -4337,7 +4365,10 @@ static struct play_tone_test play_tone_data_471 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x0E, 0x20, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"font-style:=
 "
+		"italic;color: #347235;background-color: #FFFF00;\">"
+		"Text Attribute</span></div> 1",
 };
 =

 static struct play_tone_test play_tone_data_472 =3D {
@@ -4353,7 +4384,10 @@ static struct play_tone_test play_tone_data_472 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Text Attribute 2</span>"
+		"</div>",
 };
 =

 static struct play_tone_test play_tone_data_473 =3D {
@@ -4381,7 +4415,10 @@ static struct play_tone_test play_tone_data_481 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x40, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span "
+		"style=3D\"text-decoration: underline;color: #347235;"
+		"background-color: #FFFF00;\">Text Attribute 1</span></div>",
 };
 =

 static struct play_tone_test play_tone_data_482 =3D {
@@ -4397,7 +4434,10 @@ static struct play_tone_test play_tone_data_482 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Text Attribute 2</span>"
+		"</div>",
 };
 =

 static struct play_tone_test play_tone_data_483 =3D {
@@ -4425,7 +4465,10 @@ static struct play_tone_test play_tone_data_491 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x80, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span "
+		"style=3D\"text-decoration: line-through;color: #347235;"
+		"background-color: #FFFF00;\">Text Attribute 1</span></div>",
 };
 =

 static struct play_tone_test play_tone_data_492 =3D {
@@ -4441,7 +4484,10 @@ static struct play_tone_test play_tone_data_492 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Text Attribute 2</span>"
+		"</div>",
 };
 =

 static struct play_tone_test play_tone_data_493 =3D {
@@ -4469,7 +4515,9 @@ static struct play_tone_test play_tone_data_4101 =3D {
 	.text_attr =3D {
 		.len =3D 4,
 		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 }
-	}
+	},
+	.html =3D "<div style=3D\"text-align: left;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Text Attribute 1</span>",
 };
 =

 static struct play_tone_test play_tone_data_4102 =3D {
@@ -4579,6 +4627,8 @@ static void test_play_tone(gconstpointer data)
 	check_duration(&command->play_tone.duration, &test->duration);
 	check_icon_id(&command->play_tone.icon_id, &test->icon_id);
 	check_text_attr(&command->play_tone.text_attr, &test->text_attr);
+	check_text_attr_html(&command->play_tone.text_attr,
+				command->play_tone.alpha_id, test->html);
 	check_frame_id(&command->play_tone.frame_id, &test->frame_id);
 =

 	stk_command_free(command);
-- =

1.6.6.1


--===============4074313983066485883==--

