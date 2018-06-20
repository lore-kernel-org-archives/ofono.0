Content-Type: multipart/mixed; boundary="===============4765341255393248019=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 1/2] include: Add ofono_voicecall_get_modem
Date: Wed, 20 Jun 2018 18:06:41 +0300
Message-ID: <1529507202-783-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4765341255393248019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/voicecall.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/voicecall.h b/include/voicecall.h
index 5b3da6a..a704b65 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -160,6 +160,8 @@ void ofono_voicecall_disconnected(struct ofono_voicecal=
l *vc, int id,
  */
 void ofono_voicecall_mpty_hint(struct ofono_voicecall *vc, unsigned int id=
s);
 =

+struct ofono_modem *ofono_voicecall_get_modem(struct ofono_voicecall *vc);
+
 int ofono_voicecall_driver_register(const struct ofono_voicecall_driver *d=
);
 void ofono_voicecall_driver_unregister(const struct ofono_voicecall_driver=
 *d);
 =

-- =

1.9.1


--===============4765341255393248019==--

