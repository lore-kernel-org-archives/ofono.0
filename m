Content-Type: multipart/mixed; boundary="===============3297425094554067535=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] qmi: remove request when it timeouts
Date: Thu, 26 Oct 2017 14:44:33 +0200
Message-ID: <1509021874-14953-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3297425094554067535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Patch proposed to solve problem seen by Eswaran Vinothkumar in thread: Ofon=
o 1.21 crashes with Sierra MC7455.
Tested by Jonas Bonn on his setup.

On my side, I did that to solve an Ofono crash seen with this setup:
 - huawei E3372 USB key plugged
 - MC7304

I stop Ofono, power off and on both modems and restart Ofono immediately. S=
ometimes I see an Ofono crash.

Here is the result of the debug I made:
When sierra modem reappears, Ofono will ask Modem which service it supports=
. Usually modem answers quickly.

From traces, here is what happened:
 - Sep 26 14:11:56: modem asks the list of supported services
 - Sep 26 14:12:01: no answer after 5s, modem asks the list of supported se=
rvices again
 - Sep 26 14:12:03: modem replies to request sent at Sep 26 14:11:56. Ofono=
 crashes during message treatment

Problem is that when a timeout occurs for this type of request, part of the=
 data is released. When answer arrives, this data is used.

I still have the corresponding trace but I don't think it will be very usef=
ul.

Christophe

Christophe Ronco (1):
  qmi: remove request when it timeouts

 drivers/qmimodem/qmi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- =

2.7.4


--===============3297425094554067535==--

