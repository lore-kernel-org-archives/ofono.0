Content-Type: multipart/mixed; boundary="===============8281990759125437917=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH 0/2] Improve support for card hot-swapping
Date: Thu, 18 Jun 2015 14:46:55 +0300
Message-ID: <1434628017-28441-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8281990759125437917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Events after inserting a card are as follows. Problem is
async steps 2 and 3+4 complete independently so client can't
rely on Present, CardIdentifier or other properties to know =

when PinRequired and LockedPins are updated.
1. ofono_sim_inserted_notify > emit "Present" =3D=3D> sim_initialize
2. sim_iccid_read_cb > emit "CardIdentifier"
3. sim_efpl_read_cb > __ofono_sim_recheck_pin
4. sim_pin_query_cb
    =3D=3D> "PinRequired" emitted at startup but not on pin-enabled hotswaps
    =3D=3D> "LockedPins" never emitted =


These patches improve the situation.

Tommi Kenakkala (2):
  [sim] Emit LockedPins after pin_type is queried
  [sim] Reset pin_type on card remove

 src/sim.c |   27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

-- =

1.7.9.5


--===============8281990759125437917==--

