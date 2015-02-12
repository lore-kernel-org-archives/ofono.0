Content-Type: multipart/mixed; boundary="===============6396614696022171680=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH 0/2] SMS-DELIVER Alphanum TP-OA encoding/decoding fix
Date: Thu, 12 Feb 2015 17:09:58 +0200
Message-ID: <1423753800-17543-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6396614696022171680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are problems with some real-life scenarios where SMS-DELIVER originat=
or
address is an alphanumeric string with 11 chars, some extended ASCII (like =
=C3=A4=C3=B6=C3=BC).
Ofono assumes Short Message's TP-OA max length is 11 octets (ref [1] and [2=
])
and rejects messages whose _decoded_ alphanumeric address takes more
than 11 bytes.
However, [3] defines Alphanumeric address is 7-bit coded referring to [4].
7-bit alphabet coding allows packing up to twelve 8-bit characters into 11
octets. The limit applies to octets, not to decoded characters or bytes.
Here is a fix proposals for your consideration,
with these a phone utilizing ofono will accept such short messages.
FYI a commercial Android phone reference handles the same messages fine.
Note: I've been able to test only using max 11-character TP-OA, but referre=
d =

specifications suggest a 12th char would fit into the 11 octets as well.

REFERENCES:
[1] 24.011 8.2.5.1 Originator address element
[2] 23040 9.2.2.1 SMS=E2=80=91DELIVER type
[3] 23040 9.1.2.5 Address fields
[4] 3GPP TS 23.038 GSM 7=E2=80=91bit default alphabet
[5] Problem 1 callstack:
 ofono_sms_deliver_notify
  src.sms:handle_deliver
   src.sms:sms_dispatch
    src/sms.c:compute_incoming_msgid
     src/smsutil.c:sms_encode
       src/smsutil.c:encode_deliver
        src/smsutil.c:sms_encode_address_field
         if (len > 11)
[6] Problem 2 callstack:
 ofono_sms_deliver_notify
  src/smsutil.c:sms_decode
   src/smsutil.c:decode_deliver
    src/smsutil.c:sms_decode_address_field
     if (strlen(utf8) > 20

Tommi Kenakkala (2):
  sms: SMS-DELIVER TP-OA Alphanum decoding and encoding fix
  unit: SMS-DELIVER decoding/encoding test for long alphanum address

 src/smsutil.c   |   12 +++++++++---
 src/smsutil.h   |    6 +++++-
 unit/test-sms.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 62 insertions(+), 8 deletions(-)

-- =

1.7.9.5


--===============6396614696022171680==--

