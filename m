Content-Type: multipart/mixed; boundary="===============0915490222102246228=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 0/6] PPP Patches v3
Date: Mon, 22 Mar 2010 20:22:02 -0700
Message-ID: <20100322202202.252f0bae@kcaccard-MOBL3>
In-Reply-To: <1269310920.4851.32.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0915490222102246228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Mar 2010 19:22:00 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Kristen,
> =

> > > Changes since v2 - corrected whitespace. =

> > =

> > all the patches have been applied.
> > =

> > So form now on please send smaller patches as soon as you have them
> > ready and tested. If you need comments or have questions, you can use
> > the mailing list as well.
> =

> some additional comments from my side.
> =

> If you have variables that are only valid inside the scope of a
> statement, then I prefer if you only declare them there. This makes the
> code a bit simpler to read. Check the patch I just pushed to give you an
> example.
> =

> Also please find access to a 32-bit system if you are running 64-bit or
> vice versa. Our build system is strict and will turn turn all casting
> mistakes in an error.
> =

> Please be present on #ofono IRC as much as possible so people can report
> such things. Remember that your code is now part of the tree and it can
> break the build.
> =

> Regards
> =

> Marcel
> =

> =


Marcel - I just started reviewing the changes you made and the first =

patch I hit I discovered that you broke something.  Would you like to
revert the patches and let me review them first, or should I just send =

a patch to the mailing list to fix what you broke?

--===============0915490222102246228==--

