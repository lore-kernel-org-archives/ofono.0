Content-Type: multipart/mixed; boundary="===============6746377680141702924=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [SMS D-Bus 04/23] write_file: make transaction-safe
Date: Fri, 02 Jul 2010 14:25:22 -0700
Message-ID: <1278105922.2327.45.camel@localhost.localdomain>
In-Reply-To: <4C2E4E7F.4040407@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6746377680141702924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-07-02 at 13:39 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> On 06/25/2010 06:15 PM, Inaky Perez-Gonzalez wrote:
> > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > =

> > write_file(), as written wasn't transaction-safe; a crash bewtween a
> > file being open and the buffer being written before a safe close would
> > leave the file with a set of undetermined contents.
> > =

> > Modified to the file is written to a temporary file name; once
> > completed, it is renamed to the final name. This way, a crash in the
> > middle doesn't leave half-baked files.
> =

> Patch is fine, but:
> =

> Applying: write_file: make transaction-safe
> /home/denkenz/ofono-master/.git/rebase-apply/patch:13: trailing whitespac=
e.
> /*

Yup, sorry, I missed those. They have been cleaned up already -- next
resubmit will have it fixed.



--===============6746377680141702924==--

