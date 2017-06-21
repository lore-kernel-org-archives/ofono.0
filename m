Content-Type: multipart/mixed; boundary="===============3445270879000289337=="
MIME-Version: 1.0
From: Vincent CESSON <vincent.cesson@smile.fr>
Subject: gemalto: AGPS functionality
Date: Wed, 21 Jun 2017 13:45:25 +0200
Message-ID: <666978a8d452d99f673b8a28a5332e75@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3445270879000289337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to add AGPS functionality to Gemalto modems. I took a look =

at interface AssistedSatelliteNavigation and implementation in =

drivers/atmodem/gnss.c. Unfortunately, Gemalto does not support AT+CPOS =

command but it uses a custom command: AT^SBNW. Moreover, the positioning =

file expected is not XML but binary format.

The process of loading the binary is:
  - Download binary file from Gemalto server to local memory
  - Initiate binary write command: AT^SBNW=3D"agps",<binary_file_length>
  - Copy binary file from local memory to modem over its application (or =

modem) interface

AT^SBNW immediately returns "CONNECT". Then "AGPS READY: SEND FILE..."
After the modem receives the exact amount of bytes specified in the =

command, it verifies the data and returns one of the following: "AGPS =

END OK", "TIME INFO ERROR", "BAD CRC" or "OK".

So I am facing several issues:
  - How to send binary data from local memory to oFono? DBus message =

with array of bytes?
  - How to send binary data from oFono to modem interface? Does gatchat =

only support strings?
  - How to handle custom result codes? I already tried some hacks, and I =

had to blacklist the response "CONNECT" for instance.

Or maybe it isn't worth the effort implementing it in oFono?

Regards,
Vincent

--===============3445270879000289337==--

