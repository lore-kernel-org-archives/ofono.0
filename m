Content-Type: multipart/mixed; boundary="===============8048075061891434361=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 6/6] drivers: support for auth NONE
Date: Fri, 05 Oct 2018 04:07:55 +0200
Message-ID: <CAKSBH7ENXpHEnRAgViXEhAvFkj0CeY0x7KcZBT=se_rCw=t-zw@mail.gmail.com>
In-Reply-To: <fb51107c-ab61-2def-b24b-8b3130421d75@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8048075061891434361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Oct 5, 2018 at 4:04 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> >> All right.  But do you also want to mention this behavior in the D-Bus
> >> documentation?  E.g. something to the effect of if AuthenticationMethod
> >> is set to None, then username / password values are ignored?
> >
> > gladly, but I didn't find a document for this.
> > We are going to add it in the lte-api, but the only place I have found
> > for the rest is in the
> > connman-api.
> > Is there some other documents?
> >
>
> I don't believe so.

Shall I prepare a new document gprs-context?

>
> >> Given how closely related it is, it probably should be considered in t=
he
> >> same series.  This is one of those situations where we're messing with
> >> the existing API and so all changes go in or none at all...  But given
> >> that the drivers are expected to handle empty username/passwords
> >> already, I'm okay leaving mbpi as is... but it might be a good idea to
> >> fix it anyway...
> >
> > I can fix it, but need to decide on a default then.
> > It looks to me that 'none' would be a better default than 'chap'.
> > The problem is that 'chap' is assumed so far and therefore it would be
> > regressive.
> >
>
> That's what I would do.  Use none if no password/username/auth method
> are provided.

OK. Please look at what I have submitted.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============8048075061891434361==--

