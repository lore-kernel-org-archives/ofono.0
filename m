Content-Type: multipart/mixed; boundary="===============2183385317845196863=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: VS: smtp server problem
Date: Thu, 17 Jun 2010 16:26:40 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A66@jklmail01.ixonos.local>
In-Reply-To: <AANLkTilqE2bx3kv0Cda-yEqqzPXnzSJE0q09_kc1F8TG@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2183385317845196863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi,
>
> I also faced a similar issue 2 days back and the mails were bouncing.
> It got corrected after few hours...
>
>
> regards

OK, now it almost worked. 4 out of 6 got through. I do not want to flood
the mailing list with multiple cloned emails. If the "jam" gets fixed..

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


--===============2183385317845196863==--

