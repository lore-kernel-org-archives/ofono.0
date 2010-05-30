Content-Type: multipart/mixed; boundary="===============6287235288157713854=="
MIME-Version: 1.0
From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RTNL sync or async when creating GPRS Context for STE modem.
Date: Sun, 30 May 2010 16:45:04 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C10579169C37B38A@EXDCVYMBSTM005.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6287235288157713854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

I have finally got around to do some coding in oFono again,
and have started to look into creating CAIF Network Interface =

using RTNL, instead using socket ioctls.
 =

I have started out by doing the RTNL handling async, =

i.e. registering the RTNL socket with g_io_add_watch etc.
But I'm not really happy with the code as it feels
unnecessary complex, introduces new states in gprs-context.c. etc.

So I would like to do the RTNL handling synchronous instead,
as this would reduce complexity. But I just wanted your opinion
on this before I start refactoring my code.

Do you see any issues with doing RTNL request synchronous
i.e. sending out RTM_NEWLINK request and a waiting for =

RTM_NEWLINK response followed by NLMSG_ERROR,
(or just NLMSG_ERROR if unsuccessful)?


Regards
Sjur


--===============6287235288157713854==--

