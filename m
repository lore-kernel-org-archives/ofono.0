Content-Type: multipart/mixed; boundary="===============1537033030621296771=="
MIME-Version: 1.0
From: Joey Hewitt <joey@joeyhewitt.com>
Subject: [PATCH 0/2] gobi: support SMD devices (smartphone SoC)
Date: Sat, 14 Apr 2018 12:02:55 -0600
Message-ID: <cover.1523728975.git.joey@joeyhewitt.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1537033030621296771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These add support for Qualcomm-based smartphone modems.

The first is fairly straightforward: searching for "rpmsg"-subsystem device=
s and supporting them in gobi as a serial device. A friend has tested it on=
 the mainline kernel, with the help of something like `rpmsgexport /dev/rpm=
sg_ctrl0 DATA5_CNTL` (https://github.com/andersson/rpmsgexport) and then gi=
ving the created rpmsg node OFONO_DRIVER=3Dgobi property.

The second is uglier, and maybe controversial, since it's for Qualcomm's fo=
rked kernel. The smdpkt device doesn't support polling for write, so oFono =
would wait forever on the poll. This would probably be a 5-line fix in the =
kernel, but there are thousands of kernel forks, so I thought it might be b=
etter to workaround in oFono. I've tested it on Samsung S4 Mini LTE, runnin=
g a kernel based on the MSM fork.

Joey Hewitt (2):
  gobi: support rpmsg device node (SMD channel)
  gobi/qmi: support smdpkt device (MSM kernel forks)

 drivers/qmimodem/qmi.c | 33 ++++++++++++++++++++++---
 drivers/qmimodem/qmi.h |  6 ++++-
 plugins/gobi.c         |  7 ++++--
 plugins/udevng.c       | 66 +++++++++++++++++++++++++++++-----------------=
----
 4 files changed, 77 insertions(+), 35 deletions(-)

-- =

2.7.4


--===============1537033030621296771==--

