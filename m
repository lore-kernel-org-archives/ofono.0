Content-Type: multipart/mixed; boundary="===============8320711191492336036=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem/sim: added vendor Gemalto
Date: Mon, 24 Sep 2018 23:04:33 -0500
Message-ID: <08079727-3969-e420-52da-1d8fd9f63066@gmail.com>
In-Reply-To: <CAKSBH7Et8z4bX=PMJyTJ2oR0tAxvy55Rbz6cOH8gJ2H4UR7LkA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8320711191492336036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> But the VENDOR_CINTERION remains in the code, there are no changes for =

> the plugin.
> =


That's exactly the point.  You have taken out all VENDOR_CINTERION =

logic, yet plugins/gemalto.c still sets VENDOR_CINTERION for the sim =

atom.  So now you broke that driver.  Your change set is not =

self-contained.  If I apply this patch and you get hit by a bus =

tomorrow, the plugin remains broken for everyone.

Regards,
-Denis

--===============8320711191492336036==--

