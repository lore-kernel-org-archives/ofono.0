Content-Type: multipart/mixed; boundary="===============1728300790798101489=="
MIME-Version: 1.0
From: Lasse.Kunnasluoto@tieto.com
Subject: SAT support in oFono
Date: Fri, 21 Jan 2011 10:44:07 +0200
Message-ID: <3A42A4F4F2ABA44EBD5853ED099266471247BFC116@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1728300790798101489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

I am checking what is the level of SAT/STK support in ofono and have a coup=
le of questions. The current implementation contains support for basic STK =
commands, like menus, inputs, calls, sms and so on. In TODO, there is only =
REFRESH command on the list.

Is there plans or ideas to extend the support in oFono Core with more compl=
ex STK features like (3GPP TS 31.111):
- Call control by USIM
- MO SMS Control by USIM
- BIP (Bearer independent protocol), including commands like OPEN CHANNEL, =
CLOSE CHANNEL, SEND/RECEIVE DATA
- Extend support in PROVIDE LOCAL INFO
- EVENT DOWNLOAD / SET UP EVENT LIST

Or is some of these assumed to be handled in modem or driver side?

BR,
-Lasse

--===============1728300790798101489==--

