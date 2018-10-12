Content-Type: multipart/mixed; boundary="===============1163106289736841888=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [RFC PATCH v3 0/1] atmodem/lte atom
Date: Fri, 12 Oct 2018 15:16:45 +0200
Message-ID: <20181012131646.25397-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1163106289736841888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I would like to have this new version of the lte atom patch reviewed.

I have integrated all Jonas and Denis comments, except Jonas request
to change the cbd in the fuction at_lte_set_default_attach_info, which
I don't know how to do neatly in a driver. In all example I see the
allocation is done in the core, so that there is no problem for the
cleanup. If you could point out an example of structure passed as data
in the drivers, I would use the same.

This is only a partial submit, if it is ok I will send the series.
The differences in this version related to the v2 are:
- use of size_t for lengths
- naming convention for callback function
- restructuring of the cgdcont string according to Jonas wishes
- revovered memory leak in case of failure of g_at_chat_send in
	the function at_lte_set_default_attach_info
- removed useless and out-of-patch change in lte_delayed_register


Giacinto Cifelli (1):
  atmodem/lte: proto and authentication handling

 drivers/atmodem/lte.c | 94 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 10 deletions(-)

--
2.17.1


--===============1163106289736841888==--

