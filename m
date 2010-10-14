Content-Type: multipart/mixed; boundary="===============0377670263911146676=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 0/3] Patch Description
Date: Thu, 14 Oct 2010 06:23:49 -0500
Message-ID: <4CB6E845.7030605@gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A473301905B3@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0377670263911146676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 10/14/2010 06:17 AM, Gu, Yang wrote:
> Hi Denis,
> =

> =

>>> Then we set the path of script and run the script with its name
>>> dbus-send --system --print-reply --dest=3Dorg.phonesim /
>> org.phonesim.Script.SetPath string:/tmp/call
>>> dbus-send --system --print-reply --dest=3Dorg.phonesim / org.phonesim.S=
cript.Run
>> string:call.js
>>>
>>
>> One of the changes I made was to have phonesim register to the system
>> bus.  This makes the above DBus configuration file unnecessary.  Running
>> phonesim on the system bus was too much of a security risk, and wasn't
>> really needed.
>>
> =

> Thanks for the modifications afterward, and I'm fine with most of them. O=
ne question is why you renamed the service name to "org.ofono.phonesim". I =
wonder why the phonesim should have relationship with ofono?

In theory the service name should be related to the project website /
domain name.  Since we do not own org.phonesim, we put it on the
org.ofono prefix.

Regards,
-Denis

--===============0377670263911146676==--

