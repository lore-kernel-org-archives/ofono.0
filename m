Content-Type: multipart/mixed; boundary="===============3809773595205999251=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 2/5] voicecall: add SSN function declarations
Date: Fri, 04 Mar 2011 19:12:31 +0200
Message-ID: <71ca00270d48a3652c7c030fff8889be9cc69e32.1299258404.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1299258404.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3809773595205999251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/voicecall.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/voicecall.h b/include/voicecall.h
index f00eb08..5e6da02 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -160,6 +160,12 @@ void ofono_voicecall_set_data(struct ofono_voicecall *=
vc, void *data);
 void *ofono_voicecall_get_data(struct ofono_voicecall *vc);
 int ofono_voicecall_get_next_callid(struct ofono_voicecall *vc);
 =

+void ofono_voicecall_ssn_mo_notify(struct ofono_voicecall *vc, unsigned in=
t id,
+					int code, int index);
+void ofono_voicecall_ssn_mt_notify(struct ofono_voicecall *vc, unsigned in=
t id,
+					int code, int index,
+					const struct ofono_phone_number *ph);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.0.4


--===============3809773595205999251==--

