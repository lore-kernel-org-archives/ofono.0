Content-Type: multipart/mixed; boundary="===============2586078447662030788=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Re: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Wed, 04 Mar 2020 17:00:29 +0000
Message-ID: <CABPh3UNwYKipWh=1sv=UNk-LsfU74kx7=7brX2SWo-6V3cGXEw@mail.gmail.com>
In-Reply-To: <CAKSBH7Em1Za-qUEQ5R85qEJTDADkr+8+2MMkTp7Eu1gmgR9vRA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2586078447662030788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,
We have a web application that is talking to connman and ofono over dbus.
We present the user with the list and once is connected to a profile
connman remembers
it so if I connect again the same modem connman will remember it as a
favourite and automatically connect.
or at least is what I'm thinking of doing.

To automatically connect without the user I was thinking of
implementing what you said:
- retrieve "cellular" services from connman
- check if there are favourite services
- if there are not try one context one after the another

The main issue is that connman is not exposing the APN and data over
dbus and is not easy to identify also the context
which a service is referring to... the other indication is the name
So if I create something in ofono I don't know how connman will call it....=
 :-(

Thanks
Nick

On Wed, 4 Mar 2020 at 16:55, Giacinto Cifelli <gciofono@gmail.com> wrote:
>
> Hi Nick,
>
> On Wed, Mar 4, 2020 at 5:45 PM nick83ola <nick83ola@gmail.com> wrote:
> >
> > Hi Denis,
> > thanks for your response
> >
> > Can you say why it is a terrible idea?
> > In this way I can select in connman (or via dbus) the right context
> > that I want to use
> > I can also create other context manually.
> > Maintaining a custom database is an hassle you don't know what
> > operator your user are using.
> > For example I have user that depending on the contract with the same
> > company they have different APNs.
> > Without this change ofono provision an empty context.
> > With this at least the user has a predefined list of APNs and can choos=
e.
> > I think is better to have 3 profiles to choose from than having a broke=
n one.
>
> one question about the reasoning above: how do you pick the "right"
> context if your application is not maintaining the database?
> You cycle through all of them until one works?
>
> thank you,
> Giacinto
--===============2586078447662030788==--

