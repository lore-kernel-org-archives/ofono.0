Content-Type: multipart/mixed; boundary="===============6944172401820022714=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v2] qmimodem: include shutdown in callback cleanup queue
Date: Thu, 30 Mar 2017 14:51:04 +0100
Message-ID: <1490881865-16372-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6944172401820022714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Changes since v1:
- fixed callback->timeout not being saved in qmi_device_shutdown()

Lukasz Nowak (1):
  qmimodem: include shutdown in callback cleanup queue

 drivers/qmimodem/qmi.c | 401 ++++++++++++++++++++++-----------------------=
----
 1 file changed, 180 insertions(+), 221 deletions(-)

-- =

2.7.4


--===============6944172401820022714==--

