Content-Type: multipart/mixed; boundary="===============4516438153773603425=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH] gprs: Make the ContextAdded return a variant.
Date: Tue, 22 Dec 2015 07:11:41 +0000
Message-ID: <5678F7C8.6020900@actia.se>
In-Reply-To: <56785B04.1060802@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4516438153773603425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dennis,

On 12/21/2015 09:03 PM, Denis Kenzior wrote:
> Hi John,
>
> On 12/21/2015 04:10 AM, John Ernberg wrote:
>> From: John Ernberg <john.ernberg@actia.se>
>>
>> This matches the behavior described by the documentation and the signal
>> value described in the introspection. This was causing a headache when
>> using stricter D-Bus wrappers like dbus-c++.
>> ---
>>   src/gprs.c | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>
> Hmm, this appears to be a bug in the introspection data.  The =

> signature should be:
>
> "ContextAdded", GDBUS_ARGS({ "path", "o" }, { "properties", "a{sv}" })
>
> similar to how MessageManager.MessageAdded is done.
>
> Regards,
> -Denis
Alright. I will re-create the patch to change the introspection data =

instead.

Best regards // John Ernberg
--===============4516438153773603425==--

