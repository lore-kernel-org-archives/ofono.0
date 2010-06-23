Content-Type: multipart/mixed; boundary="===============1822313424763800986=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/8] stk: Allow registering proactive command handlers.
Date: Thu, 24 Jun 2010 00:08:54 +0200
Message-ID: <AANLkTind6fb7DgJr3yQY_Qu1W-6eiJPQGvjPlfExXw6d@mail.gmail.com>
In-Reply-To: <201006231444.30791.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1822313424763800986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 23 June 2010 21:44, Denis Kenzior <denkenz@gmail.com> wrote:
>> + =C2=A0 =C2=A0 struct stk_command *pending_cmd;
>> =C2=A0};
>>
>> +static void stk_respond(struct ofono_stk *stk,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct stk_response *rsp, generic_cb_t cb)
>> +{
>> + =C2=A0 =C2=A0 struct ofono_error error =3D { .type =3D OFONO_ERROR_TYP=
E_FAILURE };
>> + =C2=A0 =C2=A0 const guint8 *tlv;
>> + =C2=A0 =C2=A0 unsigned int tlv_len;
>> +
>> + =C2=A0 =C2=A0 rsp->src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL;
>> + =C2=A0 =C2=A0 rsp->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
>> + =C2=A0 =C2=A0 rsp->number =3D stk->pending_cmd->number;
>> + =C2=A0 =C2=A0 rsp->type =3D stk->pending_cmd->type;
>> + =C2=A0 =C2=A0 rsp->qualifier =3D stk->pending_cmd->qualifier;
>> +
>> + =C2=A0 =C2=A0 if (stk->driver->terminal_response =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cb(&error, stk);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>
> What do you think of returning an int here (e.g. -ENOTSUPPORTED) instead =
of
> calling a callback? =C2=A0I think that would make things a bit cleaner.

In that case can I use another function to wrap stk_respond? :)  The
reason I added this wrapper around driver->terminal_response is to
avoid repeating the same sequence everywhere.  If the caller needs to
check the return value from stk_respond then you have lots of
repetition again, the error handling will look the same in every case.

Regards

--===============1822313424763800986==--

