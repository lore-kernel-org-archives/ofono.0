Content-Type: multipart/mixed; boundary="===============8234372387579225897=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v1 0/6] handsfree-audio: Add Agent NewConnection()
Date: Tue, 05 Mar 2013 14:38:20 -0600
Message-ID: <513657BC.3050804@gmail.com>
In-Reply-To: <CAKT1EBezfORJSbDWAgSgcThBKg449ZnZHBqkMPN6L9b-a_ZmTA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8234372387579225897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

>>
>> I applied this series.  I did re-order and split the patches to be in
>> accordance to our patch submission guidelines.  Please refer to the HACK=
ING
>> document for more details.
>>
>
> I thought that taking care not to break compilation was more
> important. Sometimes I avoid to split patches to avoid breaking the
> compilation. Especially when it is necessary to change header files.
>

Understandable, however we actually optimize the other way.  Because all =

patches are thoroughly reviewed we tend not to need git bisect often. =

In situations like these the primary goal is to still follow the general =

patch submission guidelines.  e.g. breaking up patches per directory. =

The secondary goal is to keep git bisect happy if at all possible.  If =

it is not, then you are allowed to break it.

The rules of thumb are
1. Break up patches appropriately (e.g. in line with HACKING)
2. When adding new code everything must compile individually
3. When refactoring code (which should not happen often), try very hard =

to do same as 2.

Regards,
-Denis

--===============8234372387579225897==--

