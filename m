Content-Type: multipart/mixed; boundary="===============6777145578881766879=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v3 2/3] emulator: add drivers to request/release private
 network from ConnMan
Date: Thu, 05 May 2011 03:46:16 -0500
Message-ID: <4DC263D8.2000308@gmail.com>
In-Reply-To: <4DC26214.8040400@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6777145578881766879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>>> +int ofono_emulator_network_driver_register(
>>> +            const struct emulator_network_provision_driver *d);
>>> +void ofono_emulator_network_driver_unregister(
>>> +            const struct emulator_network_provision_driver *d);
>>> +
>> And then add __ofono_private_network_request / release to src/ofono.h
>> for now.  Similar to how gprs_provision does things.
> =

> Should we add a new src into ofono that would implement those
> request/release functions and register the ofono_private_network_driver?
> Something like private-network-provision.c?
> Then we would have the driver and callback type definition into
> private-network-provision.h.
> =


Yep, I think that would be best.  Call it private-network.c for now.

Regards,
-Denis

--===============6777145578881766879==--

