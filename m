Content-Type: multipart/mixed; boundary="===============0063740059692122333=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 11:39:13 +0200
Message-ID: <5316F0C1.60501@jolla.com>
In-Reply-To: <5316965A.5070902@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0063740059692122333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


>> 3. No way to associate additional APN properties with a gprs_context.
>>
>> apns-conf.xml has many additional APN attributes which don't map
>> directly to gprs_context properties ( eg. authtype, mvno_type, ... ).
>>
>
> If you have usecases in mind for some of these properties, feel free =

> to suggest extensions to the oFono API.
>

What do you think about extending org.ofono.ConnectionContext API with =

Add/RemoveProperty calls and PropertyAdded/Removed signals to allow =

platform/application specific properties of type string? Use cases =

include marking connections as preferred/default or assigning priorities =

to them, tracking the origin of the context (OTA, local provision or =

manually edited) and who knows what else.

Regards,
-Slava

--===============0063740059692122333==--

