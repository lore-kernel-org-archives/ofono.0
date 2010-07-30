Content-Type: multipart/mixed; boundary="===============6130956420722405959=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 19/20] SMS: introduce sms_msg_cancel and its D-Bus wrapper
Date: Fri, 30 Jul 2010 16:12:39 -0700
Message-ID: <1280531559.3982.9.camel@localhost.localdomain>
In-Reply-To: <4C4F147E.5000706@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6130956420722405959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-07-27 at 10:16 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> On 07/23/2010 04:00 PM, Inaky Perez-Gonzalez wrote:
> > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > =

> > This introduces the ability to cancel a pending SMS message,
> > accessible via an internal API and over a D-Bus wrapper.
> > =

> > Sending a note to the network to cancel an in-transit message is not
> > yet implemented.
> > =

> > Note the test case code requires follow up commits that propagate the
> > message's state changes over D-Bus.
> > ---
> >  src/sms.c                |   63 +++++++++++++++++
> >  src/smsutil.h            |   15 ++++
> >  test/test-sms-msg-cancel |  173 ++++++++++++++++++++++++++++++++++++++=
++++++++
> =

> Multiple patches please.  One for each directory.
> ...
>

> You're ignoring about every part of the coding standard in this chunk...
> =

> ...

> And again ignoring the coding standard...

All feedback for this fixed, thanks.



--===============6130956420722405959==--

