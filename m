Content-Type: multipart/mixed; boundary="===============8111942743298543655=="
MIME-Version: 1.0
From: Philippe De Swert <philippe.deswert@nomovok.com>
Subject: [PATCH 5/8] include/voicecall.h : Add support for dialing number at a
 given memory location
Date: Tue, 31 Oct 2017 10:39:36 +0200
Message-ID: <20171031083939.4393-6-philippe.deswert@nomovok.com>
In-Reply-To: <20171031083939.4393-1-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8111942743298543655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/voicecall.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/voicecall.h b/include/voicecall.h
index 6871a6b5..b3d5bc06 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -61,6 +61,11 @@ struct ofono_voicecall_driver {
 			const struct ofono_phone_number *number,
 			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
 			void *data);
+	/* dials a number at a given memory location */
+	void (*dial_memory)(struct ofono_voicecall *vc,
+			long int memory_location,
+			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+			void *data);
 	/* Dials the last number again, this handles the hfp profile last number
          * dialing with the +BLDN AT command
          */
-- =

2.14.2


--===============8111942743298543655==--

