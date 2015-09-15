Content-Type: multipart/mixed; boundary="===============0303413635918077875=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Waiting "PB DONE" message before create the phonebook
Date: Tue, 15 Sep 2015 12:19:25 +0200
Message-ID: <55F7F0AD.4000901@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0303413635918077875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

My module (SIMCOM5216) sends "PB DONE" when the phonebook is ready. So, =

I would like to wait for this message before instantiated the phonebook =

interface in ofono.

In the phonebook AT driver, there is a quirk for ifx vendor. So, I try =

to do the same thing, not with the "+PBREADY" message, but with "PB =

DONE" and it doesn't work.

I don't known where to put my quirk. Can you give me some hints ?

Regards,
Anthony Viallard.


--===============0303413635918077875==--

