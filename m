Content-Type: multipart/mixed; boundary="===============7107096841579067374=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 1/1] atmodem: add ifx support for pin retries query
Date: Mon, 17 Jan 2011 22:47:21 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802D5A420@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTikRMh02YxQww1ZxFwSTO6_OkM4=JV-b+COgH+eH@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7107096841579067374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

Lucas De Marchi wrote:
> this happens to work for -1, but bear in mind memset "fills
> the first  n bytes of the memory area". Considering
> sizeof(int) =3D=3D 4, it will set each byte to -1, which happens
> to be -1 considering all 4 bytes too. But imo this is just
> being lucky.
> =

> In my first version I had the same as you and Denis asked me
> to use a for loop.

I'll use for loop instead of using memset.

>> + =C2=A0 =C2=A0 =C2=A0 if (cbd =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE=
(cb, NULL, data); + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
>> return; + =C2=A0 =C2=A0 =C2=A0 }
>> =

>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cbd =3D=3D NULL) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 CALLBACK_WITH_FAILURE(cb, NULL, data); + =C2=A0 =C2=A0
>> switch (sd->vendor) { + =C2=A0 =C2=A0 =C2=A0 case OFONO_VENDOR_IFX:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_at_chat_send(sd=
->chat, "AT+XPINCNT", +
>> xpincnt_prefix, + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 xpincnt_cb,
>> cbd, g_free) > 0) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 case OFONO_VENDOR_HUAWEI:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (g_at_chat_sen=
d(sd->chat, "AT^CPIN?",
>> huawei_cpin_prefix, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
>> huawei_cpin_cb, cbd, g_free) > 0) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>> =

>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
>> -
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE=
(cb, NULL, data);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>> -
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for(i =3D 0; i < OFON=
O_SIM_PASSWORD_INVALID; i++)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 retries[i] =3D -1;
>> -
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_SUCCESS=
(cb, retries, data); + =C2=A0 =C2=A0 =C2=A0 =C2=A0
>> break; =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> +
>> + =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, NULL, data);
> =

> If vendor is not huawei nor ifx, why are we bothering to
> allocate cbd and free it afterwards without using?
> =


Most of the vendors provide own commands for reading the sim pin
retry count. Currently, we are handling 2vendors. If the number grows,
then we will end up in having allocation code for each case. If its not
going to be the case, then I can move the code inside each case.

> This also changes the semantics to return a failure if it's
> not implemented. I'm not against since this version seems to
> be clearer.
> However you might want to change src/sim.c:sim_pin_retries_query_cb()
> so it doesn't call ofono_error() in this case.
> =


If its not implemented, then we should term it as error. I don't see
any change needed in the current src/sim.c:sim_pin_retries_query_cb() code.

Regards,
jeevaka

--===============7107096841579067374==--

