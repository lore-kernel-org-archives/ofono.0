Content-Type: multipart/mixed; boundary="===============3298323447312350295=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] hfp_hf_bluez5: Fix re-registering a modem for a device
Date: Tue, 23 Apr 2013 19:15:36 +0300
Message-ID: <20130423161536.GA27409@x220>
In-Reply-To: <AF9D10A5-D958-4E8A-9B41-1EA0A5C9BD92@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3298323447312350295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, Apr 23, 2013, Marcel Holtmann wrote:
> >>> Even for outgoing pairing requests we may receive the UUIDs property
> >>> changed after the device is paired and try to register it twice.
> >>> =

> >>> The easiest way to reproduce this is when Extended Inquiry Response is
> >>> supported.
> >>> =

> >>> When the device is paired, we receive the "Paired" PropertyChanged,
> >>> inside modem_register_from_proxy(), g_dbus_proxy_get_property() gets
> >>> the UUIDs extracted from the EIR data.  Later, when the service
> >>> discovery is finished, the UUIDs property is re-sent and both may
> >>> contain the HFP AG UUID.
> >> =

> >> My sources indicated to me that BlueZ should perform the SDP query
> >> first, and then signal Paired.  Is this something we can not count
> >> on or is this an implementation issue inside BlueZ itself?
> > =

> > BlueZ has always done pairing first and only then SDP. This is because
> > there are security mode 3 devices out there that do not permit any kind
> > of connection before pairing has been completed (i.e. even if we wanted
> > to do SDP first we can't with them). That said, we do at least delay the
> > NewConnection() callback until SDP has been completed.
> =

> so when are we sending "Paired" property? We might have to delay that
> property update until SDP finished.

Right now it's directly bound to when the device is actually paired,
i.e. ignoring any other ongoing operations such as SDP.

> We have to make sure that we finished SDP after the pairing before
> updating any clients with property changes.

I don't completely understand the rationale of wanting to make BlueZ's
clients so fragile. You could in theory get new services way after
pairing if this is configurable on the remote side. You could also get
the result of calling Device1.Connect() instead of Device1.Pair() in
BlueZ.

On the other hand, we do delay the response to Device1.Pair() until SDP
is complete so delaying the Paired property would in a way be consistent
with that. I'll look into how simple this would be. We already track the
completion of SDP for each device internally with a svc_resolved boolean
so probably a new flag to indicate that "Paired" still needs to be
emitted should be all the extra context tracking we need.

Johan

--===============3298323447312350295==--

