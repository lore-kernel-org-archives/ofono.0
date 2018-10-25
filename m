Content-Type: multipart/mixed; boundary="===============1433732925376000007=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] atmodem/lte: proto and authentication handling
Date: Thu, 25 Oct 2018 05:01:09 +0200
Message-ID: <CAKSBH7Fbsr_bntKrXmkYTGWWR1xpZv9KZwVbq83ZwNmh-9Cb5g@mail.gmail.com>
In-Reply-To: <a946f636-f5f9-2de3-8967-c8d21fb57e94@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1433732925376000007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Oct 25, 2018 at 4:50 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> >>> +     const struct ofono_lte_default_attach_info *info;
> >>
> >> And honestly, I'd just put this into lte_driver_data as well.
> >>
> >> Nope you can't do this. This is the third time I nak-ed this part
> >
> > I can't do what? I don't see what you are referring to.
> >
>
> There are two comments here.  First is that this 'pending' info stuff
> doesn't belong here.
>
> Second is that you cannot hold a reference to an object owned by the
> core.  The driver cannot assume that it will be valid for the duration
> of the asynchronous operation.  E.g. the core might have created a
> temporary object on the stack to pass to the driver and it will go
> *poof* as soon as the driver function returns.
>
> There is very strict separation between driver managed memory /
> structures and ones owned by the core.

Thank you for the clarification, now I understand.

And yes, it is indeed the 3rd time you point it out.
I hope it is the last one, but it is easy to fall for this,
there should be some mechanism to either prevent it or guarantee that
the object is persistent.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============1433732925376000007==--

