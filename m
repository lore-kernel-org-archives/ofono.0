Content-Type: multipart/mixed; boundary="===============3405900945784351894=="
MIME-Version: 1.0
From: Pau Espin Pedrol <pespin@sysmocom.de>
Subject: crash in drivers/qmimodem/gprs.c:extract_ss_info()
Date: Tue, 12 May 2020 11:32:24 +0200
Message-ID: <c5efe8ea-99a6-1e94-c31a-21a1de7b5832@sysmocom.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3405900945784351894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I reported an ofono recurring crash together with the corresponding
investigation & logs yesterday on #ofono IRC channel. The crash appears
on our osmo-gsm-tester setup several times per day.

In my opinion, the summary for the crash is following race condition:
1- We submit QMI request using qmi_attached_status() and expect callback
to be received at some point
2- While waiting for the response, modem announces becoming offline
(modem_change_state() MODEM_STATE_ONLINE -> MODEM_STATE_OFFLINE). Here
gprs_remove() is called which frees all related structures
3- We receive the QMI response of qmi_attached_status() and
get_ss_info_cb() is called, which eventually crashes because the "gprs =3D
cbd->user" is already gone, so use after free occurs and process
receives SIGSEGV.

The details of the issue can be found here:
https://osmocom.org/issues/4542

so far Denis proposed something like this on IRC:
* Tracking outstanding requests and cancel them. For instance GAtChat
(via g_at_chat_clone) creates a facade object instead, and assigns a
=E2=80=98group id=E2=80=99 to it.  So destroying the facade object also can=
cels any
outstanding requests associated with it. QMI should ideally do something
similar.
* An easy fix would be to store the request id for whatever NAS
request you=E2=80=99re doing in gprs.c and cancel it in gprs_remove. But you
might run into this in other places in drivers/qmimodem/gprs.c


I would welcome if someone with more knowledge of ofono code base than I
could have a look at this and provide some fix, or at least some
detailed pointers at the work required. I am happy to collaborate and
test the patches as needed.

Best Regards,
Pau
-- =

- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
* sysmocom - systems for mobile communications GmbH
* Alt-Moabit 93
* 10559 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte
--===============3405900945784351894==--

