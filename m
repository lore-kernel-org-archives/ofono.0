Content-Type: multipart/mixed; boundary="===============2749511264846210055=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC online/offline atoms PATCH 0/4] modem: add modem state watch
Date: Tue, 05 Oct 2010 14:35:08 +0300
Message-ID: <1286278512-3529-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2749511264846210055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

Here is a proposal for adding a mechanism for atoms to follow modem
states, with main interest in online and offline.  There are also
examples of two atoms, sms and gprs, using the watch.

The final patch modifies the isigen driver so that it will create sms
and gprs atoms already in offline. Similar patches are needed for most
of the drivers, too.

--Pekka

--===============2749511264846210055==--

