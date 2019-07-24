Content-Type: multipart/mixed; boundary="===============2609757500233798777=="
MIME-Version: 1.0
From: Tarmo Kuuse <tarmo.kuuse@gmail.com>
Subject: Re: Setting "RoamingAllowed" on by default; or storing persistently
Date: Wed, 24 Jul 2019 17:55:31 +0300
Message-ID: <197f7ebf-af59-4256-6543-3e1793623bc7@gmail.com>
In-Reply-To: <2a79b31f-6004-6b7f-d0cf-39432d463216@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2609757500233798777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 24.07.19 02:23, Denis Kenzior wrote:
>> I'd like for my device to automatically connect to 3G data in roaming =

>> wherever the GSM network permits it. I'd very much like to set this up =

>> as default during manufacturing regardless of the SIM inserted. ofono =

>> version 1.21 (debian buster).
> =

> Isn't this quite old?=C2=A0 I think we're up to 1.29 and we don't do rele=
ases =

> that often these days...

Yes, the package maintainer seems to be erring on the side of caution.

>> I can tell ofono to enable roaming manually - either via the config =

>> file (e.g. /var/lib/ofono/248030010014875/gprs) or dbus interface =

>> (e.g. dbus-send --system --print-reply --dest=3Dorg.ofono /quectel_0 =

>> org.ofono.ConnectionManager.SetProperty string:"RoamingAllowed" =

>> variant:boolean:true), but it does not seem to be stored persistently. =

>> After a reboot ofono has disabled roaming again and the config file =

>> holds "RoamingAllowed=3D0".
> =

> If the method call is successful, then RoamingAllowed should be updated =

> on disk.=C2=A0 E.g. see src/gprs.c, we invoke storage_sync() right after =

> updating it.
> =

> Perhaps try running strace on ofonod and see why this fails?

Sounds logical to me, thank you for confirming.

>> So my questions are:
>> 1. can I set up ofono to always permit data connections in roaming?
> =

> Not at the moment.=C2=A0 oFono never had a concept of a main configuratio=
n =

> file.=C2=A0 But perhaps something like that could be introduced specifica=
lly =

> for this use case...

I heartily agree.

>> 2. if not, can I at least store RoamingAllowed persistently per SIM card?
> =

> This should already work...

Thank you for the quick reply. I'll begin by upgrading ofono to see if =

the persistence starts to work for me.

-- =

Kind regards
Tarmo Kuuse

--===============2609757500233798777==--

