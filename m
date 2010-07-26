Content-Type: multipart/mixed; boundary="===============2262963229439850274=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 11/20] SMS: rename create_tx_queue_entry() to
 tx_queue_entry_new()
Date: Mon, 26 Jul 2010 13:49:53 -0700
Message-ID: <1280177393.26204.178.camel@localhost.localdomain>
In-Reply-To: <4C4A1F89.1010406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2262963229439850274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-07-23 at 16:02 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> On 07/23/2010 03:59 PM, Inaky Perez-Gonzalez wrote:
> > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > =

> > This is for symmetry with tx_queue_entry_free()
> > ---
> >  src/sms.c |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> > =

> =

> Applied with a minor tweak to the commit header.

Please *don't* do that; remember the minor extra work it causes you
multiplies by ten for the person that has to sort out the conflict in
his git trees and figure out the kind of change you did.



--===============2262963229439850274==--

