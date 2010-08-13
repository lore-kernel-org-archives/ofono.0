Content-Type: multipart/mixed; boundary="===============8067977210413678720=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: Startup sequence for Online / offline mode
Date: Fri, 13 Aug 2010 11:02:07 +0300
Message-ID: <87vd7f54ao.fsf@potku.valot.fi>
In-Reply-To: <4C643159.7070409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8067977210413678720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> On 08/12/2010 12:23 PM, Bastian, Waldo wrote:
>> Modem drivers that support Online / offline mode default to offline when
>> oFono loads them. Which component is responsible for calling oFono and
>> switch the modem to online mode? Will that component be part of MeeGo?
>
> This feature is still highly experimental and not all of the details
> have been figured out (only ISI supports it today).
>
> Our current thinking is to have ConnMan manage the Online state of the
> GSM modems (e.g. replace Powered handling with Online handling.)
> However, we're still pretty far from that; we'd need to migrate all
> existing modem drivers to manage Online/Offline state properly first.

As online state is not supported by connman yet, ofono should default to
online state until connman support is finished. For example, now it's
impossible to use N900 as a modem with connman because the modem is in
offline state.

Will you accept patches to ofono to change the default state? It can be
reverted once the connman support is finished.

-- =

Kalle Valo

--===============8067977210413678720==--

