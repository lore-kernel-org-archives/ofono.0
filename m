Content-Type: multipart/mixed; boundary="===============6903561846886147612=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 3/7] include/voicecall.h : Add support for dialing number at a
 given memory location
Date: Wed, 06 Dec 2017 17:36:00 +0200
Message-ID: <20171206153604.15080-4-philippedeswert@gmail.com>
In-Reply-To: <20171206153604.15080-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6903561846886147612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a new function to be able to dial numbers from memory/favourites.

---
 include/voicecall.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/voicecall.h b/include/voicecall.h
index 79a64bb4..6c4f3f5f 100644
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

2.11.0


--===============6903561846886147612==--

