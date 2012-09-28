Content-Type: multipart/mixed; boundary="===============7639451378178586809=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: PinRequired value during sim initialization
Date: Fri, 28 Sep 2012 10:03:47 +0200
Message-ID: <CABvLYuC_TVS+1AcEdbFq4SNXmV0+WLYfESK0ztL3=QRHAa82RA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7639451378178586809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Immediately after the 'Present' property changes to true on
org.ofono.SimManager, i read the 'PinRequired' property. Because the
sim is not yet initialized this is set to "none". It would be nice if
this was set to "notinitialized", or if there would be an additional
property to know if sim initialization is done.

Thanks,
Cedric

--===============7639451378178586809==--

