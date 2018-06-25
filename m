Content-Type: multipart/mixed; boundary="===============0843194485328525185=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH 01/12] include: Expose voicecall related enums to plugins
Date: Mon, 25 Jun 2018 20:32:36 +0300
Message-ID: <74cffa7f-43f4-bdbc-2be3-066533b99d09@jolla.com>
In-Reply-To: <71ec295d-001b-1f8b-cc67-37cc12fde5fd@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0843194485328525185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 25/06/18 18:40, Denis Kenzior wrote:
> Hi Slava,
>
> On 06/21/2018 12:20 PM, Slava Monich wrote:
>> ---
>> =C2=A0 include/types.h | 31 +++++++++++++++++++++++++++++++
>> =C2=A0 1 file changed, 31 insertions(+)
>>
>
> Can you help me understand what is the motivation behind this?=C2=A0 In t=
he =

> past we opted not to expose OFONO enums for well-known values (e.g. =

> those defined in 27.007).

Obviously I didn't know that it was a conscious decision. Feel free to =

ignore all those patches then. It's just I have very low tolerance to =

duplicate definitions and magic numbers.

common.h is not available to dynamically loadable plugins built against =

ofono devel package.

Also, enum ofono_clir_option (which seems to be a 27.007 thing too) is =

defined in include/types.h which is a bit inconsistent.

Oh well.

-S.

--===============0843194485328525185==--

