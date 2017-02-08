Content-Type: multipart/mixed; boundary="===============5178274868686426497=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: provisioning APN using mbpi plugin
Date: Wed, 08 Feb 2017 10:54:18 -0600
Message-ID: <96d52c22-bfde-7618-4ffc-1477a80686b3@gmail.com>
In-Reply-To: <1fdc62d3-5bb4-baec-39f6-ea0345f010ff@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5178274868686426497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

> With this change, provisionning using plugins provision.c and mbpi.c
> works. It creates 9 contexts for my SIM, 4 of them are internet type
> contexts.
> In connman (I use connman above ofono), I see 4 services and I am able
> to connect at least 2 of them. So I wonder why duplicate context is
> considered an error by these plugins. Does anybody know ?

This is done on purpose.  oFono & ConnMan are designed with the =

assumption that the user will see what is being exposed by the D-Bus =

API.  The UI is just a thin client which simply renders the state of =

ConnMan / oFono.  Think of the D-Bus API as being user-visible.  Thus it =

makes no sense for us to expose services that the user cannot use.

There are a couple of ways to get around this:

- Use a more up-to-date database
- Have a provisioning UI that detects that provisioning has failed, and =

guides the user through picking the right combination of operator / plan =

/ etc and configures the context settings accordingly

There really should only be a single internet context configured for a =

given SIM for the vast majority of users in the world.

Regards,
-Denis

--===============5178274868686426497==--

