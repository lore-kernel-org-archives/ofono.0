Content-Type: multipart/mixed; boundary="===============3782893843096577370=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/6] lte-api: protocol and authentication properties
Date: Fri, 12 Oct 2018 04:41:09 +0200
Message-ID: <CAKSBH7HVsDzO7RSc9O_KVH-LSMWqUMa4Ag1=W6fjUdHRxa-Bqg@mail.gmail.com>
In-Reply-To: <32e78673-6aaa-25b8-8919-f004d483f851@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3782893843096577370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Thu, Oct 11, 2018 at 9:07 PM Jonas Bonn <jonas@southpole.se> wrote:
>
> Hi Giacinto,
>
> Reading through your patches, I'm missing an overarching explanation of
> why we need this.  Do you really have an LTE network in range that
> requires authentication for the default APN?

yes, quite a few of them actually.
And all private APN I have seen so far require authentication, even
for the combined attach.

> What happens if
> authentication fails... are you connected to an alternative APN
> automatically, with other service parameters? What indication is
> available to the user if authentication fails?

In general LTE registration is denied and fallback to legacy
technology if available.

>
> /Jonas

Shall I extend the explanation?
There wasn't much of an explanation why we need a default APN for LTE, eith=
er.

Regards,
Giacinto

>
>
> On 10/10/18 08:54, Giacinto Cifelli wrote:
> > added 4 properties for handling the type of context and the
> > authentication method, exactly like in any gprs context handling.
> > The properties are named after the equivalent gprs-context one, for
> > compatibility and uniformity.
> > ---
> >   doc/lte-api.txt | 34 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 34 insertions(+)
> >
> > diff --git a/doc/lte-api.txt b/doc/lte-api.txt
> > index 8a2a97d9..e9cbba0a 100644
> > --- a/doc/lte-api.txt
> > +++ b/doc/lte-api.txt
> > @@ -33,3 +33,37 @@ Properties string DefaultAccessPointName [readwrite]
> >
> >                       Setting this property to an empty string clears t=
he
> >                       default APN from the modem.
> > +
> > +             string Protocol [readwrite]
> > +
> > +                     Holds the protocol for this context.  Valid values
> > +                     are: "ip", "ipv6" and "dual". Default value is "i=
p".
> > +
> > +             string AuthenticationMethod [readwrite]
> > +
> > +                     Sets the Method used for the authentication
> > +                     for the default APN.
> > +
> > +                     Available values are "none", "pap" and "chap".
> > +                     Default is "none".
> > +
> > +                     If the AuthenticationMethod is set to 'none' it r=
emove
> > +                     the authentication for the DefaultAPN.
> > +                     In case of AuthenticationMethod 'none',
> > +                     if the Username and Password properties are not e=
mpty,
> > +                     the values are preserved in the properties, but t=
hey
> > +                     are not used or transmitted to the module.
> > +                     Conversely, if Username or Password are empty, the
> > +                     authentication method selected internally is 'non=
e',
> > +                     but the property AuthenticationMethod is left unc=
hanged.
> > +
> > +             string Username [readwrite]
> > +
> > +                     Holds the username to be used for authentication
> > +                     purposes.
> > +
> > +             string Password [readwrite]
> > +
> > +                     Holds the password to be used for authentication
> > +                     purposes.
> > +
>

--===============3782893843096577370==--

