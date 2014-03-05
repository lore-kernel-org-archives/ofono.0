Content-Type: multipart/mixed; boundary="===============4712859457252166959=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 19:37:51 +0200
Message-ID: <531760EF.6040203@jolla.com>
In-Reply-To: <53175197.4090304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4712859457252166959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> What do you think about extending org.ofono.ConnectionContext API with
>> Add/RemoveProperty calls and PropertyAdded/Removed signals to allow
>> platform/application specific properties of type string? Use cases
>> include marking connections as preferred/default or assigning priorities
>> to them, tracking the origin of the context (OTA, local provision or
>> manually edited) and who knows what else.
>>
>
> There are practical considerations that make this a bad idea, e.g. =

> security concerns or the fact that our dbus bindings do not handle =

> dynamic properties.  Putting that aside...
>
> Your suggestion would be completely against our three core design =

> values, e.g. "Minimal and Complete"; "Consistent" and "Easy to Use".
>
> I'm open to adding additional properties the "old way" if you can =

> argue good use cases for them.

A couple of examples.

Suppose, we have a UI that allows the user to switch between "Automatic" =

and "Custom" MMS or GPRS settings. One of the ways to implement that =

would be to create a new context marked as "manual" and allow the user =

to edit it. The old context remains but it's marked as "automatic" or =

whatever. Manual context has a precedence over the automatic one. =

Switching back to automatic means destroying the "manual" context or =

marking it as "disabled". All that stuff gets saved to the ofono =

SIM-specific gprs file so that these context properties don't get lost =

after swapping SIMs.

Suppose, we have a different connection management system, which shows =

the entire list of available access points to the user and allows to =

choose which one to use. The selected context needs to be marked as =

"default" or something. Again, this context property needs to survive =

SIM swap. With a custom context property that's pretty easy to do.

Every project may have requirements that are more or less unique, often =

influenced by the UI design. There's no need to push support for unique =

project specific requirements into the common code, there's nothing here =

to argue about. It's a matter of whether you want to make ofono a bit =

more usable as is or you are fine with it being cloned and heavily =

modified for each particular project.

Regards,
-Slava

--===============4712859457252166959==--

