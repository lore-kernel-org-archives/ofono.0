Content-Type: multipart/mixed; boundary="===============4020602401224825748=="
MIME-Version: 1.0
From: Philippe De Swert <philippe.deswert@nomovok.com>
Subject: [PATCH V2 1/8] include/voicecall : update ofono_voicecall_driver to
 support call last dialled number
Date: Tue, 31 Oct 2017 10:39:32 +0200
Message-ID: <20171031083939.4393-2-philippe.deswert@nomovok.com>
In-Reply-To: <20171031083939.4393-1-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4020602401224825748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add new DBUS method to enable calling the last dialled number.
---
 include/voicecall.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/voicecall.h b/include/voicecall.h
index eb897e5e..6871a6b5 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -61,6 +61,10 @@ struct ofono_voicecall_driver {
 			const struct ofono_phone_number *number,
 			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
 			void *data);
+	/* Dials the last number again, this handles the hfp profile last number
+         * dialing with the +BLDN AT command
+         */
+	void (*dial_last)(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb, vo=
id *data);
 	/* Answers an incoming call, this usually corresponds to ATA */
 	void (*answer)(struct ofono_voicecall *vc,
 			ofono_voicecall_cb_t cb, void *data);
-- =

2.14.2


--===============4020602401224825748==--

