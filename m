Content-Type: multipart/mixed; boundary="===============6940018994076716774=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 2/3] modem: some debugs added for indicating modem state
 change
Date: Wed, 06 Oct 2010 17:17:56 +0300
Message-ID: <1286374677-2932-3-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1286374677-2932-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6940018994076716774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 7a29edf..583b79f 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -330,6 +330,8 @@ static void flush_atoms(struct ofono_modem *modem, enum=
 modem_state new_state)
 	GSList *prev;
 	GSList *tmp;
 =

+	DBG("");
+
 	prev =3D NULL;
 	cur =3D modem->atoms;
 =

@@ -367,6 +369,8 @@ static void modem_change_state(struct ofono_modem *mode=
m,
 	enum modem_state old_state =3D modem->modem_state;
 	ofono_bool_t new_online =3D new_state =3D=3D MODEM_STATE_ONLINE;
 =

+	DBG("old state: %d, new state: %d", old_state, new_state);
+
 	if (old_state =3D=3D new_state)
 		return;
 =

-- =

1.6.3.3



--===============6940018994076716774==--

