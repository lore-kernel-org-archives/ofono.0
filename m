Content-Type: multipart/mixed; boundary="===============5042140485810559462=="
MIME-Version: 1.0
From: mail@timomueller.eu
Subject: [PATCH] Delay AT+CLCC request after setup of an outgoing call
Date: Fri, 11 Jan 2013 14:00:31 +0100
Message-ID: <cover.1357896034.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5042140485810559462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Timo Mueller <timo.mueller@bmw-carit.de>

Hi,

this fixes an issue we've been experiencing with the Nokia N9. When
placing an outgoing call from the N9 (AG device) the responded list
does not containt the new outgoing call as the N9 did not update the
list yet.
I tried reqesting the list a second time right after the first request
and the response always contained the call. In conclusion I added a
delay to the first request to give the AG device some time to update
the list before requesting it.

Best regards,
Timo

Timo Mueller (1):
  hfpmodem: Delay AT+CLCC request after outgoing callsetup

 drivers/hfpmodem/voicecall.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- =

1.7.11.7


--===============5042140485810559462==--

