Content-Type: multipart/mixed; boundary="===============3741038830859893708=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Startup sequence for Online / offline mode
Date: Thu, 12 Aug 2010 19:27:49 -0400
Message-ID: <1281655669.12579.300.camel@localhost.localdomain>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C90111C20D94@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3741038830859893708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> >>> Modem drivers that support Online / offline mode default to offline w=
hen
> >>> oFono loads them. Which component is responsible for calling oFono and
> >>> switch the modem to online mode? Will that component be part of MeeGo?
> >> =

> >>This feature is still highly experimental and not all of the details
> >>have been figured out (only ISI supports it today).
> >> =

> >>Our current thinking is to have ConnMan manage the Online state of the
> >>GSM modems (e.g. replace Powered handling with Online handling.)
> >>However, we're still pretty far from that; we'd need to migrate all
> >>existing modem drivers to manage Online/Offline state properly first.
> >
> >I agree with Denis here. The Online state needs to be controlled by
> >ConnMan, but we haven't done that change yet. It would break current
> >users since we haven't migrated all modems to handle Online state
> >properly or emulate it if needed.
> =

> My understanding was that the Online state would be initialized by a comp=
onent like Telepathy-ring or some sort of system management daemon to ensur=
e that the dialer is up and running and able to accept calls before the Onl=
ine state is entered. If ConnMan initializes the Online state, how is it en=
sured that all required clients (Dialer, SMS, etc.) have registered already?

ConnMan has control over the flight mode and thus is has control over
the online state. If it happens that ConnMan switches the modem online
and call gets received before the dialer is running, then it might time
out in the end. And that is just fine with me.

Regards

Marcel



--===============3741038830859893708==--

