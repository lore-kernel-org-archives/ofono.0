Content-Type: multipart/mixed; boundary="===============0596577543673432038=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [RFC] Multi-recipient SMS implementation proposals
Date: Fri, 24 Aug 2012 12:08:03 +0200
Message-ID: <50375283.9080600@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0596577543673432038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Mutli-recipient SMS implementation is needed to pass GCF test cases =

34.2.9.1 and 34.2.9.2 for GSM; 16.1.9.1 and 16.1.9.2 for WCDMA.
A new task should be added to oFono TODO and as requested by Denis we =

have to discuss first the proposals.
I have in mind 2 solutions:

1- Add a new API in message manager methods using an array of string =

containing all the recipients and returning an array of message paths:
GDBUS_ASYNC_METHOD("SendMultipleMessage",
         GDBUS_ARGS({ "to", "a{s}" }, { "text", "s" }),
         GDBUS_ARGS({ "paths", "a{o}" }),
         sms_send_multiple_message)
It requires also to implement a new function in core based on =

__ofono_sms_txq_submit() to fill in the TX queue with all recipients =

before submitting the message.

2-Modify existing SendMessage API in adding a new mms argument:
GDBUS_ASYNC_METHOD("SendMessage",
         GDBUS_ARGS({ "to", "s" }, { "text", "s" }, { "mms", "i" }),
         GDBUS_ARGS({ "path", "o" }),
         sms_send_message)
It requires to add a new field in struct ofono_sms like 'int send_mms'.
tx_next() function should be modified to check 'int mms' option before =

analysing the TX queue size.
We should determine if send_mms =3D 2 options could be used. Even if we =

don't use it, send_mms should be set to 0 once all the multi-recipient =

SMS have been transmitted.

Kind regards,
Guillaume

--===============0596577543673432038==--

