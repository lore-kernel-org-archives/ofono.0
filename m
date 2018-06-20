Content-Type: multipart/mixed; boundary="===============7440918172614054167=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 2/2] voicecall: Implement ofono_voicecall_get_modem
Date: Wed, 20 Jun 2018 18:06:42 +0300
Message-ID: <1529507202-783-2-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1529507202-783-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7440918172614054167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/voicecall.c b/src/voicecall.c
index e4f6a4c..7d4f6a1 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -3734,6 +3734,11 @@ void *ofono_voicecall_get_data(struct ofono_voicecal=
l *vc)
 	return vc->driver_data;
 }
 =

+struct ofono_modem *ofono_voicecall_get_modem(struct ofono_voicecall *vc)
+{
+	return __ofono_atom_get_modem(vc->atom);
+}
+
 int ofono_voicecall_get_next_callid(struct ofono_voicecall *vc)
 {
 	struct ofono_modem *modem;
-- =

1.9.1


--===============7440918172614054167==--

