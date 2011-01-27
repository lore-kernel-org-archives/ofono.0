Content-Type: multipart/mixed; boundary="===============2055892197354136688=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SAT support in oFono
Date: Thu, 27 Jan 2011 10:11:23 -0600
Message-ID: <4D41992B.5020002@gmail.com>
In-Reply-To: <4D419345.9080505@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2055892197354136688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> We have checked with Jeewaka what are the conditions related to the STK
> events 'User activity', 'idle screen available' and 'language selection'.
> It appears that whatever is the release, once the device is supporting a
> display and a keypad, those events are mandatory for GCF.
> =


Yes indeed that is what the spec says, but pretty much all smart phone
platforms have ignored these and still managed to pass GCF.  I wonder
how they do that?

> The event "Browser termination" is also mandatory if the terminal
> supports class c.
> =


Same with this one.  On a modern platform you use the browser all the
time for stuff unrelated to the SIM.  Do you really expect that someone
will modify Mozilla / WebKit / whatever to send these reports?

> So, it means that we need to monitor some user activity (e.g. a
> key-press, removal of key-lock) and detects when the terminal can
> display a text of normal priority (commonly when the homescreen is on
> foreground)

Think about this one in the context of Meego.  This information is
simply not available.  We're running on a linux desktop, nobody really
knows whether one application is hiding another one or whether the user
is generating events or not.

> For the language selection, we need to inform the UICC when the terminal
> changes the currently used language.
> Finally, for the "Browser termination", we need to inform when  the
> browser is terminated either by the user action or by an error.
> =

> Basically, we could think that this monitoring could be handled by the
> STK agent. But in this case, we need to introduce a method in the STK
> dbus interface to broadcast/notify events to ofono. Also we need of
> course to support the Setup Event List proactive command.
> =

> To start, I propose to introduce those events and the Setup Event List
> command in the TODO file.

Try coming up with these APIs first, if you find them turning into a
disaster area then it should give you a good indication of how likely
they are to be accepted.

Regards,
-Denis

--===============2055892197354136688==--

