Content-Type: multipart/mixed; boundary="===============1980741093788065335=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 0/6] PPP Patches v3
Date: Tue, 23 Mar 2010 10:34:02 -0700
Message-ID: <20100323103402.5c81d576@kcaccard-MOBL3>
In-Reply-To: <1269326714.11714.42.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1980741093788065335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Mar 2010 23:45:14 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> And there was another problem with one variable being
> guint16, but the is_option casts it back to guint8. We can't really have
> that. Once you start casting on that scale the compiler will not warn
> you about type mismatches or if the value of argument is too big for its
> type.

Can you please let me know which git commit this fix you made was?  I =

want to review it because all of the option types should only be a byte
anyway, so I am trying to figure out if there was a mistake somewhere =

where we were using is_option to examine a 16 bit value.  I searched
through the git log and can't figure out where this change was.  I
can see where you changed the option type we are comparing to a regular
guint to avoid compiler problems, but not the other issue you mentioned.

--===============1980741093788065335==--

