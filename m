Content-Type: multipart/mixed; boundary="===============1384682947605981469=="
MIME-Version: 1.0
From: Harald Welte <laforge@gnumonks.org>
Subject: Re: use libqmi or .json definition for qmi calls
Date: Mon, 22 May 2017 10:54:36 +0200
Message-ID: <20170522085436.rmpj55rjp22bcvml@nataraja>
In-Reply-To: <c1064a32-f957-e01b-58bf-542b90895118@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1384682947605981469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, May 16, 2017 at 01:33:56PM -0500, Denis Kenzior wrote:
> libqmi is quite large, depends on weird glib features and is really not an
> option for us.  Furthermore, we will eventually be migrating away from gl=
ib,
> so introducing additional dependencies or libraries that depend on glib w=
ill
> just make our life harder in the future.

I can follow that argument.  However, it only applies to libqmi, and not
to uqmi, which doesn't use glib.  On the other hand, it appears to be
using libubox, which is very OpenWRT/LEDE specific.

> When we started our QMI driver, libqmi was still in its early stages. Much
> of the work understanding the protocol still had to be done by hand.  Back
> then we decided that auto-generating the code wasn't worthwhile.  It is
> almost certain that there will not be multiple QMI based drivers.  So by =
the
> time you wrote the JSON definition or equivalent, you could have implemen=
ted
> the driver method that used it.

This explains the history, sure.

However, it would still be good to get an opinion on what your thoughts
are to use code generation from the JSON file instead?  The situation
today is different:  There is a JSON File that appears to have more
complete QMI coverage than ofono, so it's either "manually writing code
to catch up with that file" or "be open towards generation of ofono QMI
code from that JSON file"

Let's assume somebody would work on generating code from the JSON file
that had no dependencies to "weird glib features" or glib at all, or a
library like libubox:
Would you think it as worth-while to merge such a QMI driver, either as
separate driver, or even as a replacement to the current one?

The amount of interfaces, interface versions and messages on QMI is only
going to increase over time.

Regards,
	Harald
-- =

- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.o=
rg/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--===============1384682947605981469==--

