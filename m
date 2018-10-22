Content-Type: multipart/mixed; boundary="===============5702660782679755139=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: airplane mode
Date: Mon, 22 Oct 2018 10:54:18 -0500
Message-ID: <678af256-d651-b427-e3ad-1f61cf1536a6@gmail.com>
In-Reply-To: <CAKSBH7EJzKZSixyAM7L6mwcuvYMSKjeh9DFDa0tD8wFGcC5zAA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5702660782679755139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/22/2018 12:19 AM, Giacinto Cifelli wrote:
> Dear all,
> =

> I have a series of problems with the ofono structure.
> When setting Powered=3DTRUE, it sets the module in airplane mode (AT+CFUN=
=3D4).
> =

> This prevents the use of calls, even emergency, so there would be no
> point in creating the atom in pre-sim stage.

Sure there is.  Voicecall atom needs to read EFecc, and for that it =

needs to keep track of sim inserted status & be able to do this even =

when the PIN has not been entered yet (e.g. pre-sim state).

And it is fully possible to make emergency calls.  Just set Online=3DTrue =

first.

> Additionally, the registration of call URCs for custom voicecall
> atoms, might also fail.
> =


Fix your firmware? :)

> Also, several test commands fail in airplane mode, e.g.: AT+CLCK=3D?

I doubt this has anything to do with airplane mode.  Is it that the SIM =

is not initialized yet?  But even then, why would the firmware not =

report all available locks regardless?

> =

> Is there a way to re-initialize all required atoms at the post-inline sta=
ge?
> Or should they be destroyed and re-created?
> =


destroying and recreating is a bad idea because they will be moved into =

a different modem state level.  So the next time you go to airplane mode =

you will lose your SIM atom.

You can always listen to modem state changes in the driver, but I =

wouldn't recommend it.  The simplest answer is to fix your firmware ;)

Regards,
-Denis

--===============5702660782679755139==--

