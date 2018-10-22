Content-Type: multipart/mixed; boundary="===============8176662559405210935=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: airplane mode
Date: Mon, 22 Oct 2018 18:51:56 +0200
Message-ID: <CAKSBH7GnR1cMpdARRPxG5SUoir1jU3jaSFYrxYC7NH0m=oFqAg@mail.gmail.com>
In-Reply-To: <678af256-d651-b427-e3ad-1f61cf1536a6@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8176662559405210935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, Oct 22, 2018 at 5:54 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 10/22/2018 12:19 AM, Giacinto Cifelli wrote:
> > Dear all,
> >
> > I have a series of problems with the ofono structure.
> > When setting Powered=3DTRUE, it sets the module in airplane mode (AT+CF=
UN=3D4).
> >
> > This prevents the use of calls, even emergency, so there would be no
> > point in creating the atom in pre-sim stage.
>
> Sure there is.  Voicecall atom needs to read EFecc, and for that it
> needs to keep track of sim inserted status & be able to do this even
> when the PIN has not been entered yet (e.g. pre-sim state).
>
> And it is fully possible to make emergency calls.  Just set Online=3DTrue
> first.

ahh, like that yes.... but then, wouldn't be better to create the
voicecall atom where it belongs, in post_online ?
Or this stage is never reached without a SIM? If not, what handle we
have that is called for sure after AT+CFUN=3D1 ?

>
> > Additionally, the registration of call URCs for custom voicecall
> > atoms, might also fail.
> >
>
> Fix your firmware? :)
>
> > Also, several test commands fail in airplane mode, e.g.: AT+CLCK=3D?
>
> I doubt this has anything to do with airplane mode.  Is it that the SIM
> is not initialized yet?  But even then, why would the firmware not
> report all available locks regardless?
>

According to the 27.007 (and our modules) AT+CLCK interrogates the
network for some locks, and for this it must be online.
Au passage, the 27.007 mentions explicitly that the command must be
abortable when network facilities are set or interrogated.

So, that command is not well placed when the module is in CFUN=3D4.
I don't know on what insane kind of modules it has been tested, but it
is wrong ;)

> >
> > Is there a way to re-initialize all required atoms at the post-inline s=
tage?
> > Or should they be destroyed and re-created?
> >
>
> destroying and recreating is a bad idea because they will be moved into
> a different modem state level.  So the next time you go to airplane mode
> you will lose your SIM atom.
>
> You can always listen to modem state changes in the driver, but I
> wouldn't recommend it.  The simplest answer is to fix your firmware ;)

Let's think about a more reasonable solution.
Again, if there is an handle that is called after AT+CFUN=3D1,
regardless of the SIM presence, that would be the perfect place.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============8176662559405210935==--

