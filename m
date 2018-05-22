Content-Type: multipart/mixed; boundary="===============0673743607438580091=="
MIME-Version: 1.0
From: Florent Beillonnet <florent.beillonnet@gmail.com>
Subject: [PATCH 0/2] *** code puk fix ***
Date: Tue, 22 May 2018 13:08:29 +0000
Message-ID: <1526994511-302-1-git-send-email-florent.beillonnet@ext.actia.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0673743607438580091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

*** The issue was that the puk code was not accepted by ofono. =


First, it appears that the properties were not updated after entering pin c=
ode. =

For instance, after a wrong pin code, the Retries property was still at 3. =

The first patch fixes this issue. =


Then, entering a correct puk code caused ofono to crash.  =

The second patch fixes this issue. ***

Florent Beillonnet (2):
  Adding the ofono_sim_initialized_notify function after
    ofono_sim_inserted_notify, as suggested by Denis Kenzior in this
    commit : 54d56d763e40bc44c99a9b24aa0477bd373ea085
  Rework at_pin_send_puk     It seems that the function at_pin_send_puk
    should have been changed along with at_pin_send, because it's also
    refering to the at_pin_send_cb callback     See this commit :
    ba9f126716db3ae0bf6a3139088d9657cfb8b851

 drivers/atmodem/sim.c | 4 ++--
 plugins/gemalto.c     | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

-- =

1.9.1


--===============0673743607438580091==--

