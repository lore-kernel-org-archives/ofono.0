Content-Type: multipart/mixed; boundary="===============2181413858939629810=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: problem reading ICCID on Telit modem
Date: Fri, 10 Mar 2017 17:13:32 +0100
Message-ID: <dfbe0476-67c9-b0f5-3792-36d60041d0e0@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2181413858939629810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am using a LE910-EU V2 modem (from Telit). I have a SIM card with PIN =

code activated.

With this setup, I never have CardIdentifier property in =

org.ofono.SimManager properties. This is because Ofono fails to read ICCID.


In traces, I see all commands AT+CRSM sent during init (before PIN is =

entered) failing. For example:

Aux: > AT+CRSM=3D192,28590\r
Aux: < \r\n+CME ERROR: 4\r\n


I assume this is an intended behavior from Telit as described in their =

AT reference guide (page 124):

https://www.coniugo.de/tl_files/dateien/downloads/at/AT%20Commands%20LE910.=
pdf

The note says:

this command requires PIN authentication.  However commands READ BINARY =

and READ RECORD can be issued before PIN authentication and if the SIM =

is blocked  (after three failed  PIN authentication  attempts) to access =

the contents of the Elementary Files.

192 is GET RESPONSE, READ BINARY is 176 and READ RECORD is 178


I tried to manage the modem without Ofono to verify that. Here is what I =

tried:

AT+CPIN?
+CPIN: SIM PIN

OK
AT+CRSM=3D192,12258
ERROR
AT+CRSM=3D176,12258,0,0,255
+CRSM: 103,0

OK
AT+CRSM=3D176,12258,0,0,10
+CRSM: 144,0,98331002040320818103

OK
AT+CPIN=3D0000
OK
AT+CRSM=3D192,12258
+CRSM: 144,0,62178202412183022FE28A01058B032F06098002000A880110

OK


So I am able to read ICCID before entering PIN code but to do that, I =

need to use AT+CRSM=3D176,12258,.... and not AT+CRSM=3D192,12258 as it is =

done by Ofono.

I had a look at code in src/sim.c and src/simfs.c and it seems that any =

read command will first call at driver level read_file_info and then =

read_file_transparent.

I don't know how to fix that in Ofono code (if it should be fixed). =

Should I call directly read_file_transparent in sim_initialize (instead =

of ofono_sim_read) to get ICCID ? Should I modify ofono_sim_read to use =

read_file_transparent directly (in some cases@least)?


Any ideas welcome,


Christophe Ronco




--===============2181413858939629810==--

