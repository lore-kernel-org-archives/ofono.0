Content-Type: multipart/mixed; boundary="===============0098143832759825657=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Please comment on callhistory API
Date: Mon, 27 Sep 2010 18:18:11 -0500
Message-ID: <4CA12633.4010208@gmail.com>
In-Reply-To: <1285629284.9845.18.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0098143832759825657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 09/27/2010 06:14 PM, Marcel Holtmann wrote:
> Hi Denis,
> =

>>>> CallHistory hierarchy
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>> Service : org.ofono
>>>> Interface : org.ofono.CallHistory
>>>> Object path : [variable prefix]/{modem0,modem1,...}/CallHistory
>>>
>>> the object path is wrong here. This should be pretty much on the main /
>>> object path. And not on per modem and not in a sub-path.
>>>
>>> I really don't think that per modem history makes sense. Denis?
>>
>> The idea here is that you can track history by the modem object or more
>> likely the IMSI.  Thus when switching SIMs or in dual-sim mode phones,
>> the history shown might change depending on the current SIM.
> =

> by modem makes no sense. That might change at any time. For example even
> if you get a phone replacement. So not really helpful.
> =

> The IMSI I can see, but isn't it better then just to include the IMSI
> into the report send to the history application. Not that I actually
> like sending the IMSI around so much :(

Actually per modem does make sense for HFP use cases where the device is
essentially unique and IMSI is not provided.

Regards,
-Denis

--===============0098143832759825657==--

