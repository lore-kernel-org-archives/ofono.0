Content-Type: multipart/mixed; boundary="===============7792874917611771405=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Wed, 04 Mar 2020 10:56:12 -0600
Message-ID: <f7955968-0f4a-86b9-a2bb-a8a07e2c7070@gmail.com>
In-Reply-To: <CABPh3UNwYKipWh=1sv=UNk-LsfU74kx7=7brX2SWo-6V3cGXEw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7792874917611771405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicola,

No top posting please.

On 3/4/20 11:00 AM, nick83ola wrote:
> Hi Giacinto,
> We have a web application that is talking to connman and ofono over dbus.
> We present the user with the list and once is connected to a profile
> connman remembers
> it so if I connect again the same modem connman will remember it as a
> favourite and automatically connect.
> or at least is what I'm thinking of doing.

If you're making the user choose, why not follow the advice I have =

already given Martin and others?  Just provision the context once =

if/when automatic provisioning fails.  This is how connman/ofono were =

designed to be used.  Any workarounds you introduce will just make your =

life harder.

> =

> To automatically connect without the user I was thinking of
> implementing what you said:
> - retrieve "cellular" services from connman
> - check if there are favourite services
> - if there are not try one context one after the another
> =


So method of elimination.  Doesn't sound elegant ;)

> The main issue is that connman is not exposing the APN and data over
> dbus and is not easy to identify also the context
> which a service is referring to... the other indication is the name
> So if I create something in ofono I don't know how connman will call it..=
.. :-(
> =


ConnMan was explicitly designed not to expose such details.

Regards,
-Denis
--===============7792874917611771405==--

