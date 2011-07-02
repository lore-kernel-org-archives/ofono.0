Content-Type: multipart/mixed; boundary="===============2798958777036752762=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH 3/3] bluetooth: fix not removing data when
 devices/adapters are removed
Date: Sat, 02 Jul 2011 22:04:33 +0300
Message-ID: <CABBYNZK0qHdWQNrQwog7kFPA-tVGqU2tzaKAzBeJ=e=AH_s2tA@mail.gmail.com>
In-Reply-To: <4E0D838C.9000304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2798958777036752762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Jul 1, 2011 at 11:21 AM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Luiz,
>
> On 07/01/2011 02:12 AM, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> If an adapter or device is removed any data associate should be removed,
>> otherwise the next time they appear/are created the drivers may not
>> asssociate again.
>> ---
>> =C2=A0plugins/bluetooth.c | =C2=A0 79 ++++++++++++++++++++++++++++++++++=
++--------------
>> =C2=A0plugins/bluetooth.h | =C2=A0 =C2=A04 +-
>> =C2=A0plugins/hfp_hf.c =C2=A0 =C2=A0| =C2=A0 30 ++++++++++++-------
>> =C2=A03 files changed, 78 insertions(+), 35 deletions(-)
>
> Patch looks good, just one quick question:
>
>> @@ -443,25 +443,33 @@ free:
>> =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> =C2=A0}
>>
>> -static gboolean hfp_remove_each_modem(gpointer key, gpointer value,
>> +static gboolean hfp_remove_modem(gpointer key, gpointer value,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpointer use=
r_data)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct ofono_modem *modem =3D value;
>> + =C2=A0 =C2=A0 const char *device =3D key;
>> + =C2=A0 =C2=A0 const char *prefix =3D user_data;
>> +
>> + =C2=A0 =C2=A0 if (prefix && g_str_has_prefix(device, prefix) =3D=3D FA=
LSE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRUE;
>
> Are you sure you want to return TRUE here? =C2=A0By my reading TRUE shoul=
d be
> removed only if the key should be removed. =C2=A0That seems not to be what
> you want...

Yep, gonna fix it in v2, thanks for the quick review.


-- =

Luiz Augusto von Dentz

--===============2798958777036752762==--

