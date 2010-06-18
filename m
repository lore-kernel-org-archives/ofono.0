Content-Type: multipart/mixed; boundary="===============7329259054389560369=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: Patch sending problem, missing pieces.
Date: Fri, 18 Jun 2010 12:55:44 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A6A@jklmail01.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7329259054389560369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Yesterday I tried to send a patch to this list but there were still
some problems. Only 4 out of 6 parts got through.

The missing pieces were my compose-message and patch 2/5.
I paste the compose message here:

"Hi,

Here are the latest modifications for the status report.

Most common use cases are tested in practise. For example:
-Send concatenated message from ofono to phone that is
 powered off.
-Reboot ofono and ofono reads the persistent data from imsi file.
-Power on the phone.
-Ofono receives the status reports and handles them correctly.

Ofono was run under the supervision of valgrind during these tests
and no memory leaks were detected.

And then another thing. For some reason the ofono mailing list
server is not accepting emails from our smtp.ixonos.com server.
So I have to use gmail instead for now.

Br,
Pasi"

And the patch 2/5 is actually same as here:
http://lists.ofono.org/pipermail/ofono/2010-June/002768.html

Hopefully Denis is not going to hang me for operating like this,
but I am going to plead on malfunctioning technology.. :)

Regards,
Pasi


--===============7329259054389560369==--

