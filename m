Content-Type: multipart/mixed; boundary="===============0894053554504149169=="
MIME-Version: 1.0
From: Mike <puffy.taco@gmail.com>
Subject: LG VX8360 HFP non-compliance issue
Date: Thu, 23 Feb 2012 18:49:59 -0600
Message-ID: <CAB7rCTiFvG17u=3x1vB1tOAKyM7xC1QObj43ScEX3Uk16kOeDw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0894053554504149169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm getting weird behaviour from an LG VX8360, connected via bluetooth
HFP.  When the phone connects, I see a CallAdded signal go out over
dbus, despite there being no call on the phone itself.  You can see
the signal below.  The LineIdentification held the actual phone number
of the phone, but I replaced it with "xxxxxxxxxx".  I also copied in
the initial RFCOMM communication.  It looks to me like this phone does
not comply with the HFP spec in that it returns an answer to AT+CLCC
when there is no phone call present (and at that, an index of 0).  It
also happens that the status is a 6, which does not appear to be a
valid status in HFPv1.5.  This just happens to map to the enum
CALL_STATUS_DISCONNECTED, but I'm guessing this was merely
coincidence.  Since the state is broadcast as disconnected, I can
simply ignore it in my GUI application.  However, I'm wondering if
this is something that is better handled in the ofono side?

Thanks,
Mike

signal sender=3D:1.0 -> dest=3D(null destination) serial=3D35
path=3D/hfp/F4FC32DD7E08_0025E5B340D9;
interface=3Dorg.ofono.VoiceCallManager; member=3DCallAdded
   object path "/hfp/F4FC32DD7E08_0025E5B340D9/voicecall00"
   array [
      dict entry(
         string "State"
         variant             string "disconnected"
      )
      dict entry(
         string "LineIdentification"
         variant             string "xxxxxxxxxx"
      )
      dict entry(
         string "Name"
         variant             string ""
      )
      dict entry(
         string "Multiparty"
         variant             boolean false
      )
      dict entry(
         string "RemoteHeld"
         variant             boolean false
      )
      dict entry(
         string "RemoteMultiparty"
         variant             boolean false
      )
      dict entry(
         string "Emergency"
         variant             boolean false
      )
   ]


< RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 12 fcs 0x7f
  0000: 41 54 2b 42 52 53 46 3d  31 31 38 0d              AT+BRSF=3D118.
> RFCOMM(d): UIH: cr 1 dlci 14 pf 1 ilen 0 fcs 0xb9 credits 10
> RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 14 fcs 0xa5
  0000: 0d 0a 2b 42 52 53 46 3a  20 33 35 39 0d 0a        ..+BRSF: 359..
> RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 6 fcs 0xa5
  0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 10 fcs 0x7f
  0000: 41 54 2b 43 49 4e 44 3d  3f 0d                    AT+CIND=3D?.
> RFCOMM(d): UIH: cr 1 dlci 14 pf 1 ilen 132 fcs 0xb9 credits 1
  0000: 0d 0a 2b 43 49 4e 44 3a  20 28 22 63 61 6c 6c 22  ..+CIND: ("call"
  0010: 2c 28 30 2c 31 29 29 2c  28 22 63 61 6c 6c 73 65  ,(0,1)),("callse
  0020: 74 75 70 22 2c 28 30 2d  33 29 29 2c 28 22 73 65  tup",(0-3)),("se
  0030: 72 76 69 63 65 22 2c 28  30 2c 31 29 29 2c 28 22  rvice",(0,1)),("
  0040: 73 69 67 6e 61 6c 22 2c  28 30 2d 35 29 29 2c 28  signal",(0-5)),(
  0050: 22 72 6f 61 6d 22 2c 28  30 2c 31 29 29 2c 28 22  "roam",(0,1)),("
  0060: 62 61 74 74 63 68 67 22  2c 28 30 2d 35 29 29 2c  battchg",(0-5)),
  0070: 28 22 63 61 6c 6c 68 65  6c 64 22 2c 28 30 2d 32  ("callheld",(0-2
  0080: 29 29 0d 0a                                       ))..
> RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 6 fcs 0xa5
  0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 9 fcs 0x7f
  0000: 41 54 2b 43 49 4e 44 3f  0d                       AT+CIND?.
> RFCOMM(d): UIH: cr 1 dlci 14 pf 1 ilen 24 fcs 0xb9 credits 1
  0000: 0d 0a 2b 43 49 4e 44 3a  20 30 2c 30 2c 31 2c 33  ..+CIND: 0,0,1,3
  0010: 2c 30 2c 35 2c 30 0d 0a                           ,0,5,0..
> RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 6 fcs 0xa5
  0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 16 fcs 0x7f
  0000: 41 54 2b 43 4d 45 52 3d  33 2c 30 2c 30 2c 31 0d  AT+CMER=3D3,0,0,1.
> RFCOMM(d): UIH: cr 1 dlci 14 pf 1 ilen 6 fcs 0xb9 credits 1
  0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 10 fcs 0x7f
  0000: 41 54 2b 43 48 4c 44 3d  3f 0d                    AT+CHLD=3D?.
> RFCOMM(d): UIH: cr 1 dlci 14 pf 1 ilen 16 fcs 0xb9 credits 1
  0000: 0d 0a 2b 43 48 4c 44 3a  20 28 31 2c 32 29 0d 0a  ..+CHLD: (1,2)..
> RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 6 fcs 0xa5
  0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 11 fcs 0xa5
  0000: 0d 0a 2b 56 47 53 3a 20  37 0d 0a                 ..+VGS: 7..
< RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 10 fcs 0x7f
  0000: 41 54 2b 43 4d 45 45 3d  31 0d                    AT+CMEE=3D1.
>   0000: 06 00 00 00 10 35 03 19  11 0b 00 f0 35 06 09 00  .....5......5...
    0010: 01 09 00 09 00                                    .....
> RFCOMM(d): UIH: cr 1 dlci 14 pf 1 ilen 6 fcs 0xb9 credits 1
  0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 10 fcs 0x7f
  0000: 41 54 2b 43 4c 49 50 3d  31 0d                    AT+CLIP=3D1.
<   0000: 07 00 00 00 1c 00 19 35  17 35 15 09 00 01 35 03  .......5.5....5.
    0010: 19 11 0b 09 00 09 35 08  35 06 19 11 0d 09 01 02  ......5.5.......
    0020: 00                                                .
> RFCOMM(d): UIH: cr 1 dlci 14 pf 1 ilen 6 fcs 0xb9 credits 1
  0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 10 fcs 0x7f
  0000: 41 54 2b 43 43 57 41 3d  31 0d                    AT+CCWA=3D1.
> RFCOMM(d): UIH: cr 1 dlci 14 pf 1 ilen 6 fcs 0xb9 credits 1
  0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 9 fcs 0x7f
  0000: 41 54 2b 43 49 4e 44 3f  0d                       AT+CIND?.
> RFCOMM(d): UIH: cr 1 dlci 14 pf 1 ilen 24 fcs 0xb9 credits 1
  0000: 0d 0a 2b 43 49 4e 44 3a  20 30 2c 30 2c 31 2c 33  ..+CIND: 0,0,1,3
  0010: 2c 30 2c 35 2c 30 0d 0a                           ,0,5,0..
> RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 6 fcs 0xa5
  0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 9 fcs 0x7f
  0000: 41 54 2b 56 47 53 3d 37  0d                       AT+VGS=3D7.
> RFCOMM(d): UIH: cr 1 dlci 14 pf 1 ilen 6 fcs 0xb9 credits 1
  0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 9 fcs 0x7f
  0000: 41 54 2b 56 47 4d 3d 37  0d                       AT+VGM=3D7.
>   0000: 00 01                                             ..
<   0000: 02 01 04 08                                       ....
> RFCOMM(d): UIH: cr 1 dlci 14 pf 1 ilen 6 fcs 0xb9 credits 1
  0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< RFCOMM(d): UIH: cr 0 dlci 14 pf 0 ilen 8 fcs 0x7f
  0000: 41 54 2b 43 4c 43 43 0d                           AT+CLCC.
>   0000: 10 02 04                                          ...
<   0000: 12 02 01 00 07 06 00 00  3f ff 02 40              ........?..@
> RFCOMM(d): UIH: cr 1 dlci 14 pf 1 ilen 35 fcs 0xb9 credits 1
  0000: 0d 0a 2b 43 4c 43 43 3a  20 30 2c 30 2c 36 2c 30  ..+CLCC: 0,0,6,0
  0010: 2c 30 2c 22 36 31 32 38  36 38 35 37 37 36 22 2c  ,0,"xxxxxxxxxx",
  0020: 30 0d 0a                                          0..
> RFCOMM(d): UIH: cr 1 dlci 14 pf 0 ilen 6 fcs 0xa5
  0000: 0d 0a 4f 4b 0d 0a                                 ..OK..

--===============0894053554504149169==--

