Content-Type: multipart/mixed; boundary="===============7370570071895623912=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/1] fix SIM file reading on MC7304 modem
Date: Fri, 17 Feb 2017 16:06:11 +0100
Message-ID: <20170217150612.24137-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7370570071895623912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I always had errors when reading SIM files on modem MC7304.
Failing function in qmimodem driver is qmi_read_attributes.
Using OFONO_QMI_DEBUG, response from modem is
UIM_resp msg=3D36 len=3D7 [client=3D1,type=3D2,tid=3D274,len=3D19]
QMI:        {type=3D2,error=3DINTERNAL}

Using qmicli (and AT command), I am able to read the same file:
qmicli -d /dev/cdc-wdm0 --uim-get-file-attributes=3D0x3f00,0x7fff,0x6fad
[(null)] Successfully got file '/dev/cdc-wdm0' attributes from the UIM:
Card result:
        SW1: '0x90'
        SW2: '0x00'
File attributes:
        File size: 4
        File ID: 28589
        File type: transparent
        Record size: 0
        Record count: 0
        Read security attributes: (always) (null)
        Write security attributes: (single) adm
        Increase security attributes: (always) (null)
        Deactivate security attributes: (single) adm
        Activate security attributes: (single) adm
        Raw:    62:17:82:02:41:21:83:02:6F:AD:8A:01:05:8B:03:6F:06:01:80:02=
:00:04:88:01:18

I ended up trying to do it using qmicli and comparing binary commands sent =
by
ofono qmimodem driver and qmicli.

Command sent by qmimodem driver in qmi_read_attributes function
01 1b 00 00 0b 01
00 12 01 24 00 0f 00 "Get File Attributes" (0x0024), length 15
01 02 00 06 00 : "Session Information" (0x01), session_type =3D 'Card on sl=
ot 1' application_identifier =3D ''
02 07 00 ad 6f 04 00 3f ff 7f: "File" (0x02)

Command sent by qmicli:
01:1B:00:00:0B:01:
00:01:00:24:00:0F:00: "Get File Attributes" (0x0024), length 15
02:07:00:AD:6F:04:00:3F:FF:7F: "File" (0x02)
01:02:00:00:00 "Session Information" (0x01) session_type =3D 'primary-gw-pr=
ovisioning' application_identifier =3D ''

So difference seemed to be session_type value in "Session Information" para=
meter.
I have no idea what this parameter really means. I changed that to set =

session_type to 'primary-gw-provisioning' in qmimodem driver and ... it fix=
ed
the bug.
I have also tested the fix on a MC7430.


Christophe Ronco (1):
  qmimodem: fix sim file reading on MC7304

 drivers/qmimodem/sim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- =

2.11.0


--===============7370570071895623912==--

