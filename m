Content-Type: multipart/mixed; boundary="===============3189259830989786542=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Cinterion EHS6 support
Date: Thu, 30 Apr 2015 12:19:21 -0500
Message-ID: <55426419.9010801@gmail.com>
In-Reply-To: <5541DBC3.4030003@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3189259830989786542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

 >> The error message flags up a problem for the integrator. In the case of
>> OFONO_VENDOR_NOKIA, OFONO_VENDOR_SAMSUNG in at_creg_set_cb() we can
>> assume this has been investigated, and no good alternative event
>> reporting solution is available (or a choice was made not to implement)
>> so this is disabled.
>>

Essentially.  We either don't have the vendor specific commands for =

those modems or they simply don't exist.

>> However there remains an exercise to go through for Cinterion to check
>> whether non-CIND reporting mechanism is available and enable it? If so
>> I'll have a look through the documentation.
>>
>> On a separate but related note, can you tell me if ofono supports
>> monitoring of signal strength whilst a data connection is up, e.g. via
>> use of GSM 07.10  or with modems such as Cinterion that expose multiple
>> virtual ports over USB?

Yes, of course.  Both ways are supported.

> The EHS6 requires use of the AT^SIND command to enable signal strength
> reporting, which are reported with textual indication descriptors (as
> opposed to numerics) in the +CIEV indication, similar to the Telit.
>
> The TC65 documentation doesn't show the "rssi" indicator as being
> supported by AT^SIND (pp87), although it is documented as supported by
> AT+CIND (pp81).
>
> Additionally the TC65 documentation states that "All indicators provided
> by AT+CIND can be handled with AT^SIND as well" so there's some
> confusion there, and unfortunately without the TC65 hardware I can't test.
>
> I have some code here which is correctly handling the "rssi" +CIEVs on
> the EHS6 as a "cinterion" plugin as far as I can see.
>
> If you are happy with the above I could provide a patch-set to replace
> tc65 with a "cinterion" plugin using AT^SIND to setup signal strength
> reporting for the Cinterion vendor?
>

That sounds like a good start.  We can always split the driver into two. =

  That is easy.  Merging two drivers into one is much harder.

Regards,
-Denis

--===============3189259830989786542==--

