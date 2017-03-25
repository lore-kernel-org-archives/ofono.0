Content-Type: multipart/mixed; boundary="===============1086703310743062045=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/2] udevng: add Telit LE910 V1 support
Date: Sat, 25 Mar 2017 15:59:02 -0500
Message-ID: <59f11562-70f9-4a09-0a21-cf64d72945ec@gmail.com>
In-Reply-To: <82eb62ba-6cb6-5653-5068-8611f5332b7c@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1086703310743062045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>
> I need almost exactly the same code for the UC21, but the endpoints are
> different.  What we'll end up with if we do this is an enormous tree of
> cases that all span multiple interfaces, endpoints, and subsystems.
> Because of that, I'm not sure that setup_gobi is the right place to be
> putting this.
>
> The Sierra 7xxx modem does something similar, but uses setup_sierra to
> attach the endpoints and then defers to the gobi driver with:
>
> ofono_modem_set_driver(modem->mode, "gobi"); /* around line 270... in
> setup_sierra */
>
> I suspect that that's a better approach.  I think using setup_gobi makes
> little sense because it doesn't provide a clear association to the
> hardware vendor and the devices from different vendors don't have a
> common configuration.

Good that you're taking a second look, the QMI stuff is not my =

specialty.  Marcel was the one who added QMI support, so he can correct =

me if I'm wrong.  But from what I remember the gobi driver was first =

written to support gobi 3000 cards from Dell.  They were not branded so =

the driver was named gobi.  Later, Sierra and Huawei came out with =

almost the same card with slight differences.  Hence setup_sierra and =

setup_huawei use a gobi driver for certain families.  setup_gobi itself =

is probably only relevant to that original dell card.

>
> setup_telit makes some assumptions about endpoint 2 that you might not
> want to muck about with... in my opinion, doing a setup_telit_le910() is
> not horrid, and better than making a mess of setup_gobi.
>

+1 on not using setup_gobi.  How hard would it be to modify setup_telit =

to handle this?

Regards,
-Denis

--===============1086703310743062045==--

