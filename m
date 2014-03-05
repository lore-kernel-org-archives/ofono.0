Content-Type: multipart/mixed; boundary="===============2595005509540099031=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 10:32:23 -0600
Message-ID: <53175197.4090304@gmail.com>
In-Reply-To: <5316F0C1.60501@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2595005509540099031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 03/05/2014 03:39 AM, Slava Monich wrote:
>
>>> 3. No way to associate additional APN properties with a gprs_context.
>>>
>>> apns-conf.xml has many additional APN attributes which don't map
>>> directly to gprs_context properties ( eg. authtype, mvno_type, ... ).
>>>
>>
>> If you have usecases in mind for some of these properties, feel free
>> to suggest extensions to the oFono API.
>>
>
> What do you think about extending org.ofono.ConnectionContext API with
> Add/RemoveProperty calls and PropertyAdded/Removed signals to allow
> platform/application specific properties of type string? Use cases
> include marking connections as preferred/default or assigning priorities
> to them, tracking the origin of the context (OTA, local provision or
> manually edited) and who knows what else.
>

There are practical considerations that make this a bad idea, e.g. =

security concerns or the fact that our dbus bindings do not handle =

dynamic properties.  Putting that aside...

Your suggestion would be completely against our three core design =

values, e.g. "Minimal and Complete"; "Consistent" and "Easy to Use".

I'm open to adding additional properties the "old way" if you can argue =

good use cases for them.

Regards,
-Denis


--===============2595005509540099031==--

