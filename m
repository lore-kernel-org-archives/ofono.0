Content-Type: multipart/mixed; boundary="===============2369046169998074865=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] Add ResetProperties method to ConnectionContext
 interface
Date: Fri, 20 Feb 2015 10:00:31 -0600
Message-ID: <54E75A1F.8070709@gmail.com>
In-Reply-To: <1424347193-6828-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2369046169998074865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tommi,

On 02/19/2015 05:59 AM, Tommi Kenakkala wrote:
> In some cases it is useful to reset connection context settings back to o=
nes
> ofono provisioning resolved initially.
> What's your opinion on the API design, implementation and use-case descri=
bed
> next?
>

Why don't you just remove the settings file and restart oFono?

> Deactivation of the context is obviously mandatory. The reasoning for pla=
cing
> this into ofono is handling client requests consistently and avoiding race
> conditions. Using this approach ofono does not re-activate the context, t=
hat's
> done by ConnMan or whatever connection manger the system uses.
>

I'm not so sure that this is a good idea.  A 'live' reset of the =

settings just seems wrong to me.  Why would you ever want to do that =

anyway?  If something is working, why bother resetting the settings?

oFono supports arbitrary number of contexts, so your UI can always add =

more.  So if you need to re-provision, let your UI handle this.  The UI =

should be capable of reading the provisioning database anyway in order =

to handle duplicates, etc.

Regards,
-Denis

--===============2369046169998074865==--

