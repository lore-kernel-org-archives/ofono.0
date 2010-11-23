Content-Type: multipart/mixed; boundary="===============6971430727680464951=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: CDMA Support
Date: Tue, 23 Nov 2010 07:19:55 -0600
Message-ID: <4CEBBF7B.8090307@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6971430727680464951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

Anyone who has been following the oFono project knows that up until now
oFono has been all about solving the GSM telephony stack problem.  We
wanted to support CDMA, but were simply too busy to do so.  We'd like to
change that.

During the Meego conference several oFono developers held a small
workshop to figure out how to proceed with supporting CDMA and its
related technologies in oFono.  We had a very nice discussion and
managed to hammer out the initial (highly preliminary) proposal for
D-Bus APIs covering CDMA.

The proposal covers the basics of voice calls, data connections,
messaging and network registration details.  The documentation can be
found under:
doc/cdma-network-api.txt
doc/cdma-voicecall-manager-api.txt
doc/cdma-message-api.txt
doc/cdma-connman-api.txt

Please note that so far this is a proposal only and no actual
implementation work has been done.  But I'd like this announcement to be
the starting point for discussion and hopefully patch submissions for
CDMA support :)

Regards,
-Denis

--===============6971430727680464951==--

