Content-Type: multipart/mixed; boundary="===============8514058500968808615=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: status-report expiration
Date: Tue, 07 Sep 2010 09:19:17 -0500
Message-ID: <4C8649E5.4040505@gmail.com>
In-Reply-To: <201009061910.18720.petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8514058500968808615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 09/06/2010 11:10 AM, Petteri Tikander wrote:
> Hi Denis,
> =

> I'm implementing expiration-logic for status report and have couple of =

> questions. =

> =

> My expiration function under development goes through every =

> addresses and corresponding messages (nodes) from hash-tables, and checks =

> the expiration time. But when finding expired message, it cannot remove =

> corresponding backup-files, because in this moment backup-file contains t=
he =

> whole sms-addressing information (address+numbering plan+number type), bu=
t key =

> of the hash-table (sms-address) doesn't. So, first I thought simply to ad=
d also =

> numbering plan+number type in the hash-key. So what do you think, could i=
t be =

> a good idea (to include the complete address, but to waste more memory)? =
OK, I =

> can also change the function to find backup-file by not taking into accou=
nt =

> numbering plan+number type at all. For example, I can go through backup-f=
iles, =

> capture just the sms-address (and message-id), and then search the correc=
t =

> node from the hash-table (not necessarily nice solution).

oFono supports sending SMS messages only to international (prefixed by
+) or 'unknown' (not prefixed by +) numbers.  So you can actually easily
figure out the ton/npi and number based on the address string.  This is
in effect what sms_address_to_hex_string does...

> =

> The another question is: is it enough in this moment just to implement =

> expiration function (and some unit-tests), as in existing sms-assembly =

> solution, when waiting for incoming sms-delivery messages? Seems that in =
the =

> case of sms-assembly, expiration-status for all messages is polled in som=
e =

> interval. So, possibly you have already earlier discussed about this issu=
e, =

> but how expiration-checking is signaled to sms-util? Will oFono-api take =
care =

> internally of triggering the expiration-status some how? Or, will oFono-a=
pi =

> receive expiration-checking calls outside oFono via D-bus.
> =


For now it is enough just to implement the expiration function and a
unit test.  We still need to hook this up into the core somewhere.  Most
likely it will be a 24 hour timer and we'll also run expiration at
startup if more than 24 hours have elapsed since the last check.

e.g. something like:
LastExpiration =3D settings.LastExpiration
if (LastExpiration - now > 24 hours)
	run expiration
	LastExpiration =3D now

set timer until LastExpiration + 24 hours.

Regards,
-Denis

--===============8514058500968808615==--

