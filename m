Content-Type: multipart/mixed; boundary="===============6413212014526148705=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp_hf_bluez5: Fix re-registering a modem for a device
Date: Tue, 23 Apr 2013 04:06:18 -0500
Message-ID: <51764F0A.3090602@gmail.com>
In-Reply-To: <1366671224-8777-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6413212014526148705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/22/2013 05:53 PM, Vinicius Costa Gomes wrote:
> Even for outgoing pairing requests we may receive the UUIDs property
> changed after the device is paired and try to register it twice.
>
> The easiest way to reproduce this is when Extended Inquiry Response is
> supported.
>
> When the device is paired, we receive the "Paired" PropertyChanged,
> inside modem_register_from_proxy(), g_dbus_proxy_get_property() gets
> the UUIDs extracted from the EIR data.  Later, when the service
> discovery is finished, the UUIDs property is re-sent and both may
> contain the HFP AG UUID.

My sources indicated to me that BlueZ should perform the SDP query =

first, and then signal Paired.  Is this something we can not count on or =

is this an implementation issue inside BlueZ itself?

Regards,
-Denis

--===============6413212014526148705==--

