Content-Type: multipart/mixed; boundary="===============6665762482185214913=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Ofono use
Date: Sun, 23 Oct 2011 15:20:21 -0500
Message-ID: <4EA47705.4050404@gmail.com>
In-Reply-To: <1319449442.32429.141.camel@talinn.home>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6665762482185214913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On 10/24/2011 04:44 AM, Jean Parpaillon wrote:
> Hi all,
> I am currently trying to use ofono and I can not get how to register the
> modem in a reliable way.
> When I detect a modem, I set org.ofono.Modem.Powered to True.
> When SimManager interface is ready, I enter the pin.
> Then, I set the modem org.ofono.Modem.Online to True.

So far so good...

> By the way, I wait for NetworkRegistration interface to be available.
> When it is available, I wait for NetworkRegistration.Name to be non
> empty to call NetworkRegistration.Register.
> =


oFono will automatically register unless the Mode property is set to
'manual'.  So calling NetworkRegistration.Register is wholly pointless
if you obtain a NetworkRegistration.Name.  That means you're already
registered ;)

> The point is setting Online property usually end with a timeout. It is
> the right workflow ? Must I look for other property ? =


What modem are you using?  In general Online should never result in a
timeout...

Regards,
-Denis

--===============6665762482185214913==--

