Content-Type: multipart/mixed; boundary="===============6712684018460829948=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 2/5] voicecall: Add support for dialing number at a given
 memory location
Date: Mon, 12 Feb 2018 20:37:15 +0200
Message-ID: <20180212183718.17194-3-philippedeswert@gmail.com>
In-Reply-To: <20180212183718.17194-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6712684018460829948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Philippe De Swert <philippedeswert@gmail.com>

Add a new function to be able to dial numbers from memory/favourites.
---
 include/voicecall.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/voicecall.h b/include/voicecall.h
index 6871a6b5..5b3da6a6 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -61,6 +61,10 @@ struct ofono_voicecall_driver {
 			const struct ofono_phone_number *number,
 			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
 			void *data);
+	/* dials a number at a given memory location */
+	void (*dial_memory)(struct ofono_voicecall *vc,
+			unsigned int memory_location, ofono_voicecall_cb_t cb,
+			void *data);
 	/* Dials the last number again, this handles the hfp profile last number
          * dialing with the +BLDN AT command
          */
-- =

2.11.0


--===============6712684018460829948==--

