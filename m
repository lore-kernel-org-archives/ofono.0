Content-Type: multipart/mixed; boundary="===============7169358219361912927=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH 1/2] include: Add ofono_modem_get_voicecall
Date: Mon, 02 Jul 2018 20:13:37 +0300
Message-ID: <cb8a1227-1931-d01f-76b0-36ff77d525df@jolla.com>
In-Reply-To: <9ffd8d08-0ca9-00f7-f49e-7c482039bd86@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7169358219361912927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02/07/18 18:34, Denis Kenzior wrote:
> Hi Slava,
>
> On 06/29/2018 08:57 AM, Slava Monich wrote:
>> ---
>> =C2=A0 include/modem.h | 2 ++
>> =C2=A0 1 file changed, 2 insertions(+)
>>
>> diff --git a/include/modem.h b/include/modem.h
>> index 005a42e..bed46c2 100644
>> --- a/include/modem.h
>> +++ b/include/modem.h
>> @@ -31,6 +31,7 @@ extern "C" {
>> =C2=A0 struct ofono_modem;
>> =C2=A0 struct ofono_gprs;
>> =C2=A0 struct ofono_sim;
>> +struct ofono_voicecall;
>> =C2=A0 =C2=A0 enum ofono_modem_type {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OFONO_MODEM_TYPE_HARDWARE =3D 0,
>> @@ -84,6 +85,7 @@ void ofono_modem_remove_interface(struct =

>> ofono_modem *modem,
>> =C2=A0 const char *ofono_modem_get_path(struct ofono_modem *modem);
>> =C2=A0 struct ofono_sim *ofono_modem_get_sim(struct ofono_modem *modem);
>> =C2=A0 struct ofono_gprs *ofono_modem_get_gprs(struct ofono_modem *modem=
);
>> +struct ofono_voicecall *ofono_modem_get_voicecall(struct ofono_modem =

>> *modem);
>> =C2=A0 =C2=A0 void ofono_modem_set_data(struct ofono_modem *modem, void =
*data);
>> =C2=A0 void *ofono_modem_get_data(struct ofono_modem *modem);
>>
>
> I went ahead and applied this one.=C2=A0 But if we need any more of these=
 I =

> would seriously consider exposing __ofono_atom_find to the public API =

> instead.
>


I kind of like these getters for type safety but it's all up to you of =

course.

Regards,
-Slava

--===============7169358219361912927==--

