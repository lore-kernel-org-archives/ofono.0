Content-Type: multipart/mixed; boundary="===============1874112199524864010=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: Re: Cinterion EHS6 support
Date: Thu, 30 Apr 2015 09:37:39 +0200
Message-ID: <5541DBC3.4030003@dynamicdevices.co.uk>
In-Reply-To: <5541B2D2.6070606@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1874112199524864010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 30/04/2015 06:42, Alex J Lennon wrote:
>
> On 30/04/2015 00:57, Denis Kenzior wrote:
>> Hi Alex,
>>
>>> It looks as though the issue is that the Cinterion parts don't support
>>> signal strength via +CIND ?
>> Yes, we look for "signal" indicator inside cind_support_cb.  If it
>> isn't found, then we raise an error.  This tells the hw integrator to
>> address the issue.  CIND logic is provided as a fallback / default
>> since many manufacturers support this indicator for HFP.
>>
>> signal_strength (and hence +CSQ) is used to bootstrap the signal
>> strength value.  This driver method is only called at very specific
>> times.  The core does not poll signal_strength.  It is expected that
>> the driver will send signal strength value to the core periodically,
>> by whatever means is optimal for the hardware.  Most modems use a
>> custom unsolicited notification or CIND to provide information about
>> signal strength automatically.  I suspect Cinterion has a similar
>> extension.
>>
>> The consequence of the above is that it can't.  If no vendor extension
>> is available for unsolicited notifications and signal strength is not
>> provided via CIND, then the netreg atom driver can either poll signal
>> strength manually or simply not provide any signal strength updates.
>> For the latter, it must enable such behavior explicitly.  Hence why
>> your patch providing OFONO_VENDOR_CINTERION logic makes this work
>> properly.
>>
>> Hope that made sense.
> OK thanks for explaining that Denis. Yes, I was wondering if this was
> related to the potential asynchronous nature of +CIND reporting versus
> polling via at_signal_strength()
>
> So, to make sure I understand...
>
> The error message flags up a problem for the integrator. In the case of
> OFONO_VENDOR_NOKIA, OFONO_VENDOR_SAMSUNG in at_creg_set_cb() we can
> assume this has been investigated, and no good alternative event
> reporting solution is available (or a choice was made not to implement)
> so this is disabled.
>
> However there remains an exercise to go through for Cinterion to check
> whether non-CIND reporting mechanism is available and enable it? If so
> I'll have a look through the documentation.
>
> On a separate but related note, can you tell me if ofono supports
> monitoring of signal strength whilst a data connection is up, e.g. via
> use of GSM 07.10  or with modems such as Cinterion that expose multiple
> virtual ports over USB?
>
> Thanks, Alex
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

Denis,

I've had a look through the EHS6 and the TC65 AT command sets reference
manuals

ref:
http://www.idr.com.tr/files/EHS6%20AT%20Command%20Set%20V02.000a%20%28Preli=
minary%20version%29.pdf

ref: http://jagfernandez.webs.uvigo.es/ET/CMOV/pr2/tc65_atc_v02000.pdf

The EHS6 requires use of the AT^SIND command to enable signal strength
reporting, which are reported with textual indication descriptors (as
opposed to numerics) in the +CIEV indication, similar to the Telit.

The TC65 documentation doesn't show the "rssi" indicator as being
supported by AT^SIND (pp87), although it is documented as supported by
AT+CIND (pp81).

Additionally the TC65 documentation states that "All indicators provided
by AT+CIND can be handled with AT^SIND as well" so there's some
confusion there, and unfortunately without the TC65 hardware I can't test.
 =

I have some code here which is correctly handling the "rssi" +CIEVs on
the EHS6 as a "cinterion" plugin as far as I can see.

If you are happy with the above I could provide a patch-set to replace
tc65 with a "cinterion" plugin using AT^SIND to setup signal strength
reporting for the Cinterion vendor?

Regards,

Alex
=20

--===============1874112199524864010==--

