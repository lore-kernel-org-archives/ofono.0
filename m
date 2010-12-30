Content-Type: multipart/mixed; boundary="===============8458516679493099993=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: unsolicited multiline result
Date: Thu, 30 Dec 2010 18:55:54 +0200
Message-ID: <1293728155-1781-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8458516679493099993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


This patch is for handling multiline unsolicited result-codes.
So state-machine used for handling result-bytes (gsmv1_feed) is set to the =
multiline-response
state. Otherwise next lines from the result-buffer are not handled correctl=
y,
and response-handling will get stuck.

In the other hand, this correction keeps result-handling still unchanged.
So single line is notified to the upper level (atoms) at a time, not all li=
nes of the result.
For instance: network-emergency numbers cannot be collect to the one single=
 notification yet.
-- See us at Mobile World Congress, 14-17 February 2011, in Barcelona, Spai=
n. Visit the Ixonos booth Hall 1, # 1E19.


--===============8458516679493099993==--

