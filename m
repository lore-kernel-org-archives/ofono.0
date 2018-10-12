Content-Type: multipart/mixed; boundary="===============5993484425076287622=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/6] lte-api: protocol and authentication properties
Date: Fri, 12 Oct 2018 06:13:49 +0200
Message-ID: <CAKSBH7FFGZa39=HLuwPV0vkjbn7=88ZHqNLZULzdMjk537byLQ@mail.gmail.com>
In-Reply-To: <1df9304c-e4c4-8465-1f1b-0e47c95c08c1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5993484425076287622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Oct 12, 2018 at 6:06 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> >> Reading through your patches, I'm missing an overarching explanation of
> >> why we need this.  Do you really have an LTE network in range that
> >> requires authentication for the default APN?
> >
> > yes, quite a few of them actually.
> > And all private APN I have seen so far require authentication, even
> > for the combined attach.
> >
>
> Are these networks something a typical user would see?  Or is this
> mainly for M2M type usecases?

My focus is mainly M2M use cases, but also public networks may require
authentication.

>
> Fundamentally this whole username / password for a default bearer
> activation is utterly insane.  The network provider has your IMSI, it
> can lookup whether you're authorized for that APN or not, or suggest you
> an APN that will work...  But I digress..

There is also another problem: the default and data context APN is
often the same, and if the auth is not set for both in the same way,
the context activation fails.
But I digress too.

>
> >
> > Shall I extend the explanation?
>
> An extended explanation is always a good idea.  Especially for something
> that seems to be pretty esoteric.
>
> > There wasn't much of an explanation why we need a default APN for LTE, =
either.
> >
>
> Sure there was.  Not sure why you say that :)  Maybe it wasn't recorded
> in the git commit but it was discussed on the mailing list, IRC, etc.
> But again, see above.  The whole default attach APN needing to be
> provisioned by the client is utterly insane.

I prefer not to comment on these practices. For instance, is there an
archive of the chat and mailing list that I or anyone could access?

>
> Regards,
> -Denis

Regards,
Giacinto

--===============5993484425076287622==--

