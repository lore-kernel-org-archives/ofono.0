Content-Type: multipart/mixed; boundary="===============7740441013600537647=="
MIME-Version: 1.0
From: Bassem BOUBAKER <bassem.boubaker@actia.fr>
Subject: Issue with an URC falling into an AT command response
Date: Wed, 28 Feb 2018 11:52:07 +0100
Message-ID: <20180228105207.GA15442@bboubake>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7740441013600537647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Community,

I'm facing an issue with an ofono segfault because of an URC is received be=
tween the AT command and its response.

Below is my case:

	ofonod[826]: App: > AT^SMONI\r
	ofonod[826]: App: < \r\n^SREG: 2,0\r\n
	ofonod[826]: App: < \r\n^SMONI: Searching\r\nSearching\r\n\r\nOK\r\n

The URC ^SREG is captured in the callback function related to handling the =
response of AT^SMONI.

I have two questions here:

i) how can I isolate only the response of AT^SMONI without nasty hacking th=
e response cb function.

ii) How can I force ofono to go through the registered callback of the URC =
^SREG in this particular case.

Any ideas?



Thanks,
Bassem.







--===============7740441013600537647==--

