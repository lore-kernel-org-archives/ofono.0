Content-Type: multipart/mixed; boundary="===============0552816024331084446=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Setting "RoamingAllowed" on by default; or storing persistently
Date: Tue, 23 Jul 2019 18:23:27 -0500
Message-ID: <2a79b31f-6004-6b7f-d0cf-39432d463216@gmail.com>
In-Reply-To: <65e65c13-ee97-03ed-45e6-4a24779440b1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0552816024331084446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tarmo,

On 7/24/19 9:15 AM, Tarmo Kuuse wrote:
> Hi!
> =

> I'd like for my device to automatically connect to 3G data in roaming =

> wherever the GSM network permits it. I'd very much like to set this up =

> as default during manufacturing regardless of the SIM inserted. ofono =

> version 1.21 (debian buster).

Isn't this quite old?  I think we're up to 1.29 and we don't do releases =

that often these days...

> =

> I can tell ofono to enable roaming manually - either via the config file =

> (e.g. /var/lib/ofono/248030010014875/gprs) or dbus interface (e.g. =

> dbus-send --system --print-reply --dest=3Dorg.ofono /quectel_0 =

> org.ofono.ConnectionManager.SetProperty string:"RoamingAllowed" =

> variant:boolean:true), but it does not seem to be stored persistently. =

> After a reboot ofono has disabled roaming again and the config file =

> holds "RoamingAllowed=3D0".

If the method call is successful, then RoamingAllowed should be updated =

on disk.  E.g. see src/gprs.c, we invoke storage_sync() right after =

updating it.

Perhaps try running strace on ofonod and see why this fails?

> =

> So my questions are:
> 1. can I set up ofono to always permit data connections in roaming?

Not at the moment.  oFono never had a concept of a main configuration =

file.  But perhaps something like that could be introduced specifically =

for this use case...

> 2. if not, can I at least store RoamingAllowed persistently per SIM card?
> =


This should already work...

> As context: working on a 3G-equipped gateway device, factory-installed =

> with a roaming-enabled SIM card and typically shipped to a foreign =

> country (mostly within EU where data roaming incurs no penalty). It's =

> rather desirable that 3G comes online without requiring any setup =

> whatsoever once the gateway is powered on in destination country.
> =


Regards,
-Denis

--===============0552816024331084446==--

