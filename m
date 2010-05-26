Content-Type: multipart/mixed; boundary="===============8988388917386969852=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] test-stkutil: Use gcc4.3 compatible initialisers.
Date: Wed, 26 May 2010 05:59:40 +0200
Message-ID: <1274846380-4370-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8988388917386969852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Reformat according to ideas on IRC.
---
 unit/test-stkutil.c | 1375 +++++++++++++----------------------------------=
----
 1 files changed, 356 insertions(+), 1019 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 173ab2d..8117ec7 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -4769,21 +4769,11 @@ static struct setup_menu_test setup_menu_data_111 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_111),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
-	},
-	.items[3] =3D {
-		.id =3D 4,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
+		{ .id =3D 4, .text =3D "Item 4" },
 	}
 };
 =

@@ -4792,13 +4782,9 @@ static struct setup_menu_test setup_menu_data_112 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_112),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu",
-	.items[0] =3D {
-		.id =3D 0x11,
-		.text =3D "One"
-	},
-	.items[1] =3D {
-		.id =3D 0x12,
-		.text =3D "Two"
+	.items =3D {
+		{ .id =3D 0x11, .text =3D "One" },
+		{ .id =3D 0x12, .text =3D "Two" },
 	}
 };
 =

@@ -4813,125 +4799,37 @@ static struct setup_menu_test setup_menu_data_121 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_121),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "LargeMenu1",
-	.items[0] =3D {
-		.id =3D 0x50,
-		.text =3D "Zero"
-	},
-	.items[1] =3D {
-		.id =3D 0x4F,
-		.text =3D "One"
-	},
-	.items[2] =3D {
-		.id =3D 0x4E,
-		.text =3D "Two"
-	},
-	.items[3] =3D {
-		.id =3D 0x4D,
-		.text =3D "Three"
-	},
-	.items[4] =3D {
-		.id =3D 0x4C,
-		.text =3D "Four"
-	},
-	.items[5] =3D {
-		.id =3D 0x4B,
-		.text =3D "Five"
-	},
-	.items[6] =3D {
-		.id =3D 0x4A,
-		.text =3D "Six"
-	},
-	.items[7] =3D {
-		.id =3D 0x49,
-		.text =3D "Seven"
-	},
-	.items[8] =3D {
-		.id =3D 0x48,
-		.text =3D "Eight"
-	},
-	.items[9] =3D {
-		.id =3D 0x47,
-		.text =3D "Nine"
-	},
-	.items[10] =3D {
-		.id =3D 0x46,
-		.text =3D "Alpha"
-	},
-	.items[11] =3D {
-		.id =3D 0x45,
-		.text =3D "Bravo"
-	},
-	.items[12] =3D {
-		.id =3D 0x44,
-		.text =3D "Charlie"
-	},
-	.items[13] =3D {
-		.id =3D 0x43,
-		.text =3D "Delta"
-	},
-	.items[14] =3D {
-		.id =3D 0x42,
-		.text =3D "Echo"
-	},
-	.items[15] =3D {
-		.id =3D 0x41,
-		.text =3D "Fox-trot"
-	},
-	.items[16] =3D {
-		.id =3D 0x40,
-		.text =3D "Black"
-	},
-	.items[17] =3D {
-		.id =3D 0x3F,
-		.text =3D "Brown"
-	},
-	.items[18] =3D {
-		.id =3D 0x3E,
-		.text =3D "Red"
-	},
-	.items[19] =3D {
-		.id =3D 0x3D,
-		.text =3D "Orange"
-	},
-	.items[20] =3D {
-		.id =3D 0x3C,
-		.text =3D "Yellow"
-	},
-	.items[21] =3D {
-		.id =3D 0x3B,
-		.text =3D "Green"
-	},
-	.items[22] =3D {
-		.id =3D 0x3A,
-		.text =3D "Blue"
-	},
-	.items[23] =3D {
-		.id =3D 0x39,
-		.text =3D "Violet"
-	},
-	.items[24] =3D {
-		.id =3D 0x38,
-		.text =3D "Grey"
-	},
-	.items[25] =3D {
-		.id =3D 0x37,
-		.text =3D "White"
-	},
-	.items[26] =3D {
-		.id =3D 0x36,
-		.text =3D "milli"
-	},
-	.items[27] =3D {
-		.id =3D 0x35,
-		.text =3D "micro"
-	},
-	.items[28] =3D {
-		.id =3D 0x34,
-		.text =3D "nano"
-	},
-	.items[29] =3D {
-		.id =3D 0x33,
-		.text =3D "pico"
+	.items =3D {
+		{ .id =3D 0x50, .text =3D "Zero" },
+		{ .id =3D 0x4F, .text =3D "One" },
+		{ .id =3D 0x4E, .text =3D "Two" },
+		{ .id =3D 0x4D, .text =3D "Three" },
+		{ .id =3D 0x4C, .text =3D "Four" },
+		{ .id =3D 0x4B, .text =3D "Five" },
+		{ .id =3D 0x4A, .text =3D "Six" },
+		{ .id =3D 0x49, .text =3D "Seven" },
+		{ .id =3D 0x48, .text =3D "Eight" },
+		{ .id =3D 0x47, .text =3D "Nine" },
+		{ .id =3D 0x46, .text =3D "Alpha" },
+		{ .id =3D 0x45, .text =3D "Bravo" },
+		{ .id =3D 0x44, .text =3D "Charlie" },
+		{ .id =3D 0x43, .text =3D "Delta" },
+		{ .id =3D 0x42, .text =3D "Echo" },
+		{ .id =3D 0x41, .text =3D "Fox-trot" },
+		{ .id =3D 0x40, .text =3D "Black" },
+		{ .id =3D 0x3F, .text =3D "Brown" },
+		{ .id =3D 0x3E, .text =3D "Red" },
+		{ .id =3D 0x3D, .text =3D "Orange" },
+		{ .id =3D 0x3C, .text =3D "Yellow" },
+		{ .id =3D 0x3B, .text =3D "Green" },
+		{ .id =3D 0x3A, .text =3D "Blue" },
+		{ .id =3D 0x39, .text =3D "Violet" },
+		{ .id =3D 0x38, .text =3D "Grey" },
+		{ .id =3D 0x37, .text =3D "White" },
+		{ .id =3D 0x36, .text =3D "milli" },
+		{ .id =3D 0x35, .text =3D "micro" },
+		{ .id =3D 0x34, .text =3D "nano" },
+		{ .id =3D 0x33, .text =3D "pico" },
 	}
 };
 =

@@ -4940,33 +4838,14 @@ static struct setup_menu_test setup_menu_data_122 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_122),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "LargeMenu2",
-	.items[0] =3D {
-		.id =3D 0xFF,
-		.text =3D "1 Call Forward Unconditional"
-	},
-	.items[1] =3D {
-		.id =3D 0xFE,
-		.text =3D "2 Call Forward On User Busy"
-	},
-	.items[2] =3D {
-		.id =3D 0xFD,
-		.text =3D "3 Call Forward On No Reply"
-	},
-	.items[3] =3D {
-		.id =3D 0xFC,
-		.text =3D "4 Call Forward On User Not Reachable"
-	},
-	.items[4] =3D {
-		.id =3D 0xFB,
-		.text =3D "5 Barring Of All Outgoing Calls"
-	},
-	.items[5] =3D {
-		.id =3D 0xFA,
-		.text =3D "6 Barring Of All Outgoing Int Calls"
-	},
-	.items[6] =3D {
-		.id =3D 0xF9,
-		.text =3D "7 CLI Presentation"
+	.items =3D {
+		{ .id =3D 0xFF, .text =3D "1 Call Forward Unconditional" },
+		{ .id =3D 0xFE, .text =3D "2 Call Forward On User Busy" },
+		{ .id =3D 0xFD, .text =3D "3 Call Forward On No Reply" },
+		{ .id =3D 0xFC, .text =3D "4 Call Forward On User Not Reachable" },
+		{ .id =3D 0xFB, .text =3D "5 Barring Of All Outgoing Calls" },
+		{ .id =3D 0xFA, .text =3D "6 Barring Of All Outgoing Int Calls" },
+		{ .id =3D 0xF9, .text =3D "7 CLI Presentation" },
 	}
 };
 =

@@ -4979,9 +4858,8 @@ static struct setup_menu_test setup_menu_data_123 =3D=
 {
 			"facility) in order to give the user the opportunity "
 			"to choose one of these menu items at his own "
 			"discretion. Each item comprises a sh",
-	.items[0] =3D {
-		.id =3D 0x01,
-		.text =3D "Y"
+	.items =3D {
+		{ .id =3D 0x01, .text =3D "Y" }
 	}
 };
 =

@@ -4990,21 +4868,11 @@ static struct setup_menu_test setup_menu_data_211 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_211),
 	.qualifier =3D 0x80,
 	.alpha_id =3D "Toolkit Menu",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
-	},
-	.items[3] =3D {
-		.id =3D 4,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
+		{ .id =3D 4, .text =3D "Item 4" },
 	}
 };
 =

@@ -5013,21 +4881,11 @@ static struct setup_menu_test setup_menu_data_311 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_311),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
-	},
-	.items[3] =3D {
-		.id =3D 4,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
+		{ .id =3D 4, .text =3D "Item 4" },
 	},
 	.next_act =3D {
 		.list =3D { STK_COMMAND_TYPE_SEND_SMS,
@@ -5043,17 +4901,10 @@ static struct setup_menu_test setup_menu_data_411 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_411),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.icon_id =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
@@ -5071,17 +4922,10 @@ static struct setup_menu_test setup_menu_data_421 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_421),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.icon_id =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
@@ -5099,13 +4943,9 @@ static struct setup_menu_test setup_menu_data_511 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_511),
 	.qualifier =3D 0x01,
 	.alpha_id =3D "Toolkit Menu",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
 	}
 };
 =

@@ -5114,17 +4954,10 @@ static struct setup_menu_test setup_menu_data_611 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_611),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -5142,17 +4975,10 @@ static struct setup_menu_test setup_menu_data_612 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_612),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 2",
-	.items[0] =3D {
-		.id =3D 4,
-		.text =3D "Item 4"
-	},
-	.items[1] =3D {
-		.id =3D 5,
-		.text =3D "Item 5"
-	},
-	.items[2] =3D {
-		.id =3D 6,
-		.text =3D "Item 6"
+	.items =3D {
+		{ .id =3D 4, .text =3D "Item 4" },
+		{ .id =3D 5, .text =3D "Item 5" },
+		{ .id =3D 6, .text =3D "Item 6" },
 	}
 };
 =

@@ -5161,17 +4987,10 @@ static struct setup_menu_test setup_menu_data_621 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_621),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -5189,17 +5008,10 @@ static struct setup_menu_test setup_menu_data_622 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_622),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 2",
-	.items[0] =3D {
-		.id =3D 4,
-		.text =3D "Item 4"
-	},
-	.items[1] =3D {
-		.id =3D 5,
-		.text =3D "Item 5"
-	},
-	.items[2] =3D {
-		.id =3D 6,
-		.text =3D "Item 6"
+	.items =3D {
+		{ .id =3D 4, .text =3D "Item 4" },
+		{ .id =3D 5, .text =3D "Item 5" },
+		{ .id =3D 6, .text =3D "Item 6" },
 	}
 };
 =

@@ -5212,17 +5024,10 @@ static struct setup_menu_test setup_menu_data_631 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_631),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -5240,17 +5045,10 @@ static struct setup_menu_test setup_menu_data_632 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_632),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 2",
-	.items[0] =3D {
-		.id =3D 4,
-		.text =3D "Item 4"
-	},
-	.items[1] =3D {
-		.id =3D 5,
-		.text =3D "Item 5"
-	},
-	.items[2] =3D {
-		.id =3D 6,
-		.text =3D "Item 6"
+	.items =3D {
+		{ .id =3D 4, .text =3D "Item 4" },
+		{ .id =3D 5, .text =3D "Item 5" },
+		{ .id =3D 6, .text =3D "Item 6" },
 	}
 };
 =

@@ -5259,17 +5057,10 @@ static struct setup_menu_test setup_menu_data_641 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_641),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -5287,17 +5078,10 @@ static struct setup_menu_test setup_menu_data_642 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_642),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 2",
-	.items[0] =3D {
-		.id =3D 4,
-		.text =3D "Item 4"
-	},
-	.items[1] =3D {
-		.id =3D 5,
-		.text =3D "Item 5"
-	},
-	.items[2] =3D {
-		.id =3D 6,
-		.text =3D "Item 6"
+	.items =3D {
+		{ .id =3D 4, .text =3D "Item 4" },
+		{ .id =3D 5, .text =3D "Item 5" },
+		{ .id =3D 6, .text =3D "Item 6" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -5315,17 +5099,10 @@ static struct setup_menu_test setup_menu_data_643 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_643),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 3",
-	.items[0] =3D {
-		.id =3D 7,
-		.text =3D "Item 7"
-	},
-	.items[1] =3D {
-		.id =3D 8,
-		.text =3D "Item 8"
-	},
-	.items[2] =3D {
-		.id =3D 9,
-		.text =3D "Item 9"
+	.items =3D {
+		{ .id =3D 7, .text =3D "Item 7" },
+		{ .id =3D 8, .text =3D "Item 8" },
+		{ .id =3D 9, .text =3D "Item 9" },
 	}
 };
 =

@@ -5334,17 +5111,10 @@ static struct setup_menu_test setup_menu_data_651 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_651),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -5362,17 +5132,10 @@ static struct setup_menu_test setup_menu_data_661 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_661),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -5390,17 +5153,10 @@ static struct setup_menu_test setup_menu_data_671 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_671),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -5418,17 +5174,10 @@ static struct setup_menu_test setup_menu_data_681 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_681),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -5446,17 +5195,10 @@ static struct setup_menu_test setup_menu_data_691 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_691),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -5474,17 +5216,10 @@ static struct setup_menu_test setup_menu_data_6101 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_6101),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Menu",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -5502,21 +5237,11 @@ static struct setup_menu_test setup_menu_data_711 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_711),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=951"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=952"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=953"
-	},
-	.items[3] =3D {
-		.id =3D 4,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=954"
+	.items =3D {
+		{ .id =3D 1, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=951" },
+		{ .id =3D 2, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=952" },
+		{ .id =3D 3, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=953" },
+		{ .id =3D 4, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=954" },
 	}
 };
 =

@@ -5525,13 +5250,9 @@ static struct setup_menu_test setup_menu_data_712 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_712),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
-	.items[0] =3D {
-		.id =3D 0x11,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=955"
-	},
-	.items[1] =3D {
-		.id =3D 0x12,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=956"
+	.items =3D {
+		{ .id =3D 0x11, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=
=92=D0=A3=D0=99=D0=A2=D0=955" },
+		{ .id =3D 0x12, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=
=92=D0=A3=D0=99=D0=A2=D0=956" },
 	}
 };
 =

@@ -5546,21 +5267,11 @@ static struct setup_menu_test setup_menu_data_811 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_811),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=E5=B7=A5=E5=85=B7=E7=AE=B1=E5=8D=95",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "=E9=A1=B9=E7=9B=AE=E4=B8=80"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "=E9=A1=B9=E7=9B=AE=E4=BA=8C"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "=E9=A1=B9=E7=9B=AE=E4=B8=89"
-	},
-	.items[3] =3D {
-		.id =3D 4,
-		.text =3D "=E9=A1=B9=E7=9B=AE=E5=9B=9B"
+	.items =3D {
+		{ .id =3D 1, .text =3D "=E9=A1=B9=E7=9B=AE=E4=B8=80" },
+		{ .id =3D 2, .text =3D "=E9=A1=B9=E7=9B=AE=E4=BA=8C" },
+		{ .id =3D 3, .text =3D "=E9=A1=B9=E7=9B=AE=E4=B8=89" },
+		{ .id =3D 4, .text =3D "=E9=A1=B9=E7=9B=AE=E5=9B=9B" },
 	}
 };
 =

@@ -5569,13 +5280,9 @@ static struct setup_menu_test setup_menu_data_812 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_812),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=E5=B7=A5=E5=85=B7=E7=AE=B1=E5=8D=95",
-	.items[0] =3D {
-		.id =3D 0x11,
-		.text =3D "=E4=B8=80"
-	},
-	.items[1] =3D {
-		.id =3D 0x12,
-		.text =3D "=E4=BA=8C"
+	.items =3D {
+		{ .id =3D 0x11, .text =3D "=E4=B8=80" },
+		{ .id =3D 0x12, .text =3D "=E4=BA=8C" },
 	}
 };
 =

@@ -5590,21 +5297,11 @@ static struct setup_menu_test setup_menu_data_911 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_911),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "80=E3=83=AB0",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "80=E3=83=AB1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "80=E3=83=AB2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "80=E3=83=AB3"
-	},
-	.items[3] =3D {
-		.id =3D 4,
-		.text =3D "80=E3=83=AB4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "80=E3=83=AB1" },
+		{ .id =3D 2, .text =3D "80=E3=83=AB2" },
+		{ .id =3D 3, .text =3D "80=E3=83=AB3" },
+		{ .id =3D 4, .text =3D "80=E3=83=AB4" },
 	}
 };
 =

@@ -5613,13 +5310,9 @@ static struct setup_menu_test setup_menu_data_912 =
=3D {
 	.pdu_len =3D sizeof(setup_menu_912),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "80=E3=83=AB0",
-	.items[0] =3D {
-		.id =3D 0x11,
-		.text =3D "80=E3=83=AB5"
-	},
-	.items[1] =3D {
-		.id =3D 0x12,
-		.text =3D "80=E3=83=AB6"
+	.items =3D {
+		{ .id =3D 0x11, .text =3D "80=E3=83=AB5" },
+		{ .id =3D 0x12, .text =3D "80=E3=83=AB6" },
 	}
 };
 =

@@ -6469,21 +6162,11 @@ static struct select_item_test select_item_data_111=
 =3D {
 	.pdu_len =3D sizeof(select_item_111),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
-	},
-	.items[3] =3D {
-		.id =3D 4,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
+		{ .id =3D 4, .text =3D "Item 4" },
 	}
 };
 =

@@ -6492,125 +6175,37 @@ static struct select_item_test select_item_data_12=
1 =3D {
 	.pdu_len =3D sizeof(select_item_121),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "LargeMenu1",
-	.items[0] =3D {
-		.id =3D 0x50,
-		.text =3D "Zero"
-	},
-	.items[1] =3D {
-		.id =3D 0x4F,
-		.text =3D "One"
-	},
-	.items[2] =3D {
-		.id =3D 0x4E,
-		.text =3D "Two"
-	},
-	.items[3] =3D {
-		.id =3D 0x4D,
-		.text =3D "Three"
-	},
-	.items[4] =3D {
-		.id =3D 0x4C,
-		.text =3D "Four"
-	},
-	.items[5] =3D {
-		.id =3D 0x4B,
-		.text =3D "Five"
-	},
-	.items[6] =3D {
-		.id =3D 0x4A,
-		.text =3D "Six"
-	},
-	.items[7] =3D {
-		.id =3D 0x49,
-		.text =3D "Seven"
-	},
-	.items[8] =3D {
-		.id =3D 0x48,
-		.text =3D "Eight"
-	},
-	.items[9] =3D {
-		.id =3D 0x47,
-		.text =3D "Nine"
-	},
-	.items[10] =3D {
-		.id =3D 0x46,
-		.text =3D "Alpha"
-	},
-	.items[11] =3D {
-		.id =3D 0x45,
-		.text =3D "Bravo"
-	},
-	.items[12] =3D {
-		.id =3D 0x44,
-		.text =3D "Charlie"
-	},
-	.items[13] =3D {
-		.id =3D 0x43,
-		.text =3D "Delta"
-	},
-	.items[14] =3D {
-		.id =3D 0x42,
-		.text =3D "Echo"
-	},
-	.items[15] =3D {
-		.id =3D 0x41,
-		.text =3D "Fox-trot"
-	},
-	.items[16] =3D {
-		.id =3D 0x40,
-		.text =3D "Black"
-	},
-	.items[17] =3D {
-		.id =3D 0x3F,
-		.text =3D "Brown"
-	},
-	.items[18] =3D {
-		.id =3D 0x3E,
-		.text =3D "Red"
-	},
-	.items[19] =3D {
-		.id =3D 0x3D,
-		.text =3D "Orange"
-	},
-	.items[20] =3D {
-		.id =3D 0x3C,
-		.text =3D "Yellow"
-	},
-	.items[21] =3D {
-		.id =3D 0x3B,
-		.text =3D "Green"
-	},
-	.items[22] =3D {
-		.id =3D 0x3A,
-		.text =3D "Blue"
-	},
-	.items[23] =3D {
-		.id =3D 0x39,
-		.text =3D "Violet"
-	},
-	.items[24] =3D {
-		.id =3D 0x38,
-		.text =3D "Grey"
-	},
-	.items[25] =3D {
-		.id =3D 0x37,
-		.text =3D "White"
-	},
-	.items[26] =3D {
-		.id =3D 0x36,
-		.text =3D "milli"
-	},
-	.items[27] =3D {
-		.id =3D 0x35,
-		.text =3D "micro"
-	},
-	.items[28] =3D {
-		.id =3D 0x34,
-		.text =3D "nano"
-	},
-	.items[29] =3D {
-		.id =3D 0x33,
-		.text =3D "pico"
+	.items =3D {
+		{ .id =3D 0x50, .text =3D "Zero" },
+		{ .id =3D 0x4F, .text =3D "One" },
+		{ .id =3D 0x4E, .text =3D "Two" },
+		{ .id =3D 0x4D, .text =3D "Three" },
+		{ .id =3D 0x4C, .text =3D "Four" },
+		{ .id =3D 0x4B, .text =3D "Five" },
+		{ .id =3D 0x4A, .text =3D "Six" },
+		{ .id =3D 0x49, .text =3D "Seven" },
+		{ .id =3D 0x48, .text =3D "Eight" },
+		{ .id =3D 0x47, .text =3D "Nine" },
+		{ .id =3D 0x46, .text =3D "Alpha" },
+		{ .id =3D 0x45, .text =3D "Bravo" },
+		{ .id =3D 0x44, .text =3D "Charlie" },
+		{ .id =3D 0x43, .text =3D "Delta" },
+		{ .id =3D 0x42, .text =3D "Echo" },
+		{ .id =3D 0x41, .text =3D "Fox-trot" },
+		{ .id =3D 0x40, .text =3D "Black" },
+		{ .id =3D 0x3F, .text =3D "Brown" },
+		{ .id =3D 0x3E, .text =3D "Red" },
+		{ .id =3D 0x3D, .text =3D "Orange" },
+		{ .id =3D 0x3C, .text =3D "Yellow" },
+		{ .id =3D 0x3B, .text =3D "Green" },
+		{ .id =3D 0x3A, .text =3D "Blue" },
+		{ .id =3D 0x39, .text =3D "Violet" },
+		{ .id =3D 0x38, .text =3D "Grey" },
+		{ .id =3D 0x37, .text =3D "White" },
+		{ .id =3D 0x36, .text =3D "milli" },
+		{ .id =3D 0x35, .text =3D "micro" },
+		{ .id =3D 0x34, .text =3D "nano" },
+		{ .id =3D 0x33, .text =3D "pico" },
 	}
 };
 =

@@ -6619,33 +6214,15 @@ static struct select_item_test select_item_data_131=
 =3D {
 	.pdu_len =3D sizeof(select_item_131),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "LargeMenu2",
-	.items[0] =3D {
-		.id =3D 0xFF,
-		.text =3D "Call Forwarding Unconditional"
-	},
-	.items[1] =3D {
-		.id =3D 0xFE,
-		.text =3D "Call Forwarding On User Busy"
-	},
-	.items[2] =3D {
-		.id =3D 0xFD,
-		.text =3D "Call Forwarding On No Reply"
-	},
-	.items[3] =3D {
-		.id =3D 0xFC,
-		.text =3D "Call Forwarding On User Not Reachable"
-	},
-	.items[4] =3D {
-		.id =3D 0xFB,
-		.text =3D "Barring Of All Outgoing Calls"
-	},
-	.items[5] =3D {
-		.id =3D 0xFA,
-		.text =3D "Barring Of All Outgoing International Calls"
-	},
-	.items[6] =3D {
-		.id =3D 0xF9,
-		.text =3D "CLI Presentation"
+	.items =3D {
+		{ .id =3D 0xFF, .text =3D "Call Forwarding Unconditional" },
+		{ .id =3D 0xFE, .text =3D "Call Forwarding On User Busy" },
+		{ .id =3D 0xFD, .text =3D "Call Forwarding On No Reply" },
+		{ .id =3D 0xFC, .text =3D "Call Forwarding On User Not Reachable" },
+		{ .id =3D 0xFB, .text =3D "Barring Of All Outgoing Calls" },
+		{ .id =3D 0xFA,
+			.text =3D "Barring Of All Outgoing International Calls" },
+		{ .id =3D 0xF9, .text =3D "CLI Presentation" },
 	}
 };
 =

@@ -6654,13 +6231,9 @@ static struct select_item_test select_item_data_141 =
=3D {
 	.pdu_len =3D sizeof(select_item_141),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Select Item",
-	.items[0] =3D {
-		.id =3D 0x11,
-		.text =3D "One"
-	},
-	.items[1] =3D {
-		.id =3D 0x12,
-		.text =3D "Two"
+	.items =3D {
+		{ .id =3D 0x11, .text =3D "One" },
+		{ .id =3D 0x12, .text =3D "Two" },
 	}
 };
 =

@@ -6672,9 +6245,8 @@ static struct select_item_test select_item_data_151 =
=3D {
 		"may choose one. Each item comprises a short identifier (used "
 		"to indicate the selection) and a text string. Optionally the "
 		"SIM may include an alpha identifier. The alpha identifier i",
-	.items[0] =3D {
-		.id =3D 0x01,
-		.text =3D "Y"
+	.items =3D {
+		{ .id =3D 0x01, .text =3D "Y" },
 	}
 };
 =

@@ -6683,33 +6255,14 @@ static struct select_item_test select_item_data_161=
 =3D {
 	.pdu_len =3D sizeof(select_item_161),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "0LargeMenu",
-	.items[0] =3D {
-		.id =3D 0xFF,
-		.text =3D "1 Call Forward Unconditional"
-	},
-	.items[1] =3D {
-		.id =3D 0xFE,
-		.text =3D "2 Call Forward On User Busy"
-	},
-	.items[2] =3D {
-		.id =3D 0xFD,
-		.text =3D "3 Call Forward On No Reply"
-	},
-	.items[3] =3D {
-		.id =3D 0xFC,
-		.text =3D "4 Call Forward On User Not Reachable"
-	},
-	.items[4] =3D {
-		.id =3D 0xFB,
-		.text =3D "5 Barring Of All Outgoing Calls"
-	},
-	.items[5] =3D {
-		.id =3D 0xFA,
-		.text =3D "6 Barring Of All Outgoing Int Calls"
-	},
-	.items[6] =3D {
-		.id =3D 0xF9,
-		.text =3D "7 CLI Presentation"
+	.items =3D {
+		{ .id =3D 0xFF, .text =3D "1 Call Forward Unconditional" },
+		{ .id =3D 0xFE, .text =3D "2 Call Forward On User Busy" },
+		{ .id =3D 0xFD, .text =3D "3 Call Forward On No Reply" },
+		{ .id =3D 0xFC, .text =3D "4 Call Forward On User Not Reachable" },
+		{ .id =3D 0xFB, .text =3D "5 Barring Of All Outgoing Calls" },
+		{ .id =3D 0xFA, .text =3D "6 Barring Of All Outgoing Int Calls" },
+		{ .id =3D 0xF9, .text =3D "7 CLI Presentation" },
 	}
 };
 =

@@ -6718,17 +6271,10 @@ static struct select_item_test select_item_data_211=
 =3D {
 	.pdu_len =3D sizeof(select_item_211),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.next_act =3D {
 		.list =3D { STK_COMMAND_TYPE_SEND_SMS,
@@ -6743,17 +6289,10 @@ static struct select_item_test select_item_data_311=
 =3D {
 	.pdu_len =3D sizeof(select_item_311),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.item_id =3D 0x02
 };
@@ -6763,17 +6302,10 @@ static struct select_item_test select_item_data_411=
 =3D {
 	.pdu_len =3D sizeof(select_item_411),
 	.qualifier =3D 0x80,
 	.alpha_id =3D "Toolkit Select",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	}
 };
 =

@@ -6782,17 +6314,10 @@ static struct select_item_test select_item_data_511=
 =3D {
 	.pdu_len =3D sizeof(select_item_511),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.icon_id =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
@@ -6810,17 +6335,10 @@ static struct select_item_test select_item_data_521=
 =3D {
 	.pdu_len =3D sizeof(select_item_521),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	},
 	.icon_id =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY,
@@ -6838,17 +6356,10 @@ static struct select_item_test select_item_data_611=
 =3D {
 	.pdu_len =3D sizeof(select_item_611),
 	.qualifier =3D 0x03,
 	.alpha_id =3D "Toolkit Select",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	}
 };
 =

@@ -6857,17 +6368,10 @@ static struct select_item_test select_item_data_621=
 =3D {
 	.pdu_len =3D sizeof(select_item_621),
 	.qualifier =3D 0x01,
 	.alpha_id =3D "Toolkit Select",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	}
 };
 =

@@ -6876,13 +6380,9 @@ static struct select_item_test select_item_data_711 =
=3D {
 	.pdu_len =3D sizeof(select_item_711),
 	.qualifier =3D 0x04,
 	.alpha_id =3D "Toolkit Select",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
 	}
 };
 =

@@ -6891,17 +6391,10 @@ static struct select_item_test select_item_data_811=
 =3D {
 	.pdu_len =3D sizeof(select_item_811),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "<TIME-OUT>",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "Item 3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
+		{ .id =3D 3, .text =3D "Item 3" },
 	}
 };
 =

@@ -6910,13 +6403,9 @@ static struct select_item_test select_item_data_911 =
=3D {
 	.pdu_len =3D sizeof(select_item_911),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -6933,13 +6422,9 @@ static struct select_item_test select_item_data_912 =
=3D {
 	.pdu_len =3D sizeof(select_item_912),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 2",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 3"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 3" },
+		{ .id =3D 2, .text =3D "Item 4" },
 	}
 };
 =

@@ -6948,13 +6433,9 @@ static struct select_item_test select_item_data_921 =
=3D {
 	.pdu_len =3D sizeof(select_item_921),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -6971,13 +6452,9 @@ static struct select_item_test select_item_data_922 =
=3D {
 	.pdu_len =3D sizeof(select_item_922),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 2",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 3"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 3" },
+		{ .id =3D 2, .text =3D "Item 4" },
 	}
 };
 =

@@ -6986,13 +6463,9 @@ static struct select_item_test select_item_data_931 =
=3D {
 	.pdu_len =3D sizeof(select_item_931),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7009,13 +6482,9 @@ static struct select_item_test select_item_data_932 =
=3D {
 	.pdu_len =3D sizeof(select_item_932),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 2",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 3"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 3" },
+		{ .id =3D 2, .text =3D "Item 4" },
 	}
 };
 =

@@ -7024,13 +6493,9 @@ static struct select_item_test select_item_data_941 =
=3D {
 	.pdu_len =3D sizeof(select_item_941),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7047,13 +6512,9 @@ static struct select_item_test select_item_data_942 =
=3D {
 	.pdu_len =3D sizeof(select_item_942),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 2",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 3"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 3" },
+		{ .id =3D 2, .text =3D "Item 4" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7070,13 +6531,9 @@ static struct select_item_test select_item_data_943 =
=3D {
 	.pdu_len =3D sizeof(select_item_943),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 3",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 5"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 6"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 5" },
+		{ .id =3D 2, .text =3D "Item 6" },
 	}
 };
 =

@@ -7085,13 +6542,9 @@ static struct select_item_test select_item_data_951 =
=3D {
 	.pdu_len =3D sizeof(select_item_951),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7108,13 +6561,9 @@ static struct select_item_test select_item_data_952 =
=3D {
 	.pdu_len =3D sizeof(select_item_952),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 2",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 3"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 3" },
+		{ .id =3D 2, .text =3D "Item 4" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7131,13 +6580,9 @@ static struct select_item_test select_item_data_953 =
=3D {
 	.pdu_len =3D sizeof(select_item_953),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 3",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 5"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 6"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 5" },
+		{ .id =3D 2, .text =3D "Item 6" },
 	}
 };
 =

@@ -7146,13 +6591,9 @@ static struct select_item_test select_item_data_961 =
=3D {
 	.pdu_len =3D sizeof(select_item_961),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7169,13 +6610,9 @@ static struct select_item_test select_item_data_962 =
=3D {
 	.pdu_len =3D sizeof(select_item_962),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 2",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 3"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 3" },
+		{ .id =3D 2, .text =3D "Item 4" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7192,13 +6629,9 @@ static struct select_item_test select_item_data_963 =
=3D {
 	.pdu_len =3D sizeof(select_item_963),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 3",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 5"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 6"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 5" },
+		{ .id =3D 2, .text =3D "Item 6" },
 	}
 };
 =

@@ -7207,13 +6640,9 @@ static struct select_item_test select_item_data_971 =
=3D {
 	.pdu_len =3D sizeof(select_item_971),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7230,13 +6659,9 @@ static struct select_item_test select_item_data_972 =
=3D {
 	.pdu_len =3D sizeof(select_item_972),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 2",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 3"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 3" },
+		{ .id =3D 2, .text =3D "Item 4" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7253,13 +6678,9 @@ static struct select_item_test select_item_data_973 =
=3D {
 	.pdu_len =3D sizeof(select_item_973),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 3",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 5"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 6"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 5" },
+		{ .id =3D 2, .text =3D "Item 6" },
 	}
 };
 =

@@ -7268,13 +6689,9 @@ static struct select_item_test select_item_data_981 =
=3D {
 	.pdu_len =3D sizeof(select_item_981),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7291,13 +6708,9 @@ static struct select_item_test select_item_data_982 =
=3D {
 	.pdu_len =3D sizeof(select_item_982),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 2",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 3"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 3" },
+		{ .id =3D 2, .text =3D "Item 4" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7314,13 +6727,9 @@ static struct select_item_test select_item_data_983 =
=3D {
 	.pdu_len =3D sizeof(select_item_983),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 3",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 5"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 6"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 5" },
+		{ .id =3D 2, .text =3D "Item 6" },
 	}
 };
 =

@@ -7329,13 +6738,9 @@ static struct select_item_test select_item_data_991 =
=3D {
 	.pdu_len =3D sizeof(select_item_991),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7352,13 +6757,9 @@ static struct select_item_test select_item_data_992 =
=3D {
 	.pdu_len =3D sizeof(select_item_992),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 2",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 3"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 3" },
+		{ .id =3D 2, .text =3D "Item 4" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7375,13 +6776,9 @@ static struct select_item_test select_item_data_993 =
=3D {
 	.pdu_len =3D sizeof(select_item_993),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 3",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 5"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 6"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 5" },
+		{ .id =3D 2, .text =3D "Item 6" },
 	}
 };
 =

@@ -7390,13 +6787,9 @@ static struct select_item_test select_item_data_9101=
 =3D {
 	.pdu_len =3D sizeof(select_item_9101),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 1",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 2"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 1" },
+		{ .id =3D 2, .text =3D "Item 2" },
 	},
 	.text_attr =3D {
 		.len =3D 4,
@@ -7413,13 +6806,9 @@ static struct select_item_test select_item_data_9102=
 =3D {
 	.pdu_len =3D sizeof(select_item_9102),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Toolkit Select 2",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "Item 3"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "Item 4"
+	.items =3D {
+		{ .id =3D 1, .text =3D "Item 3" },
+		{ .id =3D 2, .text =3D "Item 4" },
 	}
 };
 =

@@ -7428,17 +6817,10 @@ static struct select_item_test select_item_data_101=
1 =3D {
 	.pdu_len =3D sizeof(select_item_1011),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=951"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=952"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=953"
+	.items =3D {
+		{ .id =3D 1, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=951" },
+		{ .id =3D 2, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=952" },
+		{ .id =3D 3, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=953" },
 	}
 };
 =

@@ -7447,17 +6829,10 @@ static struct select_item_test select_item_data_102=
1 =3D {
 	.pdu_len =3D sizeof(select_item_1021),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=951"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=952"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=953"
+	.items =3D {
+		{ .id =3D 1, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=951" },
+		{ .id =3D 2, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=952" },
+		{ .id =3D 3, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=953" },
 	}
 };
 =

@@ -7466,17 +6841,10 @@ static struct select_item_test select_item_data_103=
1 =3D {
 	.pdu_len =3D sizeof(select_item_1031),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=951"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=952"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=953"
+	.items =3D {
+		{ .id =3D 1, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=951" },
+		{ .id =3D 2, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=952" },
+		{ .id =3D 3, .text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=
=D0=A3=D0=99=D0=A2=D0=953" },
 	}
 };
 =

@@ -7485,21 +6853,11 @@ static struct select_item_test select_item_data_111=
1 =3D {
 	.pdu_len =3D sizeof(select_item_1111),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "=E5=B7=A5=E5=85=B7=E7=AE=B1=E9=80=89=E6=8B=A9",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "=E9=A1=B9=E7=9B=AE=E4=B8=80"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "=E9=A1=B9=E7=9B=AE=E4=BA=8C"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "=E9=A1=B9=E7=9B=AE=E4=B8=89"
-	},
-	.items[3] =3D {
-		.id =3D 4,
-		.text =3D "=E9=A1=B9=E7=9B=AE=E5=9B=9B"
+	.items =3D {
+		{ .id =3D 1, .text =3D "=E9=A1=B9=E7=9B=AE=E4=B8=80" },
+		{ .id =3D 2, .text =3D "=E9=A1=B9=E7=9B=AE=E4=BA=8C" },
+		{ .id =3D 3, .text =3D "=E9=A1=B9=E7=9B=AE=E4=B8=89" },
+		{ .id =3D 4, .text =3D "=E9=A1=B9=E7=9B=AE=E5=9B=9B" },
 	}
 };
 =

@@ -7508,17 +6866,10 @@ static struct select_item_test select_item_data_121=
1 =3D {
 	.pdu_len =3D sizeof(select_item_1211),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "80=E3=83=AB0",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "80=E3=83=AB1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "80=E3=83=AB2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "80=E3=83=AB3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "80=E3=83=AB1" },
+		{ .id =3D 2, .text =3D "80=E3=83=AB2" },
+		{ .id =3D 3, .text =3D "80=E3=83=AB3" },
 	}
 };
 =

@@ -7527,17 +6878,10 @@ static struct select_item_test select_item_data_122=
1 =3D {
 	.pdu_len =3D sizeof(select_item_1221),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "81=E3=83=AB0",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "81=E3=83=AB1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "81=E3=83=AB2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "81=E3=83=AB3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "81=E3=83=AB1" },
+		{ .id =3D 2, .text =3D "81=E3=83=AB2" },
+		{ .id =3D 3, .text =3D "81=E3=83=AB3" },
 	}
 };
 =

@@ -7546,17 +6890,10 @@ static struct select_item_test select_item_data_123=
1 =3D {
 	.pdu_len =3D sizeof(select_item_1231),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "82=E3=83=AB0",
-	.items[0] =3D {
-		.id =3D 1,
-		.text =3D "82=E3=83=AB1"
-	},
-	.items[1] =3D {
-		.id =3D 2,
-		.text =3D "82=E3=83=AB2"
-	},
-	.items[2] =3D {
-		.id =3D 3,
-		.text =3D "82=E3=83=AB3"
+	.items =3D {
+		{ .id =3D 1, .text =3D "82=E3=83=AB1" },
+		{ .id =3D 2, .text =3D "82=E3=83=AB2" },
+		{ .id =3D 3, .text =3D "82=E3=83=AB3" },
 	}
 };
 =

@@ -8967,10 +8304,10 @@ static struct refresh_test refresh_data_121 =3D {
 	.pdu =3D refresh_121,
 	.pdu_len =3D sizeof(refresh_121),
 	.qualifier =3D 0x01,
-	.file_list[0] =3D {
+	.file_list =3D {{
 		.len =3D 4,
 		.file =3D { 0x3F, 0x00, 0x2F, 0xE2 }
-	}
+	}}
 };
 =

 static struct refresh_test refresh_data_151 =3D {
-- =

1.7.1.86.g0e460.dirty


--===============8988388917386969852==--

