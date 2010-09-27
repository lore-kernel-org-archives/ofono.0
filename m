Content-Type: multipart/mixed; boundary="===============3830592490708763466=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Please comment on callhistory API
Date: Mon, 27 Sep 2010 18:08:04 -0500
Message-ID: <4CA123D4.9080500@gmail.com>
In-Reply-To: <1285609846.9845.11.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3830592490708763466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 09/27/2010 12:50 PM, Marcel Holtmann wrote:
> Hi Raji,
> =

>> CallHistory hierarchy
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Service : org.ofono
>> Interface : org.ofono.CallHistory
>> Object path : [variable prefix]/{modem0,modem1,...}/CallHistory
> =

> the object path is wrong here. This should be pretty much on the main /
> object path. And not on per modem and not in a sub-path.
> =

> I really don't think that per modem history makes sense. Denis?

The idea here is that you can track history by the modem object or more
likely the IMSI.  Thus when switching SIMs or in dual-sim mode phones,
the history shown might change depending on the current SIM.

>> Properties
>> =3D=3D=3D=3D=3D=3D=3D
>> 		integer Uid [Read Only]
>> 			Integer representing the unique id of the history record
> =

> In this case I would prefer UID as value and in uint32 please. D-Bus
> doesn't have an integer type.
> =

> Also do we actually need this? Denis?

This is not actually needed, we only track when a call has been ended or
missed.

Regards,
-Denis

--===============3830592490708763466==--

