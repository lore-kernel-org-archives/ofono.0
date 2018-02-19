Content-Type: multipart/mixed; boundary="===============6136244388892161930=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/3] Add SystemPath property to modem interface
Date: Mon, 19 Feb 2018 15:57:11 +0100
Message-ID: <1519052234-13973-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <8bc19fa5-e343-143a-69e4-a76496374106@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6136244388892161930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is the patch serie as discussed in this thread of mails.

Christophe Ronco (3):
  udevng: Add modem string SystemPath
  modem: Add SystemPath dbus property
  doc: Add SystemPath to Modem interface

 doc/modem-api.txt | 8 ++++++++
 plugins/udevng.c  | 2 ++
 src/modem.c       | 6 ++++++
 3 files changed, 16 insertions(+)

-- =

2.7.4


--===============6136244388892161930==--

