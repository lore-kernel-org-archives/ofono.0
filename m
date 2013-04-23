Content-Type: multipart/mixed; boundary="===============4424942273981217983=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] hfp_hf_bluez5: Fix re-registering a modem for a device
Date: Tue, 23 Apr 2013 18:23:54 +0300
Message-ID: <20130423152354.GA25876@x220>
In-Reply-To: <51764F0A.3090602@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4424942273981217983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Apr 23, 2013, Denis Kenzior wrote:
> On 04/22/2013 05:53 PM, Vinicius Costa Gomes wrote:
> >Even for outgoing pairing requests we may receive the UUIDs property
> >changed after the device is paired and try to register it twice.
> >
> >The easiest way to reproduce this is when Extended Inquiry Response is
> >supported.
> >
> >When the device is paired, we receive the "Paired" PropertyChanged,
> >inside modem_register_from_proxy(), g_dbus_proxy_get_property() gets
> >the UUIDs extracted from the EIR data.  Later, when the service
> >discovery is finished, the UUIDs property is re-sent and both may
> >contain the HFP AG UUID.
> =

> My sources indicated to me that BlueZ should perform the SDP query
> first, and then signal Paired.  Is this something we can not count
> on or is this an implementation issue inside BlueZ itself?

BlueZ has always done pairing first and only then SDP. This is because
there are security mode 3 devices out there that do not permit any kind
of connection before pairing has been completed (i.e. even if we wanted
to do SDP first we can't with them). That said, we do at least delay the
NewConnection() callback until SDP has been completed.

Johan

--===============4424942273981217983==--

