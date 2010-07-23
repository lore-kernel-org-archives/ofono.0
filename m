Content-Type: multipart/mixed; boundary="===============1931144663527817173=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 02/20] write_file: make transaction-safe
Date: Fri, 23 Jul 2010 15:31:59 -0700
Message-ID: <1279924319.26204.135.camel@localhost.localdomain>
In-Reply-To: <4C4A104B.2080406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1931144663527817173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-07-23 at 14:57 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> On 07/23/2010 03:59 PM, Inaky Perez-Gonzalez wrote:
> > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > =

> > write_file(), as written wasn't transaction-safe; a crash bewtween a
> > file being open and the buffer being written before a safe close would
> > leave the file with a set of undetermined contents.
> > =

> > Modified to the file is written to a temporary file name; once
> > completed, it is renamed to the final name. This way, a crash in the
> > middle doesn't leave half-baked files.

all fixed, thanks



--===============1931144663527817173==--

