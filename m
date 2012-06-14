Content-Type: multipart/mixed; boundary="===============6239773057420531811=="
MIME-Version: 1.0
From: Audric Schiltknecht <audric.schiltknecht@toulouse.viveris.com>
Subject: Re: Implement signal strength polling in plugin/driver
Date: Thu, 14 Jun 2012 14:21:05 +0200
Message-ID: <de52a13b2cbbedf98839eff324eed197@toulouse.viveris.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6239773057420531811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

>> I found by looking in include/netreg.h that it should be up to the
>> plugin to
>> implement CSQ polling, however I can't find how it is supposed to be =

>> done.
>> Indeed, the plugin has no access to the netreg atom nor structure, =

>> so
>> how is it
>> supposed to update one of these properties ?
>
> Drivers do not modify DBus properties directly.  Instead you should
> be signaling the change to the core the regular way, via
> ofono_netreg_strength_notify.
>
> If you want to implement periodic signal strength reporting, then use
> g_idle_add_seconds to periodically send the +CSQ query.  Please note
> that doing it this way you'd have to keep track of other states.  For
> example, you might want to stop polling when the registration is =

> lost,
> etc.

Oh, I see. Indeed, I noticed that signal strength reporting
is stopped when modem is not registered. I'll keep that in mind.
Thank you for the lead on this matter.

>
> Ideally you should be asking your vendor why the signal strength
> isn't reported properly.

Sure, it would be great to not have to do all these hacks to get it =

working right !

Regards,
Audric

--===============6239773057420531811==--

