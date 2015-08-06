Content-Type: multipart/mixed; boundary="===============0025813836493530762=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 1/3] voicecall.h: add dial string validation to driver
Date: Thu, 06 Aug 2015 18:56:59 +0200
Message-ID: <1438880221-23834-3-git-send-email-kubax.t.pawlak@intel.com>
In-Reply-To: <1438880221-23834-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0025813836493530762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/voicecall.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/voicecall.h b/include/voicecall.h
index 4d0b3886b81f78839530f157cf717b633c2f45c3..a8af30090ccc1d97fe429a1cf6a=
9f0beea96bf27 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -133,6 +133,12 @@ struct ofono_voicecall_driver {
 			ofono_voicecall_cb_t cb, void *data);
 	void (*send_tones)(struct ofono_voicecall *vc, const char *tones,
 			ofono_voicecall_cb_t cb, void *data);
+
+	/*
+	 * Check dial string using driver specific validation
+	 */
+	ofono_bool_t (*validate_dial)(const char *number);
+
 };
 =

 void ofono_voicecall_en_list_notify(struct ofono_voicecall *vc,
-- =

1.7.11.7

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============0025813836493530762==--

