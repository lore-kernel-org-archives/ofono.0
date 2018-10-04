Content-Type: multipart/mixed; boundary="===============4502986951350193640=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 6/6] drivers: support for auth NONE
Date: Thu, 04 Oct 2018 06:51:32 +0200
Message-ID: <CAKSBH7FZYC2SGw6B=9vY=U=QqjVB8FR7=UXtsV8eXEO_m13rag@mail.gmail.com>
In-Reply-To: <ef12e098-960c-f132-4a8e-767a6d882432@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4502986951350193640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Oct 4, 2018 at 6:40 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> > I suppose your comments on [PATCH 2/4]. I have addressed them on the
> > [PATCH 2/6].
> > Basically, as you can also see from the code, the user-set value are st=
ored,
> > but the driver changes them internally if suited:
> > - if no username it changes to AUTH_NONE, this is already in place for =
some
> > - if AUTH_NONE, username and password are cleared internally
> > This permissive approach allows also to deal with the next question (se=
e below).
>
> All right.  But do you also want to mention this behavior in the D-Bus
> documentation?  E.g. something to the effect of if AuthenticationMethod
> is set to None, then username / password values are ignored?

gladly, but I didn't find a document for this.
We are going to add it in the lte-api, but the only place I have found
for the rest is in the
connman-api.
Is there some other documents?

>
> >
> >> Also, what are we doing with plugins/mbpi.c?  That database only
> >> supports pap/chap but potentially with missing username/password
> >> attributes.  Should we be converting these to type 'none'?  Or leaving
> >> things as is and having the drivers deal with converting type chap,
> >> empty username/password to type none.  I thought the whole idea of
> >> introducing type 'None' was that you hated that drivers were doing thi=
s?
> >
> > I had added the 'none' also there, then removed it. It looks to me
> > this database is for CDMA (but I am not sure).
> > In the database itself I have on my machine, there is a single 'pap',
> > no 'chap', and in all other cases the fields are missing.
>
> This database is for both CDMA and GSM.  Essentially CHAP is assumed if
> PAP is not explicitly specified.

ok, then it is to be kept.

>
> >
> > If it is for CDMA, I am not sure how much should this database be maint=
ained.
> > I know that several users have a private branch of ofono for CDMA, and
> > do not intend to change or submit,
> > because the technology is felt EOL.
>
> Mobile Broadband Provider Info is still maintained.  See
> https://github.com/GNOME/mobile-broadband-provider-info.  The database
> itself was never really that good, but it was at least something.  I
> think the Ubuntu guys had a plugin that used the Android provisioning
> db, but it was never contributed upstream.
>

that's a pity.

> >
> > Maybe this could be removed in a 2.x branch that you mentioned apropos
> > AT+CGATT=3D0 when roaming.
> >
> > In the meanwhile, I have chosen to ignore it. It is not difficult to
> > add it in the code if necessary,
> > and I can also considered it separately from this series of patches.
> >
>
> Given how closely related it is, it probably should be considered in the
> same series.  This is one of those situations where we're messing with
> the existing API and so all changes go in or none at all...  But given
> that the drivers are expected to handle empty username/passwords
> already, I'm okay leaving mbpi as is... but it might be a good idea to
> fix it anyway...

I can fix it, but need to decide on a default then.
It looks to me that 'none' would be a better default than 'chap'.
The problem is that 'chap' is assumed so far and therefore it would be
regressive.

>
> >>    I believe you referred to this as a 'hack' or similar terminology? =
:)
> >
> > undocumented hack, yes :)
> > it is the undocumented part that I don't like. For this db, for
> > example, one may assume that
> > without user/pwd it is no-auth. Which is true for all drivers except
> > PPP, that would
> > default to chap and attempt to generate a password, as you described 2 =
days ago.
>
> That actually depends on what the modem PPP stack does.  If it doesn't
> request authentication, then none will be attempted.
>
> >
> > My concern is for the use of the auth_method for the default LTE bearer.
> > In that case I would prefer to have such a method clearly identified,
> > because the combined attach could
>
> So isn't this a good reason to make sure provisioning sets these
> properly?  Default attach parameters are not currently provisioned, but
> perhaps they need to be.
>
> > fail for various reasons, the network answer is in general
> > inconsistent (I have counted already
> > half a dozen failure codes when APN/auth are incorrect), and - mainly
> > - there is no immediate feedback
> > to the application: the registration is attempted a few times, then
> > there is a back-off timer of 12 minutes (T3346),
> > when the module could attach to a legacy technology. In all this, the
> > user might just believe that it is out of LTE
> > coverage at first, and will take a long time to associate the symptoms
> > with the actual issue.
> >
> > Another issue for the default context is that the parameters are in
> > general non-volatile, so if the SIM is changed,
> > and with it perhaps only the APN, it would still refer to the previous
> > auth_method and parameters until changed explicitly.
>
> Another reason to provision the default attach parameters.  If you
> change the SIM and no settings are read from storage (which is stored
> per IMSI), then oFono should attempt to provision the default attach
> parameters.
>

ok for all the points above. So I change the default for 'none',
is this ok?

> > And in the future, it seems the SIM will be changed quite often
> > And it seems to be particularly important for VoLTE, because no
> > operator supports it in roaming. The standard exists,
> > but seems unattractive.
> > With the sunset of 2G/3G, the only way to have voice will be using a
> > local SIM profile.
> > This SIM exchange is technical achieved with the eUICC.
> >
> > BTW, the SIM hot swap seems to be another point to improve, but for
> > now I am not going into this.
> >
>
> Out of curiosity, what do you have in mind?

I haven't looked into it yet. I just have complaints that removing and
re-inserting
the SIM doesn't work.
We will work on this in November or December.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============4502986951350193640==--

