Content-Type: multipart/mixed; boundary="===============9167912010521782526=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [originated PATCH 0/2]
Date: Mon, 06 Sep 2010 18:09:26 +0300
Message-ID: <1283785768-4509-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9167912010521782526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

This patch adds the "Originated" property to the VoiceCall interface. It
is used to determine if the call is originated from the mobile or not.

The originated information can be deducted from the call state assuming
the client does follow the call states from the beqginning. However,
after the call gets activated call states are common for the mobile
originated and mobile terminated calls.

--Pekka


--===============9167912010521782526==--

