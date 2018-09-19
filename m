Content-Type: multipart/mixed; boundary="===============8685566672726252594=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH 1/7] extended support for LTE and NR. Some minor fixes.
 part 1 of 7
Date: Thu, 20 Sep 2018 02:14:59 +0300
Message-ID: <49ad6936-1138-996e-5bcb-48f421e1b371@jolla.com>
In-Reply-To: <ab528817-cb1b-e0fd-0ec5-be9abbdf0884@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8685566672726252594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 20/09/18 00:45, Denis Kenzior wrote:
>> (ANY =3D PAP_CHAP, and don't ask me why we added new values to the =

>> beginning of the enum - it was before we started using binary =

>> plugins). I would be more than happy if upstream started to use the =

>> same enum!
>>
>
> That assumes that we should support your METHOD_ANY thing.=C2=A0 I've not =

> heard any good arguments for that yet...

At least one Chinese modem I dealt with had AT+ EGPAU =3D <op>,<cid>, =

<proto> where <proto> is 0 for PAP, 1 for CHAP, 2 for NONE and 3 for =

PAP_CHAP. Also, Android RIL interface has value 3 reserved for PAP&CHAP =

(see ril.h for older Androids and ApnAuthType in binder radio interface =

for Android 8+). To me that sounds like a valid use case.

-Slava

--===============8685566672726252594==--

