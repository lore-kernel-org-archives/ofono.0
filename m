Content-Type: multipart/mixed; boundary="===============4275616145930140163=="
MIME-Version: 1.0
From: Jonathan Wilson <jfwfreo@tpgi.com.au>
Subject: Looking for help with ofono Cell Broadcast SMS code
Date: Sat, 25 Jun 2011 18:55:29 +0800
Message-ID: <4E05BEA1.6040503@tpgi.com.au>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4275616145930140163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I am currently working on getting Cell Broadcast SMS working on the Nokia =

N900 using the stock telephony stack (yes I know ofono supports the N900 =

but since I dont want to have to replace the dialer, messaging app and who =

knows what else, sticking with the stock telephony stack is the only option)

I have already gotten the low level telephony stack parts working and have =

a test app that's wired up to a signal sent by the telephony stack.

This signal gives me the following bits of information for the Cell =

Broadcast SMS message:
data
data length
serial number
message ID
data coding scheme
page

With my test dumper I was able to dump the one Cell Broadcast SMS message I =

can get the local cell tower to send me (a single page message containing =

the "name" of the cell tower and a message identifier of 50). I was then =

able to hack away at one of the ofono test programs to get this cell =

broadcast SMS message to decode so I could verify that I was getting the =

correct data.

What I am looking for is:
1.Some information and/or help in figuring out the right way to use the all =

the various ofono Cell Broadcast decode functions to decode Cell Broadcast =

messages (single and multiple page) and get not just the content of the =

message but also information on the type of message and other relavent item=
s.
2.Some information on just which bits of ofono I need to link into my Cell =

Broadcast SMS widget (which will be GPL) in order to be able to use the =

Cell Broadcast decode functions without pulling in the rest of ofono.
and 3.Any and all example Cell Broadcast SMS messages I can get my hands on =

to allow me to verify the parsing and display code once its written (i.e. =

the stuff that takes the message, decodes it with the ofono Cell Broadcast =

functions and does something useful with the result)

Anything people can point me at regarding this stuff will be much =

appreciated (if anyone has userspace code that handles Cell Broadcast SMS =

messages which could provide guidance as to how UI for CBSMS should work, =

that would help too)

--===============4275616145930140163==--

