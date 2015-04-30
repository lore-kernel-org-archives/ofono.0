Content-Type: multipart/mixed; boundary="===============8466949200490397830=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: Cinterion EHS6 support
Date: Thu, 30 Apr 2015 06:42:58 +0200
Message-ID: <5541B2D2.6070606@dynamicdevices.co.uk>
In-Reply-To: <554161F3.40104@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8466949200490397830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 30/04/2015 00:57, Denis Kenzior wrote:
> Hi Alex,
>
> >
>> It looks as though the issue is that the Cinterion parts don't support
>> signal strength via +CIND ?
>
> Yes, we look for "signal" indicator inside cind_support_cb.  If it
> isn't found, then we raise an error.  This tells the hw integrator to
> address the issue.  CIND logic is provided as a fallback / default
> since many manufacturers support this indicator for HFP.
>
> signal_strength (and hence +CSQ) is used to bootstrap the signal
> strength value.  This driver method is only called at very specific
> times.  The core does not poll signal_strength.  It is expected that
> the driver will send signal strength value to the core periodically,
> by whatever means is optimal for the hardware.  Most modems use a
> custom unsolicited notification or CIND to provide information about
> signal strength automatically.  I suspect Cinterion has a similar
> extension.
>
> The consequence of the above is that it can't.  If no vendor extension
> is available for unsolicited notifications and signal strength is not
> provided via CIND, then the netreg atom driver can either poll signal
> strength manually or simply not provide any signal strength updates.
> For the latter, it must enable such behavior explicitly.  Hence why
> your patch providing OFONO_VENDOR_CINTERION logic makes this work
> properly.
>
> Hope that made sense.

OK thanks for explaining that Denis. Yes, I was wondering if this was
related to the potential asynchronous nature of +CIND reporting versus
polling via at_signal_strength()

So, to make sure I understand...

The error message flags up a problem for the integrator. In the case of
OFONO_VENDOR_NOKIA, OFONO_VENDOR_SAMSUNG in at_creg_set_cb() we can
assume this has been investigated, and no good alternative event
reporting solution is available (or a choice was made not to implement)
so this is disabled.

However there remains an exercise to go through for Cinterion to check
whether non-CIND reporting mechanism is available and enable it? If so
I'll have a look through the documentation.

On a separate but related note, can you tell me if ofono supports
monitoring of signal strength whilst a data connection is up, e.g. via
use of GSM 07.10  or with modems such as Cinterion that expose multiple
virtual ports over USB?

Thanks, Alex

--===============8466949200490397830==--

