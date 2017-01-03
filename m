Content-Type: multipart/mixed; boundary="===============1915110218045109372=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/1] add send_passwd feature to qmimodem sim driver
Date: Tue, 03 Jan 2017 11:55:36 +0100
Message-ID: <20170103105537.19063-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1915110218045109372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add ability to send PIN to modem (using QMI_UIM_VERIFY_PIN command).
This has been tested on MC7304 and MC7430 modems.
Password state and number of retries can now change after driver
initialization. So query_passwd_state and query_pin_retries are
implemented by asking modem for this information rather than remembering
initial value.
A retry has been implemented on query_passwd_state command. This command
is called just after PIN is entered and return a temporary error
(seen on MC7430).

Christophe Ronco (1):
  MC7430: Add send_passwd feature to qmimodem sim driver

 drivers/qmimodem/sim.c | 278 +++++++++++++++++++++++++++++++++++++++------=
----
 drivers/qmimodem/uim.h |  11 ++
 2 files changed, 232 insertions(+), 57 deletions(-)

-- =

2.11.0


--===============1915110218045109372==--

