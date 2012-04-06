Content-Type: multipart/mixed; boundary="===============4616251462761075606=="
MIME-Version: 1.0
From: Mike <puffy.taco@gmail.com>
Subject: hfp voicecall fails to register in ofono with iPhone voicemail
Date: Thu, 05 Apr 2012 23:28:38 -0500
Message-ID: <CAB7rCThxStzipw-2SJ1dc03RwT-+dby1f3L9+=xdXS3HkLXrog@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4616251462761075606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm experiencing an issue where the +CLCC response provided by an
iPhone is ignored in the case of a user utilizing visual voicemail.
The problem here is that the AT+CLCC is being sent in response to a
+CIEV indicating call setup, but by the time the +CLCC response comes
back, the call status is active.  This is a problem because the
callback, sync_dialing_cb, is specifically looking for calls in the
dialing state.  It looks like at least some bits from clcc_poll_cb
should be copied into sync_dialing_cb (or a helper function) because I
would think any time we get a +CLCC we would want to completely update
our call list (and therefore fix the issue I'm encountering).  I'm
still digging into this, but as I'm not familiar with all the quirks
of devices out there, I'm throwing this out there in case anyone has
some ideas on this.

Thanks,
Mike

> ACL data: handle 1 flags 0x02 dlen 141
    L2CAP(d): cid 0x0040 len 137 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 132 fcs 0xa5
      0000: 0d 0a 2b 43 49 4e 44 3a  20 28 22 73 65 72 76 69  ..+CIND: ("se=
rvi
      0010: 63 65 22 2c 28 30 2d 31  29 29 2c 28 22 63 61 6c  ce",(0-1)),("=
cal
      0020: 6c 22 2c 28 30 2d 31 29  29 2c 28 22 63 61 6c 6c  l",(0-1)),("c=
all
      0030: 73 65 74 75 70 22 2c 28  30 2d 33 29 29 2c 28 22  setup",(0-3))=
,("
      0040: 62 61 74 74 63 68 67 22  2c 28 30 2d 35 29 29 2c  battchg",(0-5=
)),
      0050: 28 22 73 69 67 6e 61 6c  22 2c 28 30 2d 35 29 29  ("signal",(0-=
5))
      0060: 2c 28 22 72 6f 61 6d 22  2c 28 30 2d 31 29 29 2c  ,("roam",(0-1=
)),
      0070: 28 22 63 61 6c 6c 68 65  6c 64 22 2c 28 30 2d 32  ("callheld",(=
0-2
      0080: 29 29 0d 0a                                       ))..

...

> ACL data: handle 1 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 14 fcs 0xa5
      0000: 0d 0a 2b 43 49 45 56 3a  20 33 2c 32 0d 0a        ..+CIEV: 3,2..
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(d): cid 0x7800 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 8 fcs 0x7f
      0000: 41 54 2b 43 4c 43 43 0d                           AT+CLCC.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 90:27:E4:58:B8:DC class 0x7a020c type eSCO
< HCI Command: Accept Synchronous Connection (0x01|0x0029) plen 21
    bdaddr 90:27:E4:58:B8:DC
    0000: 40 1f 00 00 40 1f 00 00  ff ff 60 00 ff 3f 00     @...@.....`..=
?.
> HCI Event: Command Status (0x0f) plen 4
    Accept Synchronous Connection (0x01|0x0029) status 0x00 ncmd 1
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x00 handle 257 bdaddr 90:27:E4:58:B8:DC type eSCO
    Air mode: CVSD
> ACL data: handle 1 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 14 fcs 0xa5
      0000: 0d 0a 2b 43 49 45 56 3a  20 32 2c 31 0d 0a        ..+CIEV: 2,1..
> ACL data: handle 1 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 14 fcs 0xa5
      0000: 0d 0a 2b 43 49 45 56 3a  20 33 2c 30 0d 0a        ..+CIEV: 3,0..
> ACL data: handle 1 flags 0x02 dlen 56
    L2CAP(d): cid 0x0040 len 52 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 48 fcs 0xa5
      0000: 0d 0a 2b 43 4c 43 43 3a  20 31 2c 30 2c 30 2c 30  ..+CLCC: 1,0,=
0,0
      0010: 2c 30 2c 22 2a 2a 32 31  31 35 33 2a 2a 22 2c 31  ,0,"**21153**=
",1
      0020: 32 39 2c 22 56 6f 69 63  65 6d 61 69 6c 22 0d 0a  29,"Voicemail=
"..
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 6 fcs 0xa5
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..

--===============4616251462761075606==--

