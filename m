Content-Type: multipart/mixed; boundary="===============0683199078457308021=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Re: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Wed, 04 Mar 2020 16:45:11 +0000
Message-ID: <CABPh3UNTsS5_-gcpUQShv-HmB8d5+FDq9TwOV1=OXHeugNbp4A@mail.gmail.com>
In-Reply-To: <7c96764b-1885-a697-3fbb-76677d7e4183@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0683199078457308021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
thanks for your response

Can you say why it is a terrible idea?
In this way I can select in connman (or via dbus) the right context
that I want to use
I can also create other context manually.
Maintaining a custom database is an hassle you don't know what
operator your user are using.
For example I have user that depending on the contract with the same
company they have different APNs.
Without this change ofono provision an empty context.
With this at least the user has a predefined list of APNs and can choose.
I think is better to have 3 profiles to choose from than having a broken on=
e.

Also if you want your behaviour you can still provide a database with
one APN per operator and this will still work....

But if you're against it I can use for example a compile flag set to
disabled by default

Cheers
Nick

On Wed, 4 Mar 2020 at 16:26, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Nicola,
>
> On 3/2/20 10:31 AM, Nicola Lunghi wrote:
> > if the mobile provider information database has multiple apn settings f=
or the
> > same operator, ofono was throwing an error and creating a default inter=
net
> > context with an empty apn.
> >
> > This patch will instead allow the automatic creation of multiple context
> > allowing the user to pick one of the default via connman.
>
> I still maintain this is a horrible idea.  Yes it is a nice workaround
> if you don't have a proper provisioning database, but not something I'd
> use in production.
>
> What I can do is allow this to be configurable via some config file or
> environment variable (and off by default).
>
> >
> > Connman supports multiple cellular context so no issue there.
> >
> > Previously proposed by Martin Hundeb=C3=83=C2=B8ll here:
> > https://lists.ofono.org/hyperkitty/list/ofono(a)ofono.org/thread/2SC46P=
H5CWT3A3HTHGUKUUVI3QDYIL73/#7B6CPARJQMZUBQUPXBJMAOXZY4RW2L3D
> >
> > And tested by Nicola Lunghi with connman 1.37
> >
> > Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
>
> No SoB please.
>
> > ---
> >   plugins/provision.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Regards,
> -Denis
--===============0683199078457308021==--

