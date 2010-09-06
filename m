Content-Type: multipart/mixed; boundary="===============9199659440930368382=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: status-report expiration
Date: Mon, 06 Sep 2010 19:10:18 +0300
Message-ID: <201009061910.18720.petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9199659440930368382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I'm implementing expiration-logic for status report and have couple of =

questions. =


My expiration function under development goes through every =

addresses and corresponding messages (nodes) from hash-tables, and checks =

the expiration time. But when finding expired message, it cannot remove =

corresponding backup-files, because in this moment backup-file contains the =

whole sms-addressing information (address+numbering plan+number type), but =
key =

of the hash-table (sms-address) doesn't. So, first I thought simply to add =
also =

numbering plan+number type in the hash-key. So what do you think, could it =
be =

a good idea (to include the complete address, but to waste more memory)? OK=
, I =

can also change the function to find backup-file by not taking into account =

numbering plan+number type at all. For example, I can go through backup-fil=
es, =

capture just the sms-address (and message-id), and then search the correct =

node from the hash-table (not necessarily nice solution).

The another question is: is it enough in this moment just to implement =

expiration function (and some unit-tests), as in existing sms-assembly =

solution, when waiting for incoming sms-delivery messages? Seems that in th=
e =

case of sms-assembly, expiration-status for all messages is polled in some =

interval. So, possibly you have already earlier discussed about this issue, =

but how expiration-checking is signaled to sms-util? Will oFono-api take ca=
re =

internally of triggering the expiration-status some how? Or, will oFono-api =

receive expiration-checking calls outside oFono via D-bus.

Br, Petteri


--===============9199659440930368382==--

