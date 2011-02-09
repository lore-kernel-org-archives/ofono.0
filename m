Content-Type: multipart/mixed; boundary="===============0308644195297280566=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCHv2 0/7] Move GPRS attach logic to the modem
Date: Wed, 09 Feb 2011 16:27:30 +0200
Message-ID: <201102091627.30686.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0308644195297280566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

       Hello,

This series moves responsibility for GPRS attach to the modem.

In most cases, the modem will attach on-demand when a first context is
activated. This simplifies the oFono interface and implementation.

Some operators require the device be always attached. This is managed
by a new driver callback to set the attach policy.

TBD: configuration option for the policy

Changes since version 1:
 - rebased

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============0308644195297280566==--

