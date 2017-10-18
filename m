Content-Type: multipart/mixed; boundary="===============3838304904003475659=="
MIME-Version: 1.0
From: Philippe De Swert <philippe.deswert@nomovok.com>
Subject: [PATCH 1/4] include/voicecall : update ofono_voicecall_driver to
 support call last dialled number
Date: Wed, 18 Oct 2017 17:04:24 +0300
Message-ID: <20171018140427.16143-2-philippe.deswert@nomovok.com>
In-Reply-To: <20171018140427.16143-1-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3838304904003475659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add new DBUS method to enable calling the last dialled number.
---
 include/voicecall.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/voicecall.h b/include/voicecall.h
index 4d0b3886..55beb980 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -60,6 +60,10 @@ struct ofono_voicecall_driver {
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

2.11.0


--===============3838304904003475659==--

