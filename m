Content-Type: multipart/mixed; boundary="===============4834012114099529919=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: Network information can't be updated dynamically
Date: Thu, 30 Jul 2009 10:18:14 +0800
Message-ID: <B94C62E7C2870743865418621F040C1302053C502B@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <200907292101.15429.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4834012114099529919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Denis Kenzior
>Sent: 2009=E5=B9=B47=E6=9C=8830=E6=97=A5 10:01
>To: ofono(a)ofono.org
>Subject: Re: Network information can't be updated dynamically
>> >The only thing that oFono core will poll periodically is the network
>> >operators.  Everything else must be handled by the driver.  For network
>> > status updates atmodem sends an AT+CREG=3D2, quoting 27.007:
>> >
>> >"2 - enable network registration and location information unsolicited
>> > result code +CREG: <stat>[,<lac>,<ci>[,<AcT>]]"
>>
>> How ofono known the changed network status?  Registed -> roaming
>
>The modem tells it?
No, if ofono don't request it and the modem can't send the response

>>
>> Suppose UI want to show the status, which interface can be used?
>
>You use the NetworkRegistration interface, 'Status' property.

That's the point; the status can't be changed because ofono only get the st=
atus at modem/networking initialization, during registered to roaming ofono=
 don't know the changing even modem update the information correctly

Thanks =

Zhigang
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============4834012114099529919==--

