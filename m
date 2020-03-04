Content-Type: multipart/mixed; boundary="===============6746778877888467049=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Wed, 04 Mar 2020 17:54:58 +0100
Message-ID: <CAKSBH7Em1Za-qUEQ5R85qEJTDADkr+8+2MMkTp7Eu1gmgR9vRA@mail.gmail.com>
In-Reply-To: <CABPh3UNTsS5_-gcpUQShv-HmB8d5+FDq9TwOV1=OXHeugNbp4A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6746778877888467049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Wed, Mar 4, 2020 at 5:45 PM nick83ola <nick83ola@gmail.com> wrote:
>
> Hi Denis,
> thanks for your response
>
> Can you say why it is a terrible idea?
> In this way I can select in connman (or via dbus) the right context
> that I want to use
> I can also create other context manually.
> Maintaining a custom database is an hassle you don't know what
> operator your user are using.
> For example I have user that depending on the contract with the same
> company they have different APNs.
> Without this change ofono provision an empty context.
> With this at least the user has a predefined list of APNs and can choose.
> I think is better to have 3 profiles to choose from than having a broken =
one.

one question about the reasoning above: how do you pick the "right"
context if your application is not maintaining the database?
You cycle through all of them until one works?

thank you,
Giacinto
--===============6746778877888467049==--

