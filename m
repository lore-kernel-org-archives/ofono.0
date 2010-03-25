Content-Type: multipart/mixed; boundary="===============0511134872185448412=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Quick report from PPP testing
Date: Wed, 24 Mar 2010 17:20:54 -0700
Message-ID: <1269476454.11714.155.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0511134872185448412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

so I just downloaded the Linux kernel via the PPP connection with my
Rogers' Novatel UMTS stick.

: < \r\n+CGREG: 2,1,FE38,EBA6\r\n\r\nOK\r\n
Registered to GPRS network, roaming=3DFalse
: > ATD*99***1#\r
: < \r\nCONNECT HSDPA 7.2\r\n
oops -- found acked option 2 we didn't request
Unknown ipcp option type 130
oops, option wasn't acceptable
Unknown ipcp option type 132
oops, option wasn't acceptable
Unknown ipcp option type 130
oops, option wasn't acceptable
Unknown ipcp option type 132
oops, option wasn't acceptable
Unknown ipcp option type 130
oops, option wasn't acceptable
Unknown ipcp option type 132
oops, option wasn't acceptable
IP Address: 172.28.89.39
Primary DNS Server: 64.71.255.198
Secondary DNS Server: 64.71.255.253

The IPCP negotiation looks a bit funky. Can we get some more debug code
in there. I like to know which side tried this requests. Also speeding
this up would be helpful.

Denis, I had to add custom terminators for this card since it reports
the network speed after CONNECT string. Don't we wanna just accept every
CONNECT * strings here?

Regards

Marcel



--===============0511134872185448412==--

