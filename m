Content-Type: multipart/mixed; boundary="===============1024539058516662395=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: Plugin infrastructure
Date: Mon, 05 Feb 2018 19:25:38 +0300
Message-ID: <9c99df54-92ec-6960-9e2e-2c16a21df6ef@jolla.com>
In-Reply-To: <d13d203d-404a-bd2a-6962-ef973a1b949e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1024539058516662395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi Jonas,
>
> On 02/04/2018 11:19 AM, Jonas Bonn wrote:
>> Hi,
>>
>> I was reading through the ofono code and I see that there's a lot of =

>> code in place to support external plugins.=C2=A0 As things currently =

>> stand, however, ofono can only be built with _builtin_ modules, so =

>> all this plugin infrastructure is totally unused. So I had a couple =

>> of questions about this:
>>
>> i)=C2=A0 Is there any value in keeping the plugin infrastructure in plac=
e? =

>> ...or would an effort to remove it be valued?
>
> We did (still do?) have external plugins in use...

Yes, we do!

If upstream eliminates the plugin system, we would still have to =

maintain it in our fork. At the moment we are using it more or less as is.

Cheers,
-Slava

--===============1024539058516662395==--

